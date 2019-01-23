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
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bitRateLabel.isHidden = true
        //register for move to background notification
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        self.title = "Result"
        loadingLabel.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func applicationWillResignActive() {
        print("applicationWillResignActive")
        //go back to currency selection screen on app close to background
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //get today BTC rate
        self.currencyConvery(_currency: currencyIdentfier)
    }
    
    /// Get today BTC rate based on provided currency and display on screen
    ///
    /// - Parameters:
    ///   - currency: Currency Identifier (like USD, EUR, GBP etc)
    func currencyConvery(_currency:String){
        loadingLabel.isHidden = false
        self.progressView.startAnimating()
        let requestURl = "https://apiv2.bitcoinaverage.com/convert/global?from=BTC&to="+_currency+"&amount=1"
        Alamofire.request(requestURl).responseJSON {[weak self] response in
            guard let sself = self else {
                return
            }
            sself.progressView.stopAnimating()
            sself.loadingLabel.isHidden = true
            if let value = response.result.value as? NSDictionary {
                if let price = value.object(forKey: "price"){
                    sself.bitRateLabel.text = "1 BTC" + " = " + (price as! NSNumber).stringValue + " " + sself.currencyIdentfier
                    sself.bitRateLabel.isHidden = false
                }
            }
        }
    }
    
}
