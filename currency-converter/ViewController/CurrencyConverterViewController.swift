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

    @IBOutlet weak var ActualCurrencyButton: UIButton!
    @IBOutlet weak var ConvertCurrencyButton: UIButton!
    
    @IBOutlet weak var convertValueLabel: UILabel!
    var actualCurrency:String?
    var convertCurrency:String?
    
    @IBOutlet weak var valueTextLabel: UITextField!
    @IBOutlet weak var convertCurrenciesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currencyRequest = CurrencyRequest()
        var currenciesList: [String:String]?
        var ratesList: [String:Double]?
        
        
        currencyRequest.getCurrencies{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let currencies):
                currenciesList = currencies.currencies
            }
        }
        
        currencyRequest.getRates{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let rates):
                ratesList = rates.quotes
            }
        }
        sleep(2)
        self.viewModel = CurrencyConverterViewModel(currencies: currenciesList!, rates: ratesList!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ActualCurrencySet") {
            let viewController = segue.destination as? SelectCurrencyViewController
            viewController!.currencies = viewModel!.currencies
            viewController!.segueOrigin = "ActualCurrencySet"
            viewController?.delegate = self
        }
        
        if (segue.identifier == "ConvertCurrencySet") {
            let viewController = segue.destination as? SelectCurrencyViewController
            viewController!.currencies = viewModel!.currencies
            viewController!.segueOrigin = "ConvertCurrencySet"
            viewController?.delegate = self
        }
    }
}

extension CurrencyConverterViewController: SelectCurrencyViewControllerDelegate {
    func updateActual(_ prefix: String) {
        actualCurrency = prefix
        ActualCurrencyButton.titleLabel?.text = prefix
    }
    
    func updateConvert(_ prefix: String) {
        convertCurrency = prefix
        ConvertCurrencyButton.titleLabel?.text = prefix
    }
    
    
    @IBAction func likedThis(sender: UIButton) {
        let actualValue = viewModel?.rates["USD\(actualCurrency!)"]!
        let covertValue = viewModel?.rates["USD\(convertCurrency!)"]!
        let value = (valueTextLabel.text! as NSString).doubleValue
        
        let result = ((covertValue! * value) / actualValue!)
        print("\(value) \(actualCurrency!) = \(result) \(convertCurrency!)")
        
        
        
        

      
     }
    
    
}
