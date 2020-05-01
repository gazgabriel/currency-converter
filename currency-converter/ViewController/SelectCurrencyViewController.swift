//
//  SelectCurrencyViewController.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 01/05/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class SelectCurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var selectCurrency: UIPickerView!
    
    var currencies: [String:String]?
    
    var viewModel: SelectCurrencyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCurrency.dataSource = self
        selectCurrency.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let array = currencies?.keys.map { "\($0) \(currencies![$0]!)" }
        return array!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let array = currencies?.keys.map { "\($0) \(currencies![$0]!)" }
        return array![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    
}
