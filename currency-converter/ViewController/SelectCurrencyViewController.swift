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

class SelectCurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var selectCurrency: UIPickerView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currencies: [String:String]?
    var segueOrigin: String?
    var prefix: String?
    weak var delegate: SelectCurrencyViewControllerDelegate?
    var viewModel: SelectCurrencyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCurrency.dataSource = self
        selectCurrency.delegate = self
        searchBar.delegate = self
        
        self.viewModel = SelectCurrencyViewModel(currencies: currencies!)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (viewModel?.count())!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.titleAtIndex(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if segueOrigin == "ActualCurrencySet" {
            self.delegate?.updateActual((viewModel?.prefixAtIndex(index: row))!)
        }
        
        if segueOrigin == "ConvertCurrencySet" {
            self.delegate?.updateConvert((viewModel?.prefixAtIndex(index: row))!)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.currenciesByTerm(term: searchText)
        self.selectCurrency.reloadAllComponents()
    }
    
}
