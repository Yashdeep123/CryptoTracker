//
//  String.swift
//  CryptoTracker
//
//  Created by Yash Patil on 23/09/22.
//

import Foundation


extension String {
    
    var removingHTMLOccurences : String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression)
    }
}
