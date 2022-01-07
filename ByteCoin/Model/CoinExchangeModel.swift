//
//  CoinExchangeModel.swift
//  ByteCoin
//
//  Created by Eetu Hernesniemi on 7.1.2022.
//

import Foundation

struct CoinExchangeModel {
    let time: Date
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    let src_side_base: [CoinExchangeSrcSideBase]
}

struct CoinExchangeSrcSideBase {
    let time: Date
    let asset: String
    let rate: Double
    let volume: Double
}
