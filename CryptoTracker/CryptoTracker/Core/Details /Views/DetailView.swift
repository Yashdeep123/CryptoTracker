//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 05/09/22.
//

import SwiftUI


struct DetailLoadingView : View {
    
    @Binding var coin : CoinModel?
    
    var body : some View {
        
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    
    let coin : CoinModel
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let spacing : CGFloat = 30
    
    @State private var showFullDescription : Bool = false
    
    @StateObject var vm : DetailViewModel
    
    
    init(coin : CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin:coin))
        self.coin = coin
        print("Initializing detail View for  \(coin.name)...!")
    }
    
    var body: some View {
       
        ScrollView {
            VStack(spacing:20) {
                
               ChartView(coin: vm.coin)
               overviewTitle
               Divider()
               descriptionSection
               overviewGridDetails
               additionalTitle
               Divider()
               additionalGridDetails
                
            }.padding()
        }.navigationTitle(vm.coin.name)
        .toolbar {
            
                ToolbarItem(placement:.navigationBarTrailing) {
                    navigationBarTrailingItem
                }
                    
                
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin : dev.coin).preferredColorScheme(.dark)
    }
}



extension DetailView {
    
    private var descriptionSection : some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment:.leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut){
                            showFullDescription.toggle()
                        }
                    } label :{
                        Text(showFullDescription ? "Less":"Read more...")
                            .tint(.blue)
                    }
                }
            }
        }
    }
    private var navigationBarTrailingItem : some View
    {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle : some View {
        VStack {
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundColor(.theme.accentColor)
                .frame(maxWidth:.infinity, alignment:.leading)
        }
        .padding(.vertical,0)
            
        }
    
    
    
    private var additionalTitle : some View {
        VStack {
            
            Text("Additional Details")
                .font(.title)
                .bold()
                .foregroundColor(.theme.accentColor)
                .frame( maxWidth: .infinity, alignment: .leading)
          
           
        }
    }

private var overviewGridDetails :some View {
  
    VStack {
    LazyVGrid(
        columns: columns,
        alignment: .leading,
        spacing: spacing,
        pinnedViews: []) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticsView(stat1: stat)
                
            }
        }
    }
  }
    
    private var additionalGridDetails : some View {
        VStack {
            
            LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticsView(stat1: stat)
                    
                }
            }
        }
    }
}
