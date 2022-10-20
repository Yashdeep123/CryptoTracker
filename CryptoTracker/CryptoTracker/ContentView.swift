//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 19/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:40)
        {
            Text("Accent Color")
                .foregroundColor(Color.theme.accentColor)
            Text("Red Color")
                .foregroundColor(Color.theme.red)
            Text("Green Color")
                .foregroundColor(Color.theme.green)
             Text("Secondary Text")
                .foregroundColor(Color.theme.secondaryText)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
