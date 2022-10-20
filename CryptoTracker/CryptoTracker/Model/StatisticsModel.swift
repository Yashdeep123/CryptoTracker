//
//  StatisticsModel.swift
//  CryptoTracker
//
//  Created by Yash Patil on 26/08/22.
//

import Foundation

class StatisticsModel : Identifiable {
    
    
    let id = UUID()
    let title : String
    let value : String
    let percentage_change : Double?
    
    init(title:String,value:String,percentage_change : Double? = nil) {
        self.title = title
        self.value = value
        self.percentage_change = percentage_change
    }
}
