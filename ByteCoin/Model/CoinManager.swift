//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Eetu Hernesniemi on 7.1.2022.
//

import Foundation

struct CoinManager {
    
    let apiKey = Environment.ApiKey
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var selectedCurrencyIndex = 0
    
    func setSelectedCurrency(newCurrencyIndex: Int) {
        fetchCryptoExchangeRate(cryptoCurrencyPath: "BTC", exchangeCurrencyPath: currencyArray[newCurrencyIndex])
    }
    
    func fetchCryptoExchangeRate(cryptoCurrencyPath: String, exchangeCurrencyPath: String) {
        let urlString = baseURL + cryptoCurrencyPath + "/" + exchangeCurrencyPath
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    //TODO develop this more
                    self.parseJSON(coinExchangeData: <#T##Data#>)
                }
            }
            
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(coinExchangeData: Data) -> CoinExchangeModel? {
//        let decoder = JSONDecoder()
        do {
            //TODO decode json to proper model, not nil
            return nil
            
        } catch {
            //TODO error handling
            return nil
        }
    }
    
}
