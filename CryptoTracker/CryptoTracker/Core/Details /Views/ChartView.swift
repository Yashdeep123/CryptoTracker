//
//  CharView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 16/09/22.
//

import SwiftUI

struct ChartView: View {
    
    let data : [Double]
    let maxY:Double
    let minY : Double
    let lineColor: Color
    let startingDate : Date
    let endingDate : Date
    @State private var percentage : CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparkline_in_7d?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .theme.green : .theme.red
        
        endingDate = Date(coinGeckoString: coin.last_updated)
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    
    
    var body: some View {
        
        VStack{
            chartView
                .frame(height : 200)
                .background(chartBackground)
                .overlay(chartAxis.padding(.horizontal,4), alignment:.leading)
            HStack {
                Text(startingDate.asShortDateString())
                Spacer()
                Text(endingDate.asShortDateString())
            }
            .padding(.horizontal,4)
        }
        .font(.headline)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 3.5)) {
                    percentage = 1.0
                }
                
            }
        }
        
    }
}

struct CharView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
            
    }
}


extension ChartView {
    
    
    private var chartAxis : some View
    {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY)/2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
            
        }
    }
    private var chartBackground : some View {
        VStack
        {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
        
    }
    
    
    private var chartView : some View {
        GeometryReader { geo in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geo.size.width / CGFloat(data.count) *  CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY)) / yAxis) * geo.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to:CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from:0,to: percentage)
            .stroke(lineColor,style: StrokeStyle(lineWidth:3,lineCap: .round,lineJoin: .round))
            .shadow(color:lineColor,radius: 10,x:0,y:10)
        }
        
    }
}
