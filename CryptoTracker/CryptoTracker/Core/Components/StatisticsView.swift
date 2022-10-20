//
//  StatisticsView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 26/08/22.
//

import SwiftUI

struct StatisticsView: View {
    
    let stat1 : StatisticsModel
    
    var body: some View {

        VStack(alignment:.leading,spacing:4)
        {
            Text(stat1.title)
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(stat1.value)
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
            
            
            HStack{
                
                Image(systemName:"triangle.fill")
                    .font(.caption)
                    .rotationEffect(
                        Angle(degrees: (stat1.percentage_change ?? 0) >= 0 ? 0 : 180))
                
                Text(stat1.percentage_change?.asPercentString ?? "")
                    .font(.headline)
                    .bold()
            }
            .foregroundColor((stat1.percentage_change ?? 0) >= 0 ? Color.theme.green : .theme.red)
            .opacity(stat1.percentage_change == nil ? 0.0 : 1.0)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
    
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticsView(stat1: dev.stat1)
            StatisticsView(stat1: dev.stat2)
            StatisticsView(stat1: dev.stat3)
        }.previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        
    }
}
