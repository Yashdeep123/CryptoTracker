//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Yash Patil on 06/09/22.
//

import Foundation
import Combine

class CoinDetailService {
    
    @Published var coinDetails : CoinDetailModel? = nil
    
    let coin : CoinModel
    var coinDetailSubscription : AnyCancellable?
    
    init(coin : CoinModel) {
        self.coin = coin
        getCoinDetail()
    }
    
    func getCoinDetail() {
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
                
                
            coinDetailSubscription = NetworkManager.downloadData(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
