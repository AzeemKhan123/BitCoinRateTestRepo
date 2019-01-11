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
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currencyLabel.text = pickerData[row]
    }
}
