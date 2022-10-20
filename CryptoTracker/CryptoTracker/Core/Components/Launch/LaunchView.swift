//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 30/09/22.
//

import SwiftUI

struct LaunchView: View {
    
    @State  var LoadingText : [String] = "Loading your portfolio...".map {String($0)}
    @State var showLoadingScreen : Bool = false
    @Binding var showLaunchView : Bool 
    @State  var counter = 0
    @State private var loops = 0
     var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.Launch.backgroundColor
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100,height: 100)
            ZStack {
                if showLoadingScreen {
                    HStack(spacing:0) {
                        ForEach(LoadingText.indices,id:\.self) { index in
                            Text(LoadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.Launch.accent)
                                .offset(y: index == counter ? -5 : 0)
                        }
                    }.transition(AnyTransition.scale.animation(.easeIn))
                }
                
            }.offset(y:70)
        }
        .onAppear{
            showLoadingScreen.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                if showLoadingScreen {
                    let lastIndex = LoadingText.count - 1
                    if counter == lastIndex  {
                        counter = 0
                        loops += 1
                        if loops >= 2 {
                            showLaunchView = false
                        }
                    }else {
                        counter += 1
                    }
                }
                
            }
        }
    }
    
    struct LaunchView_Previews: PreviewProvider {
        static var previews: some View {
            LaunchView(showLaunchView: .constant(false))
                .preferredColorScheme(.dark)
        }
    }
}
