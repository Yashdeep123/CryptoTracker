//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 23/09/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let youtubeURL = URL(string:"https://www.youtube.com/c/swiftfulthinking")!
    let defaultURL = URL(string: "https://www.google.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    
    
    var body: some View {
        NavigationView {
            List {
                
                SwiftfulThinkingSection
                
               CoinGeckoSection
            }
            .tint(.blue)
            .listStyle(SidebarListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button {
                        dismiss()
                    } label : {
                        Image(systemName : "xmark")
                            .font(.headline)
                    }
                }
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    
    
    private var CoinGeckoSection : some View {
        Section {
            
            VStack(alignment:.leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(height:100)
            
            Text("The cryptocurrency data which is used in this app are from the coingecko website , which is a free API and contains bunch of data you want to use in your app.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            Link(destination: coingeckoURL)
            {
                Text("Visit Coingecko")
            }.foregroundColor(.blue)
                
           
            } header: {
            Text("Coingecko")
            }
    }
    
    
    private var  SwiftfulThinkingSection : some View {
        Section {
            
            VStack(alignment:.leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 100,height:100)
            
            Text("This is the app CryptoTracker made by Yash Patil by following the courses by nick sarno on Youtube. It uses MVVM Architecture, Combine & CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            Link(destination: youtubeURL)
            {
                Text("Subscribe on Youtube 🥳")
            }.foregroundColor(.blue)
                
           
            } header: {
            Text("SwiftFul Thinking")
            }
    }
}
