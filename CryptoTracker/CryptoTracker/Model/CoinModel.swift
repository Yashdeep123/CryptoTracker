//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Yash Patil on 22/08/22.
//

import Foundation

struct CoinModel : Identifiable,Codable
{
    /*
    URL:
     https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
     */
    
    var id,symbol,name,image : String
    let current_price : Double
    let market_cap,market_cap_rank,fully_diluted_valuation,total_volume,high_24h,low_24h : Double?
    let price_change_24h,price_change_percentage_24h,market_cap_change_24h,market_cap_change_percentage_24h : Double?
    let circulating_supply,total_supply,max_supply : Double?
    let ath : Double?
    let ath_change_percentage : Double?
    let ath_date : String?
    let atl : Double?
    let atl_change_percentage : Double?
    let atl_date : String?
    let last_updated : String
    let sparkline_in_7d : SparklineIn7D?
    let price_change_percentage_24h_in_currency : Double?
    let currentHoldings : Double?

    
    func updateHoldings(amount: Double) -> CoinModel
    {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, current_price: current_price, market_cap: market_cap, market_cap_rank: market_cap_rank, fully_diluted_valuation: fully_diluted_valuation, total_volume: total_volume, high_24h: high_24h, low_24h: low_24h, price_change_24h: price_change_24h, price_change_percentage_24h: price_change_percentage_24h, market_cap_change_24h: market_cap_change_24h, market_cap_change_percentage_24h: market_cap_change_percentage_24h, circulating_supply: circulating_supply, total_supply: total_supply, max_supply: max_supply, ath: ath, ath_change_percentage: ath_change_percentage, ath_date: ath_date, atl: atl, atl_change_percentage: atl_change_percentage, atl_date: atl_date, last_updated: last_updated, sparkline_in_7d: sparkline_in_7d, price_change_percentage_24h_in_currency: price_change_percentage_24h_in_currency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * current_price
    }
    var rank: Int {
        return Int(market_cap_rank ?? 0)
    }
    
}
struct SparklineIn7D : Codable
{
    let price : [Double]?
}
