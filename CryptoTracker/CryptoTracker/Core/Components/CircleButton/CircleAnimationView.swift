//
//  CircleAnimationView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 22/08/22.
//

import SwiftUI

struct CircleAnimationView: View {
    
    @Binding var animate : Bool
    
    var body: some View {
          Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeInOut(duration: 1.0) : .none)
            
    }
}

struct CircleAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleAnimationView(animate: .constant(false))
    }
}
