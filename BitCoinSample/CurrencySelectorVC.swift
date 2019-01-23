//
//  CurrencySelectorVC.swift
//  BitCoinSample
//
//  Created by Abdul Azeem on 11/01/2019.
//  Copyright © 2019 Abdul Azeem Khan. All rights reserved.
//

import UIKit
import Alamofire
class CurrencySelectorVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var pickerData: [String] = [String]()
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        pickerData = ["USD", "EUR", "GBP", "AUD", "CAD", "CNY", "JPY", "NZD", "BRL", "INR", "PKR", "SAR", "AED", ]
        self.navigationItem.hidesBackButton = true
        self.title = "Select Currency"
        self.currencyLabel.text = "USD"
        if let nameString = UserDefaults.standard.string(forKey: "USER_NAME"){
            welcomeLabel.text = "Hello! " + nameString
        }
        
        proceedButton.setBackgroundImage(UIImage(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), size: proceedButton.frame.size), for: .normal)
    }
    
    //MARK: - segue delegate. Pass the seelcted currency to BTC rate dsiplay screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenBTCRate" {
            if let destinationVC = segue.destination as? BitRateDisplayVC {
                if let currencyIdentfier = self.currencyLabel.text{
                    destinationVC.currencyIdentfier = currencyIdentfier
                }
            }
        }
    }
    
    //MARK: - Picker Delegates
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let selected = pickerView.selectedRow(inComponent: component) == row
        return NSAttributedString(string: pickerData[row], attributes: [.foregroundColor: selected ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) : .black])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currencyLabel.text = pickerData[row]
        pickerView.reloadAllComponents()
    }
}
