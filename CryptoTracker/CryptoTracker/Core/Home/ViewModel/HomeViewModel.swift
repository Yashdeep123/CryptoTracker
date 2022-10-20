//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Yash Patil on 24/08/22.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel : ObservableObject
{
     
    @Published var statistics : [StatisticsModel] = []
    @Published var isLoading : Bool = false
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var sortOptions : SortOption = .holdings
    
    private let coindataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    private let marketDataServices = MarketDataService()
    private let portfolioDataServices = PortfolioDataService()
    
    init() {
        addSubscribers()
        }
    
     func addSubscribers()
    {
        // Updates allCoins
        
        $searchText
            .combineLatest(coindataService.$allCoins,$sortOptions)
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .map(FilteredAndSortedCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            
            }.store(in: &cancellables)
        
        
        // Updates portfolio Coins
        
        $allCoins
            .combineLatest(portfolioDataServices.$savedEntities)
            .map(mapAllCoinsToPortfolio)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        // Updates marketData
        
        marketDataServices.$allMarketData
            .combineLatest($portfolioCoins)
            .map(mapGLobalMarketData)
            .sink { [weak self] (returnedData) in
                self?.statistics = returnedData
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    enum SortOption {
        case rank,rankReversed,holdings,holdingsReversed,price,priceReversed
    }
    
    func updatePortfolio(coin : CoinModel, amount : Double) {
        portfolioDataServices.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coindataService.getCoins()
        marketDataServices.getMarketData()
    }
    
    
    private func mapAllCoinsToPortfolio(coins : [CoinModel],portfolio : [PortfolioEntity]) -> [CoinModel] {

           coins
               .compactMap { Coin -> CoinModel? in
                   guard let entity = portfolio.first(where: {$0.coinID == Coin.id }) else {return nil}
                   return Coin.updateHoldings(amount: entity.amount)
               }
    }
    
    private func FilteredAndSortedCoins(searchedText : String, returnedCoins : [CoinModel],sort : SortOption) -> [CoinModel] {
        
        var updatedCoins = FilteredCoins(searchedText: searchedText, returnedCoins: returnedCoins)
        sortedCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    
    private func FilteredCoins(searchedText : String,returnedCoins : [CoinModel]) -> [CoinModel] {
        
        guard !searchedText.isEmpty else {return returnedCoins}
        let lowercaseText = searchedText.lowercased()
        
        let filteredCoins = returnedCoins.filter { coin -> Bool in
          return  coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
                
            }
       return filteredCoins
    }
    
    private func sortedCoins(sort: SortOption,coins: inout [CoinModel] ) {
        
        switch sort {
        case .rank,.holdings:
            coins.sort(by: {$0.rank < $1.rank} )
        case .rankReversed,.holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank} )
        case .price:
            coins.sort(by:{$0.current_price > $1.current_price})
        case .priceReversed:
            coins.sort(by:{$0.current_price < $1.current_price})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOptions {
        case .holdings : return coins.sorted(by:{$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed : return coins.sorted(by:{$0.currentHoldingsValue < $1.currentHoldingsValue})
        default : return coins
        }
    }
    
    private func mapGLobalMarketData(marketData : MarketDataModel?,portfolioCoins : [CoinModel]) -> [StatisticsModel] {
        
        
            var stats = [StatisticsModel]()
            
            guard let data = marketData else { return stats }
            
            let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentage_change: data.marketCapChangePercentage24HUsd)
            let volumeCap = StatisticsModel(title: "24h Volume", value: data.Volume)
            
            let portfolioValue = portfolioCoins
                                      .map { $0.currentHoldingsValue }
                                      .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map {  (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.price_change_percentage_24h ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }.reduce(0, +)
        
        let percentageChange = (
            (portfolioValue - previousValue) / previousValue) * 100
        
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolio = StatisticsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentage_change: percentageChange)
            
            stats.append(contentsOf: [marketCap,volumeCap,btcDominance,portfolio])
            
            return stats
    }
}
