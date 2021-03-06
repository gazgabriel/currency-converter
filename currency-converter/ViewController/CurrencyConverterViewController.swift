//
//  CurrencyConverterViewController.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 30/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: CurrencyConverterViewModel?

    @IBOutlet weak var ActualCurrencyButton: UIButton!
    @IBOutlet weak var ConvertCurrencyButton: UIButton!
    @IBOutlet weak var convertValueLabel: UILabel!
    @IBOutlet weak var valueTextLabel: UITextField!
    @IBOutlet weak var convertCurrenciesButton: UIButton!
    
    var actualCurrency:String?
    var convertCurrency:String?
    var currenciesList: [String:String]?
    var ratesList: [String:Double]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currencyRequest = CurrencyRequest()
        let group = DispatchGroup()
        
        self.valueTextLabel.delegate = self
        
        
        group.enter()
        currencyRequest.getCurrencies{ [weak self] result in
            
            switch result {
            case .failure(let error):
                print (error)
            case .success(let currencies):
                self!.currenciesList = currencies.currencies
            }
            group.leave()
        }
        
        group.enter()
        currencyRequest.getRates{ [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let rates):
                self!.ratesList = rates.quotes
                
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.viewModel = CurrencyConverterViewModel(currencies: self.currenciesList!, rates: self.ratesList!)
        }
    }
    
    @IBAction func convertCurrencies(sender: UIButton) {
        if let actualCurrency = self.actualCurrency, let convertCurrency = self.convertCurrency, let textValue = valueTextLabel.text {
            let actualValue = viewModel?.rates!["USD\(actualCurrency)"]!
            let covertValue = viewModel?.rates!["USD\(convertCurrency)"]!
            let result = ((covertValue! * (textValue as NSString).doubleValue) / actualValue!)
            convertValueLabel.text = "\((String(format:"%.2f", (textValue as NSString).doubleValue))) \(actualCurrency) = \(String(format:"%.2f", result)) \(convertCurrency)"
        } else {
            let alertController = UIAlertController(title: "Moedas Não Indicadas", message:
                "Para realizar a conversão indique ambas modeas", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Confirmar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ActualCurrencySet") {
            let viewController = segue.destination as? SelectCurrencyViewController
            viewController!.currencies = self.currenciesList
            viewController!.segueOrigin = "ActualCurrencySet"
            viewController?.delegate = self
            viewController?.prefix = self.actualCurrency
        }
        
        if (segue.identifier == "ConvertCurrencySet") {
            let viewController = segue.destination as? SelectCurrencyViewController
            viewController!.currencies = self.currenciesList
            viewController!.segueOrigin = "ConvertCurrencySet"
            viewController?.delegate = self
            viewController?.prefix = self.convertCurrency
        }
    }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn
        range: NSRange, replacementString string: String) -> Bool {
        if valueTextLabel.text?.count == 0 && string == "0" {
            return false
        }
        return string == string.filter("0123456789.".contains)
    }
}

extension CurrencyConverterViewController: SelectCurrencyViewControllerDelegate {
    func updateActual(_ prefix: String) {
        actualCurrency = prefix
        ActualCurrencyButton.setTitle(prefix, for: .normal)
    }
    func updateConvert(_ prefix: String) {
        convertCurrency = prefix
        ConvertCurrencyButton.setTitle(prefix, for: .normal)
    }
}
