//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 22/08/22.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconSysName : String
    
    var body: some View {
        Image(systemName: iconSysName)
            .font(.headline)
            .foregroundColor(.theme.accentColor)
            .frame(width: 50, height: 50)
            .background(
            Circle()
                .foregroundColor(.theme.backgroundText)
            )
            .shadow(color: .theme.accentColor.opacity(0.25),
                    radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        CircleButtonView(iconSysName: "plus")
            .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconSysName: "info")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
