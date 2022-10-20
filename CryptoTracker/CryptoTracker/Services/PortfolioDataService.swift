//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Yash Patil on 02/09/22.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName : String = "PortfolioContainer"
    private let entityName : String = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        
        // Loading persistent stores from NSPersistentContainer and completes the creation of the NSPersistent Stores. (Must be executed after the initialization.!!)
        
        container.loadPersistentStores { (_,error) in
            
            if let error = error {
                print("Error loading the stores in the container. \(error)")
            }
            else {print("Succesfully fetched the data")}
        }
        getportfolio()
    }
    
    public func updatePortfolio(coin: CoinModel,amount : Double) {
        
        if let entity = savedEntities.first(where: { $0.coinID == coin.id })
        {
            if amount > 0 {
                update(entity: entity, amount: amount)
            }
            else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    
        // Fetching request for Portfolio Entity name
    
  private  func getportfolio() {
      
      let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
      do {   // savedEntities contains an Array of PortfolioEntity
          // container is an instance of NSPersistentContainer
          savedEntities = try container.viewContext.fetch(request)
           
      } catch let error {
          print("ERROR FETCHING THE REQUEST FROM THE COREDATA. \(error)")
      }
    }
    
    private func add(coin : CoinModel,amount : Double) {
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity : PortfolioEntity,amount : Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity : PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        
        do
        {
            try container.viewContext.save()
        } catch let error {
            print("Error. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getportfolio()
    }
}
