//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 23/08/22.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsColumn : Bool
    
    var body: some View {
        
        HStack(spacing:0)
        {
            LeftColumn
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
           RightColumn
           
        }
        .font(.subheadline)
        .background(
            Color.theme.backgroundText.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin,showHoldingsColumn: true)
            .preferredColorScheme(.dark)
    }
}



extension CoinRowView {
    
    private var LeftColumn : some View
    {
        HStack(spacing:0) {
        Text("\(coin.rank)")
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .frame(minWidth:30)
        CoinImageView(coin: coin)
            .frame(width: 30, height: 30)
        Text("\(coin.symbol.uppercased())")
            .padding(.leading,6)
            .foregroundColor(.theme.accentColor)
        }
    }
    
    
    private var RightColumn : some View
    {
        VStack(alignment:.trailing) {
            Text(coin.current_price.asCurrencyWith5Decimals())
                .bold()
                .foregroundColor(.theme.accentColor)
            Text(coin.price_change_percentage_24h?.asPercentString ?? "")
                .foregroundColor((coin.price_change_percentage_24h ?? 0) >= 0 ? .theme.green : .theme.red)
        }
        .frame(width:UIScreen.main.bounds.width / 3.5,alignment:.trailing)
    }
    
    private var centerColumn : some View
    {
        VStack(alignment:.trailing) {
        Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
        Text((coin.currentHoldings ?? 0).asNumberString)
        }.foregroundColor(.theme.accentColor)
    }
}
