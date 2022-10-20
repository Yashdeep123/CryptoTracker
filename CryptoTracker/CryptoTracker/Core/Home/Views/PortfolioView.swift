//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 31/08/22.
//

import SwiftUI

struct PortfolioView: View {
    
    
    @EnvironmentObject private var vm : HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedCoins : CoinModel? = nil
    @State private var quantity : String =  ""
    @State private var showcheckmark : Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoins != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: { Image(systemName : "xmark")
                        .font(.headline) }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    TrailingButton
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(HomeViewModel())
    }
}


extension PortfolioView {
     
    private var coinLogoList : some View {
        ScrollView(.horizontal,showsIndicators:false) {
            LazyHStack(spacing:13) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                            selectedCoins = coin
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoins?.id == coin.id ? Color.theme.green : Color.clear,lineWidth: 1)
                        )
                }
            
            }
            .frame(height:120)
            .padding(.leading)
      }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantity) {
            return quantity * (selectedCoins?.current_price ?? 0)
        }
        return 0
    }
    
    
    private func updateSelectedCoin(coin: CoinModel) {
        if let portfolio = vm.portfolioCoins.first(where:{$0.id == coin.id}),
           let amount = portfolio.currentHoldings {
            quantity = "\(amount)"
        } else {
            quantity = ""
        }
    }
    
    
    private var portfolioInputSection :  some View {
        
        VStack(spacing:20) {
            HStack {
                Text("Current Price of \(selectedCoins?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoins?.current_price.asCurrencyWith5Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount in your portfolio")
                Spacer()
                TextField("Ex: 1.4", text: $quantity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
           HStack {
                Text("Current value:")
               Spacer()
               Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }.animation(.none)
        .padding(.horizontal)
        .font(.headline)
    }
    
    private var TrailingButton : some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showcheckmark ? 1.0 : 0.0)
            Button{
                saveButtonPressed()
            } label : {
            Text("Save".uppercased())
            }
            .opacity(selectedCoins != nil && selectedCoins?.currentHoldings != Double(quantity) ? 1.0 : 0.0)
        }
    }
    
    private func saveButtonPressed() {
        
        guard let coin = selectedCoins,
        let amount = Double(quantity) else {return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showcheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeIn) {
                showcheckmark = false
        }
    }
    
    
}
    private func removeSelectedCoin() {
        
        selectedCoins = nil
        vm.searchText = ""
    }
}
