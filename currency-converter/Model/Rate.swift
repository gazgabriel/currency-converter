//
//  Rate.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 01/05/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

struct Rates: Decodable {
    let success: Bool
    var source: String
    var quotes: [String:Double]
}
