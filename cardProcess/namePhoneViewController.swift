//
//  namePhoneViewController.swift
//  Nexus
//
//  Created by Nick potts on 3/30/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class namePhoneViewController: UIViewController {
  
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
  
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
            UserDefaults.standard.set(nameTextField.text, forKey: "name")
            UserDefaults.standard.set(phoneTextField.text, forKey: "phone")
    }
   
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "nextSegue" {
            if( isValidPhoneNumber(phoneNumberString: self.phoneTextField.text!)  &&  !((self.nameTextField.text?.isEmpty)!)   ) {
                return true
            } else {
                self.errorLabel.text = "Please enter a valid phone number or name"
                return false
            }
            
        }
        return true
    }
    

    func isValidPhoneNumber(phoneNumberString: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneNumberString)
        return result
    }

}
