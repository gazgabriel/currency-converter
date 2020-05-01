//
//  Currency.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 30/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

struct Currencies: Decodable {
    let success: Bool
    var source: String
    var currencies:[CurrencyList]
}

struct Rates: Decodable {
    let success: Bool
    var source: String
    var quotes:[CurrencyRates]
}

struct CurrencyList: Decodable {
    let code: String
    let name: String
}

struct CurrencyRates: Decodable {
    let code: String
    let rate: Double
}
