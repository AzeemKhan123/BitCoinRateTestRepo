//
//  ViewController.swift
//  BitCoinSample
//
//  Created by Abdul Azeem on 11/01/2019.
//  Copyright © 2019 Abdul Azeem Khan. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var enterAppButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Enter Name"
        //If name present skip to next currency seelction screen
        if UserDefaults.standard.string(forKey: "USER_NAME") != nil {
            self.performSegue(withIdentifier: "OpenWelcome", sender: self);
        }
    
        enterAppButton.setBackgroundImage(UIImage(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), size: enterAppButton.frame.size), for: .normal)

    }
    
    @IBAction func enterApp(_ sender: UIButton) {
        if nameField.text != "" && nameField.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty == false{
            //save name in user defaults
            let preferences = UserDefaults.standard
            preferences.set(nameField.text, forKey: "USER_NAME")
            preferences.synchronize()
        }else{
            let alert = UIAlertController(title: "Empty Name", message: "Please make sure you enter a name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

