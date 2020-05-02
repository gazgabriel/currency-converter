//
//  SelectCurrencyViewModel.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 01/05/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

struct SelectCurrencyViewModel {
    
    var currencies:[String:String]
    
    var currenciesList:[String]

    init (currencies: [String:String]) {
        self.currencies = currencies
        var array = currencies.keys.map {"\($0) \(currencies[$0]!)"}
        array.sort()
        self.currenciesList = array
    }
}
