//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Yash Patil on 30/08/22.
//

import Foundation

/* JSON Data :
 
 URL :
 https://api.coingecko.com/api/v3/global
 
 Data :
 "data": {
     "active_cryptocurrencies": 12892,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 563,
     "total_market_cap": {
       "btc": 50821962.95024832,
       "eth": 654224757.8196652,
       "ltc": 18797596458.088852,
       "bch": 8722411766.130014,
       "bnb": 3580814829.8908815,
       "eos": 706775831864.2987,
       "xrp": 3123938442159.3384,
       "xlm": 9866083032128.428,
       "link": 153465792496.9891,
       "dot": 142846364175.3834,
       "yfi": 113283343.59426719,
       "usd": 1038129789224.0988,
       "aed": 3813061097118.0044,
       "ars": 143584312500266.78,
       "aud": 1494972298659.422,
       "bdt": 98532898209337.25,
       "bhd": 391321985918.23474,
       "bmd": 1038129789224.0988,
       "brl": 5220650897029.094,
       "cad": 1349071461822.2917,
       "chf": 1007357546011.9202,
       "clp": 916149538990268,
       "cny": 7164237488414.44,
       "czk": 25418823820148.227,
       "dkk": 7690422915250.753,
       "eur": 1034012566480.0343,
       "gbp": 884963081992.185,
       "hkd": 8147813557214.799,
       "huf": 420467671804711.94,
       "idr": 15401353442923450,
       "ils": 3429028858579.703,
       "inr": 82532460186083.89,
       "jpy": 143360014178007.22,
       "krw": 1396594738924835.2,
       "kwd": 319595522521.1632,
       "lkr": 371910262750759.5,
       "mmk": 2177522681181586.5,
       "mxn": 20688400648446.098,
       "myr": 4647188001461.676,
       "ngn": 444173585625159.7,
       "nok": 10095443664129.207,
       "nzd": 1677910491986.704,
       "php": 58357949112597.5,
       "pkr": 230383429022923.56,
       "pln": 4895897945715.039,
       "rub": 63111547493714.36,
       "sar": 3899301653098.217,
       "sek": 11012769404170.621,
       "sgd": 1447853663786.119,
       "thb": 37746399136188.2,
       "try": 18872583957129.08,
       "twd": 31572122214777.887,
       "uah": 38243456717398.49,
       "vef": 103947935795.00914,
       "vnd": 24312174383666090,
       "zar": 17422994540335.404,
       "xdr": 765977836200.2633,
       "xag": 55574544589.36431,
       "xau": 598741355.9350007,
       "bits": 50821962950248.32,
       "sats": 5082196295024832
     },
     "total_volume": {
       "btc": 3370028.01328746,
       "eth": 43381948.13523438,
       "ltc": 1246477368.6181092,
       "bch": 578387183.1960137,
       "bnb": 237445497.70619354,
       "eos": 46866634309.834274,
       "xrp": 207149811827.78415,
       "xlm": 654224557053.053,
       "link": 10176388115.951094,
       "dot": 9472208882.18274,
       "yfi": 7511871.230264702,
       "usd": 68838869418.292,
       "aed": 252845855762.0806,
       "ars": 9521142579010.824,
       "aud": 99132308811.11378,
       "bdt": 6533762332653.974,
       "bhd": 25948742988.355755,
       "bmd": 68838869418.292,
       "brl": 346183790417.65027,
       "cad": 89457556425.32837,
       "chf": 66798347650.99515,
       "clp": 60750302261642.76,
       "cny": 475063921742.57587,
       "czk": 1685534036191.7197,
       "dkk": 509955522257.0603,
       "eur": 68565854462.178955,
       "gbp": 58682313785.44773,
       "hkd": 540285308572.9357,
       "huf": 27881406982465.117,
       "idr": 1021270913837059.8,
       "ils": 227380499314.7802,
       "inr": 5472765841510.568,
       "jpy": 9506269252884.32,
       "krw": 92608847045007.44,
       "kwd": 21192527822.507114,
       "lkr": 24661542591853.69,
       "mmk": 144392542301731.56,
       "mxn": 1371857474368.513,
       "myr": 308157198950.9841,
       "ngn": 29453357159472.14,
       "nok": 669433567294.2478,
       "nzd": 111263025541.13582,
       "php": 3869742762592.303,
       "pkr": 15276832387692.771,
       "pln": 324649271091.87134,
       "rub": 4184956083336.41,
       "sar": 258564507161.26627,
       "sek": 730261863994.9385,
       "sgd": 96007850205.95634,
       "thb": 2502981292049.0957,
       "try": 1251449824574.982,
       "twd": 2093562116183.805,
       "uah": 2535941411565.444,
       "vef": 6892835994.853588,
       "vnd": 1612151597078053.5,
       "zar": 1155326875779.36,
       "xdr": 50792346767.07008,
       "xag": 3685173913.396347,
       "xau": 39702817.93700003,
       "bits": 3370028013287.46,
       "sats": 337002801328746
     },
     "market_cap_percentage": {
       "btc": 37.65405720108356,
       "eth": 18.398876974045443,
       "usdt": 6.514353460250167,
       "usdc": 5.033008247356199,
       "bnb": 4.559797158961028,
       "busd": 1.8517378923725534,
       "xrp": 1.5900392253507825,
       "ada": 1.508398370033087,
       "sol": 1.104483722280677,
       "doge": 0.8194123490874412
     },
     "market_cap_change_percentage_24h_usd": 4.242699177604611,
     "updated_at": 1661857934
 }
*/

struct GlobalData : Codable
{
    let data : MarketDataModel?
}


struct MarketDataModel : Codable {
   
        let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
        let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys : String, CodingKey {
        
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    
    var marketCap : String {
        
        if let item = totalMarketCap.first(where: { $0.key == "usd"} )
        {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    
    var Volume : String {
        if let item = totalVolume.first(where: {$0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where : {$0.key == "btc"})
        {
            return item.value.asPercentString
        }
        return ""
    }
}
