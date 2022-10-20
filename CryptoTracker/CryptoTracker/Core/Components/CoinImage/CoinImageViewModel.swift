//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Yash Patil on 24/08/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService : CoinImageService
    private let coin : CoinModel
    
    init(coin : CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin:coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
   private func addSubscribers()
    {
        dataService.$image
            .sink { (_) in
                self.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
