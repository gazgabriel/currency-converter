//
//  SelectCurrencyViewModel.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 01/05/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

struct SelectCurrencyViewModel {

    var currenciesList:[String]
    var currenciesListFiltred:[String]?

    init (currencies: [String:String]) {
        var array = currencies.keys.map {"\($0) \(currencies[$0]!)"}
        array.sort()
        self.currenciesList = array
        self.currenciesListFiltred = array
    }
    
    mutating func currenciesByTerm(term: String) {
        self.currenciesListFiltred?.removeAll()
        for currency in self.currenciesList {
            if currency.hasPrefix(term) {
                self.currenciesListFiltred?.append(currency)
            }
        }
    }
    
    func titleAtIndex(index: Int) -> String {
        if self.currenciesListFiltred!.count > 0 {
            return self.currenciesListFiltred![index]
        }
        else {
            return currenciesList[index]
        }
    }
    
    func prefixAtIndex(index: Int) -> String {
        if self.currenciesListFiltred!.count > 0 {
            return String(self.currenciesListFiltred![index].prefix(3))
        }
        else {
            return String(currenciesList[index].prefix(3))
        }
    }
    func indexByprefix(prefix: String) -> Int {
        if self.currenciesListFiltred!.count > 0 {
            for currencie in self.currenciesListFiltred! {
                if currencie.prefix(3) == prefix {
                    return (self.currenciesListFiltred?.firstIndex(of: currencie))!
                }
            }
        }
        else {
            for currencie in self.currenciesList {
                if currencie.prefix(3) == prefix {
                    return (self.currenciesList.firstIndex(of: currencie))!
                }
            }
        }
        return 0
    }
    
    func count() -> Int {
        if self.currenciesListFiltred!.count > 0 {
            return self.currenciesListFiltred!.count
        }
        else {
            return currenciesList.count
        }
    }
}
