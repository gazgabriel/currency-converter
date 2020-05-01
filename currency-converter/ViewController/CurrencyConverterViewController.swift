//
//  CurrencyConverterViewController.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 30/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    var viewModel: CurrencyConverterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        let currencyRequest = CurrencyRequest()
        currencyRequest.getCurrencies{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let currencies):
               self!.viewModel = CurrencyConverterViewModel(currencies: currencies.currencies)
            }
        }

        /*
        currencyRequest.getRates{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let rates):
               print(rates)
            }
        }
        */
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ActualCurrencySet") {
            let viewController = segue.destination as? SelectCurrencyViewController
            viewController!.currencies = viewModel!.currencies
        }
        
        if (segue.identifier == "ConvertCurrencySet") {
            let viewController = segue.destination as? SelectCurrencyViewController
            viewController!.currencies = viewModel!.currencies
        }
    }
}

