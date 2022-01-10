//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Eetu Hernesniemi on 7.1.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinExchange(coinManager: CoinManager, coinExchangeModel: CoinExchangeModel)
    func didFailWithError(Error: Error)
}

struct CoinManager {
    
    let apiKey = Environment.ApiKey
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    //TODO: select another currency instead of just BTC/bitcoin.
    func setSelectedCurrency(newCurrencyIndex: Int) {
        fetchCryptoExchangeRate(cryptoCurrencyPath: "BTC", exchangeCurrencyPath: currencyArray[newCurrencyIndex])
    }
    
    func fetchCryptoExchangeRate(cryptoCurrencyPath: String, exchangeCurrencyPath: String) {
        let urlString = baseURL + cryptoCurrencyPath + "/" + exchangeCurrencyPath
        if let url = URL(string: urlString) {
            let sessionConfig = URLSessionConfiguration.default
            let xHTTPAdditionalHeaders: [String : String] = ["X-CoinAPI-Key":apiKey]
            sessionConfig.httpAdditionalHeaders = xHTTPAdditionalHeaders
            let session = URLSession(configuration: sessionConfig)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let coinExchangeModel = self.parseJSON(coinExchangeData: safeData) {
                        self.delegate?.didUpdateCoinExchange(coinManager: self, coinExchangeModel: coinExchangeModel)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(coinExchangeData: Data) -> CoinExchangeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinExchangeData.self, from: coinExchangeData)
            let cryptoCurrency = decodedData.asset_id_base
            let exchangeCurrency = decodedData.asset_id_quote
            let rate = decodedData.rate
            return CoinExchangeModel(cryptoCurrency: cryptoCurrency, exchangeCurrency: exchangeCurrency, rate: rate)
        } catch {
            delegate?.didFailWithError(Error: error)
            return nil
        }
    }
    
}
