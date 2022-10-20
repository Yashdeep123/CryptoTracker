//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Yash Patil on 06/09/22.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    @Published  var overviewStatistics : [StatisticsModel] = []
    @Published  var additionalStatistics : [StatisticsModel] = []
    @Published  var coinDescription : String? = nil
    @Published  var websiteURL : String? = nil
    @Published var redditURL : String? = nil
    @Published  var coin : CoinModel
    private let coinDetailService : CoinDetailService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin : CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        self.addSubscribers()
        
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                print("Received Coin Details!!!")
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in : &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
        
        private func mapDataToStatistics(coinDetailModel : CoinDetailModel? , coinModel : CoinModel) -> (overview: [StatisticsModel], additional : [StatisticsModel])  {
           
              let overviewArray = createOverviewArray(coinModel: coinModel)
              let additionalArray = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
            
            return (overviewArray,additionalArray)
        }
    
   private  func createOverviewArray(coinModel : CoinModel) -> [StatisticsModel] {
        
        let price = coinModel.current_price.asCurrencyWith5Decimals()
        let pricePercentChange = coinModel.price_change_percentage_24h
        let priceStat = StatisticsModel(title: "Current Price", value: price,percentage_change: pricePercentChange)
        
        let marketCap = "$" + (coinModel.market_cap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.market_cap_change_percentage_24h
        let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap,percentage_change: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticsModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.total_volume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overviewStat : [StatisticsModel] = [
            priceStat,marketCapStat,rankStat,volumeStat
        ]
        return overviewStat
        
    }
    
  private  func createAdditionalArray(coinModel : CoinModel, coinDetailModel : CoinDetailModel?) -> [StatisticsModel] {
        
        let high = coinModel.high_24h?.asCurrencyWith5Decimals() ?? "n/a"
        let highStat = StatisticsModel(title: "24h High", value: high)
        
        let low = coinModel.low_24h?.asCurrencyWith5Decimals() ?? "n/a"
        let lowStat = StatisticsModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.price_change_24h?.asCurrencyWith5Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.price_change_percentage_24h
        let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange, percentage_change: pricePercentChange2)
        
        let marketCapChange = coinModel.market_cap_change_24h?.formattedWithAbbreviations() ?? "n/a"
        let marketCapPercentChange = coinModel.market_cap_change_percentage_24h
        let marketCapChangeStat = StatisticsModel(title: "24h market Cap Change", value: marketCapChange, percentage_change: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
    
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticsModel(title: "HashingAlgorithm", value: hashing)
        let additionalArray : [StatisticsModel] = [
        
            highStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat
        ]
        return additionalArray
    }
    
    
    }

