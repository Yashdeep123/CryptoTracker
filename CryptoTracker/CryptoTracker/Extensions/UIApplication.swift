//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Yash Patil on 25/08/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing () {
        
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil,for: nil)
    }
}
