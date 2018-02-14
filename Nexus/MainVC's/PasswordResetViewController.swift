//
//  PasswordResetViewController.swift
//  Nexus
//
//  Created by Matthew Foote on 2/3/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class PasswordResetViewController: UIViewController, UITextFieldDelegate {
    
  //  @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func sendEmailButton_TouchUpInside(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                self.errorLabel.textColor = UIColor.red
                self.errorLabel.text = "The email is not associated with an account."
            }
            self.showConfirmationAlert()
        }
    }
    
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 28, width: emailTextField.frame.width, height: 0.6)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: loginButton.frame.width, height: 0.7)
        topLayer.backgroundColor = UIColor.darkGray.cgColor
        loginButton.layer.addSublayer(topLayer)
        
        
        
        sendEmailButton.layer.cornerRadius = 7.0
        sendEmailButton.isEnabled = false
        sendEmailButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        sendEmailButton.backgroundColor = UIColor.clear
        
        handleTextField()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            validEmail = false
        }
        
        return  validEmail
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(PasswordResetViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty else {return}
        
        if(isValidEmailAddress(emailAddressString: email)) {
            sendEmailButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            sendEmailButton.backgroundColor = UIColor(red: 0.4, green: 0.3, blue: 0.4, alpha: 0.6)
            sendEmailButton.isEnabled = true
        }
    }
    
    func showConfirmationAlert() {
        let alert = UIAlertController(title: "Reset Password", message: "A password reset email has been sent.", preferredStyle: .alert)
       // let recognition = UIAlertAction(title: "OK", style: .destructive) { (alert: UIAlertAction!) -> Void in
           // PasswordResetViewController.canvas.image = nil
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        self.present(alert, animated: true)
    }

}
