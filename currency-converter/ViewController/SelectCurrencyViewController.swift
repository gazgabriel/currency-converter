//
//  SelectCurrencyViewController.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 01/05/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

protocol SelectCurrencyViewControllerDelegate: AnyObject {
    func updateActual(_ prefix: String)
    func updateConvert(_ prefix: String)
}

class SelectCurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectCurrency: UIPickerView!
    
    var currencies: [String:String]?
    var segueOrigin: String?
    var prefix: String?
    weak var delegate: SelectCurrencyViewControllerDelegate?
    var viewModel: SelectCurrencyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCurrency.dataSource = self
        selectCurrency.delegate = self
        
        self.viewModel = SelectCurrencyViewModel(currencies: currencies!)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (viewModel?.currenciesList.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.currenciesList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if segueOrigin == "ActualCurrencySet" {
            self.delegate?.updateActual(String((viewModel?.currenciesList[row].prefix(3))!))
        }
        
        if segueOrigin == "ConvertCurrencySet" {
            self.delegate?.updateConvert(String((viewModel?.currenciesList[row].prefix(3))!))
        }
    }
    
}
