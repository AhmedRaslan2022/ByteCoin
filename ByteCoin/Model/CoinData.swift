//
//  CoinData.swift
//  ByteCoin
//
//  Created by Macintosh on 17/08/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
struct CoinData: Codable{
    
 let time, assetIDBase, assetIDQuote: String
 let rate: Double

 enum CodingKeys: String, CodingKey {
     case time
     case assetIDBase = "asset_id_base"
     case assetIDQuote = "asset_id_quote"
     case rate
 }
}
