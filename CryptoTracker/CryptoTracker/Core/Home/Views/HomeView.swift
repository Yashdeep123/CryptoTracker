//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 22/08/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm  : HomeViewModel
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioView : Bool = false
    @State private var sheetView : Bool = false
    @State private var selectedCoin : CoinModel? = nil
    @State private var showDetailView : Bool = false
    @State private var showSettingsView : Bool = false
    
    var body: some View {
        
        
        ZStack{
            Color.theme.backgroundText
                .ignoresSafeArea()
                .sheet(isPresented : $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            VStack(spacing:15)
            {
                TopView
                HomeStatsView(showportfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitle
                
                if !showPortfolio {
                allCoinsList
                        .transition(.move(edge: .leading))
                
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength:0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }.background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: { EmptyView()  })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        HomeView()
                .navigationBarHidden(true)
                .colorScheme(.dark)
        }
        .environmentObject(HomeViewModel())
            
    }
}


extension HomeView {
    
    private var TopView : some View {
        HStack
        {
            CircleButtonView(iconSysName: showPortfolio ? "plus" : "info" )
                
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                    else{
                        showSettingsView.toggle()
                    }
                }
                .background(
            CircleAnimationView(animate: $showPortfolio)
                )
                .animation(.none, value: 0)
           
        Spacer()
        Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .animation(.none)
        Spacer()
        CircleButtonView(iconSysName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                    showPortfolio.toggle()
                    vm.searchText = ""
                    }
                }
            
        }
    }
    
    private var allCoinsList : some View {
        
        List  {
            ForEach(vm.allCoins) {  coin in
                
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                    .onTapGesture {
                        segue(coin: coin)
                    }
                
            }
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
        }
        .listStyle(PlainListStyle())
        
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var portfolioCoinsList : some View {
        
        List{
            ForEach(vm.portfolioCoins) { coin in
            CoinRowView(coin: coin, showHoldingsColumn: true)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var columnTitle : some View {
        
        HStack {
            
            HStack(spacing:4) {
            Text("Coins")
           
            Image(systemName: "chevron.down")
                .opacity(vm.sortOptions == .rank || vm.sortOptions == .rankReversed ? 1.0 : 0.0)
                .rotationEffect(Angle(degrees:vm.sortOptions == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                vm.sortOptions = vm.sortOptions == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio {
                HStack(spacing:4) {
                
                    Text("Holdings")
                .animation(.none)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .holdings || vm.sortOptions == .holdingsReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                    vm.sortOptions = vm.sortOptions == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack(spacing:4) {
                
            Text("Prices")
            Image(systemName: "chevron.down")
                .opacity(vm.sortOptions == .price || vm.sortOptions == .priceReversed ? 1.0 : 0.0)
                .rotationEffect(Angle(degrees:vm.sortOptions == .price ? 0 : 180))
            }
            .frame(width : UIScreen.main.bounds.width / 3.5,alignment:.trailing)
            .onTapGesture {
                withAnimation(.default) {
                vm.sortOptions = vm.sortOptions == .price ? .priceReversed : .price
                }
            }
                Button {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reloadData()
                    }
                    
                } label: {
                    Image(systemName: "goforward")
                }.rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
            
        }
        .font(.caption)
        .foregroundColor(.theme.accentColor)
        .padding(.horizontal)
    }
}
