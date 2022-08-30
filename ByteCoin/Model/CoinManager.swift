//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String)
    func didFaildWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "687FA91A-DA4B-4A90-9057-9B3AF6DE22A2"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CoinManagerDelegate?
    
    func fetchCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session =  URLSession(configuration: .default)
           let task = session.dataTask(with: url) { (data, response, error)in
                if error != nil{
                    self.delegate?.didFaildWithError(error: error!)
                    return
                   }
                if  let safeData = data {
                    let test = String(decoding: safeData, as: UTF8.self)
                    print(test)

                      if let bitcoinPrice = self.parseJson(safeData) {
                         let bitcoinPriceString = String(format: "%.2f", bitcoinPrice)
                          self.delegate?.didUpdatePrice(price: bitcoinPriceString, currency: currency)
                          
                    }
               }
            }
           task.resume()
       }
   }
    
    func parseJson(_ coinData: Data)->Double? {
        let decoder = JSONDecoder()
        do {
            
       let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            return rate
        }
        catch{

            return nil
          }
       }

    }
    

