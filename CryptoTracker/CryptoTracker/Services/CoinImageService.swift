//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Yash Patil on 24/08/22.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image : UIImage? = nil
    
    private var imageSubscription  : AnyCancellable?
    private let coin : CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "Coin_Images"
    private let imageName :String
    
    init(coin:CoinModel)
    {
        self.coin = coin
        self.imageName = coin.id
        getCoinImageFromDirectory()
    }
    
    private func getCoinImageFromDirectory() {
        
        if let savedImage = fileManager.getImage(imageName: imageName,folderName: folderName) {
            image = savedImage
            
        }
        else {
            downloadCoinImage()
            print("Downloading Images...")
        }
        
    }
    
    private func downloadCoinImage()
    {
        guard let url = URL(string: coin.image)else {return }
        imageSubscription = NetworkManager.downloadData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion:  NetworkManager.handleCompletion
                  , receiveValue: { [weak self] (returnedImage) in
                guard let self = self,let returnedImage = returnedImage else {return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: returnedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
