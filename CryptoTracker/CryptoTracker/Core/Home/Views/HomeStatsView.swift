//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 26/08/22.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showportfolio : Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                
                StatisticsView(stat1: stat)
                    .frame(width : UIScreen.main.bounds.width / 3)
            }
        } .frame(width : UIScreen.main.bounds.width,alignment: showportfolio ? .trailing: .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showportfolio: .constant(false))
            .environmentObject(HomeViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
