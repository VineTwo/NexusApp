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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(addTapped))
        
        nameTextField.center.x = self.view.frame.width + 300
        phoneTextField.center.x = self.view.frame.width + 300
        nextButton.center.x = self.view.frame.width + 300
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.nameTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.phoneTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        handleTextField()
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
    
    func handleTextField() {
        nameTextField.addTarget(self, action: #selector(ContactCodeViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        phoneTextField.addTarget(self, action: #selector(ContactCodeViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let firstName = nameTextField.text, !firstName.isEmpty, let phone = phoneTextField.text, !phone.isEmpty else {
            //errorLabel.text = "Please fill out all fields."
            errorLabel.textColor = .red
            return
        }
        nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        nextButton.backgroundColor = UIColor.gray
        nextButton.layer.cornerRadius = 7.0
        nextButton.layer.shadowColor = UIColor.gray.cgColor
        nextButton.layer.shadowRadius = 2.5
        nextButton.layer.shadowOpacity = 0.4
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        handleTextField()
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.nextButton.center.x = self.view.frame.width / 2.2
            
        }), completion: nil)
        
    }
    
    @objc func addTapped() {
        let storyBoard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()
        self.present(vc!, animated: true, completion: nil)
    }

}
