//
//  Currency.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 30/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

struct Currencies: Decodable {
    var success: Bool
    var currencies: [String:String]
}
