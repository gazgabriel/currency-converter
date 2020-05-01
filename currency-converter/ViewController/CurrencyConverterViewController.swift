//
//  CurrencyConverterViewController.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 30/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let currencyRequest = CurrencyRequest()
        currencyRequest.getCurrencies{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let currencies):
                print("Success View Load")
                print(currencies)
            }
        }
    }
}

