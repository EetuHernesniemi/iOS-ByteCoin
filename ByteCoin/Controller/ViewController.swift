//
//  ViewController.swift
//  ByteCoin
//
//  Created by Eetu Hernesniemi on 7.1.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var coinAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

    
}

extension ViewController: CoinManagerDelegate {
    func didUpdateCoinExchange(coinManager: CoinManager, coinExchangeModel: CoinExchangeModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinExchangeModel.exchangeCurrency
            self.coinAmountLabel.text = coinExchangeModel.getRoundedExchangeRate
        }
    }
    
    func didFailWithError(Error:Error) {
        print(Error)
    }
}

extension ViewController:  UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.setSelectedCurrency(newCurrencyIndex: row)
    }
}

