//
//  ContactCodeViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/14/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ContactCodeViewController: UIViewController, UITextFieldDelegate {
 //   @IBOutlet weak var contactImageVIew: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var profilePagePrompt: UILabel!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePagePrompt.isHidden = true
        errorLabel.isHidden = true
   
        // Do any additional setup after loading the view.
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        self.emailTextField.delegate = self
        
        firstNameTextField.tag = 0
        lastNameTextField.tag = 1
        phoneNumberTextField.tag = 2
        emailTextField.tag = 3
        
    }
    
    @IBAction func generateButton_TouchUpInside(_ sender: Any) {
     
        errorLabel.isHidden = true
        
        if !isValidEmailAddress(emailAddressString: emailTextField.text!) {
            errorLabel.isHidden = false
            errorLabel.textColor = UIColor.red
            errorLabel.text = "Please enter a valid email address."
            print("Email error")
        }
        
        else if isValidPhoneNumber(phoneNumberString: phoneNumberTextField.text!) {
                errorLabel.isHidden = false
                errorLabel.textColor = .red
                errorLabel.text = "Please enter a proper phone number."
                print("Phone error")
            }
            else {
 
                print("No error")
                let name = firstNameTextField.text! + lastNameTextField.text!
                let phone = phoneNumberTextField.text!
                let email = emailTextField.text!
                // "MECARD:N:Joe_Morales;TEL:6191029501;EMAIL:first.last@email.com;URL:http://website.com;;"
                let contactInfo = "MECARD:N:\(name);TEL:\(phone);EMAIL:\(email)"
        
        
                let contactInfoAsString = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(contactInfo)")
                setContactQrCode(contactImageString: contactInfoAsString)
        
   
                firstNameTextField.isHidden = true
                lastNameTextField.isHidden = true
                emailTextField.isHidden = true
                phoneNumberTextField.isHidden = true
                profilePagePrompt.isHidden = false
        
            }
    }

    
    func setContactQrCode(contactImageString: String) {
        
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("ContactQrUrl")
        userRef.setValue(["ContactQrURL": contactImageString])
        print("code sent to database")
        
    }
   
    func isValidPhoneNumber(phoneNumberString: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneNumberString)
        return result
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var validEmail = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                validEmail = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            validEmail = false
        }
        
        return  validEmail
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
    
    //Hide keyboard when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
