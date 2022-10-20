//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Yash Patil on 19/08/22.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State  var showLaunchView : Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
    }
    var body: some Scene {
        
        WindowGroup {
            ZStack {
                NavigationView
                {
                    HomeView()
                        .navigationBarHidden(true)
                        .preferredColorScheme(.dark)
                }.environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }.zIndex(2.0)
            }
        }
    }
}
