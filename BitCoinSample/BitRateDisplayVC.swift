//
//  BitRateDisplayVC.swift
//  BitCoinSample
//
//  Created by Abdul Azeem on 11/01/2019.
//  Copyright © 2019 Abdul Azeem Khan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class BitRateDisplayVC: UIViewController{
    
    var currencyIdentfier : String = ""
    @IBOutlet weak var bitRateLabel: UILabel!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register for move to background notification
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        self.title = "Bit Coin Rate"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func applicationWillResignActive() {
        print("applicationWillResignActive")
        //go back to currency selection screen on app close to background
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.progressView.startAnimating()
        //get today BTC rate
        self.currencyConvery(_currency: currencyIdentfier)
    }
    
    /// Get today BTC rate based on provided currency and display on screen
    ///
    /// - Parameters:
    ///   - currency: Currency Identifier (like USD, EUR, GBP etc)
    func currencyConvery(_currency:String){
        let requestURl = "https://apiv2.bitcoinaverage.com/convert/global?from=BTC&to="+_currency+"&amount=1"
        Alamofire.request(requestURl).responseJSON { response in
            self.progressView.stopAnimating()
            if let value = response.result.value as? NSDictionary {
                if let price = value.object(forKey: "price"){
                    self.bitRateLabel.text = "1 BTC" + " = " + (price as! NSNumber).stringValue + " " + self.currencyIdentfier
                }
            }
        }
    }
    
}
