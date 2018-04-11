//
//  companyInfoViewController.swift
//  Nexus
//
//  Created by Nick potts on 3/30/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class companyInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var companyNameTextField: UITextField!
    
    @IBOutlet weak var companyAddyTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var stateZipTextField: UITextField!
   
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
        UserDefaults.standard.set(companyNameTextField.text, forKey: "companyName")
        
        // Do this in order to concat with ","
        let street = companyAddyTextField.text!
        let streetString = street as String
        let city = cityTextField.text!
        let cityString = city as String
        let stateZip = stateZipTextField.text!
        let stateZipString = stateZip as String
        
        let fullAddress = streetString + ", " + cityString + ", " + stateZipString
        UserDefaults.standard.set(fullAddress, forKey: "address")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //Setting items off the screen
        companyNameTextField.center.x = self.view.frame.width + 300
        companyAddyTextField.center.x = self.view.frame.width + 300
        cityTextField.center.x = self.view.frame.width + 300
        stateZipTextField.center.x = self.view.frame.width + 300
        nextButton.center.x = self.view.frame.width + 300
        
        //Button design
        nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        nextButton.backgroundColor = UIColor.gray
        nextButton.layer.cornerRadius = 7.0
        nextButton.layer.shadowColor = UIColor.gray.cgColor
        nextButton.layer.shadowRadius = 2.5
        nextButton.layer.shadowOpacity = 0.4
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        animateElements()
        
        self.companyNameTextField.delegate = self
        self.companyAddyTextField.delegate = self
        self.cityTextField.delegate =        self
        self.stateZipTextField.delegate =    self
        
        companyNameTextField.tag = 0
        companyAddyTextField.tag = 1
        cityTextField.tag        = 2
        stateZipTextField.tag    = 3
        
        // Do any additional setup after loading the view.
    }

    func animateElements() {
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.companyNameTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.companyAddyTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.4, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.cityTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.7, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.stateZipTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 2.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.nextButton.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        
    }
    
    //If not last textField it will go to next textField when enter is pressed
    //If last textField, keyboard will dismiss when enter key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    

   

}
