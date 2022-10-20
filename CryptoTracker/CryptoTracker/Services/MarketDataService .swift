//
//  MarketDataService .swift
//  CryptoTracker
//
//  Created by Yash Patil on 30/08/22.
//

import Foundation
import Combine
import SwiftUI


class MarketDataService {
    
    @Published var allMarketData : MarketDataModel? = nil
    
    var MarketDataSubscription : AnyCancellable?
    
    init()
    {
        getMarketData()
    }
    
    
    func getMarketData()  {
         
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global" ) else { return }
        
        
        MarketDataSubscription = NetworkManager.downloadData(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(
                  receiveCompletion:  NetworkManager.handleCompletion ,
                  receiveValue: { [weak self] (returnedGlobalData) in
                
                self?.allMarketData = returnedGlobalData.data
                self?.MarketDataSubscription?.cancel()
                
            })
        
    }
}
