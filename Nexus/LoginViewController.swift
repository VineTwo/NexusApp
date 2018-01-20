//
//  LoginViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
//import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    let textFieldColor = UIColor(red: 0, green: 0.1, blue: 0.4, alpha: 0.2)
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func signOutButton_TouchUpInside(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginErrorLabel.isHidden = true
        loginErrorLabel.textColor = UIColor.red
        
        emailTextField.tintColor = UIColor.lightText
        emailTextField.textColor = UIColor.black
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 34, width: 335.53, height: 0.6)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        
        passwordTextField.tintColor = UIColor.lightText
        passwordTextField.textColor = UIColor.black
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 34, width: 335.53, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        loginButton.layer.cornerRadius = 10.0
        loginButton.isEnabled = false
        loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        loginButton.backgroundColor = UIColor.clear
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.tag = 1
        
        handleTextField()
        
    }
    
    //Hide keyboard when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //If not last textField it will go to next textField when enter is pressed
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


    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            print("current user:\(String(describing: Auth.auth().currentUser))")
            self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
        }
    }
    
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    @objc func textFieldDidChange() {
        guard let username = emailTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            loginButton.backgroundColor = UIColor.clear
            return
        }
        loginButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        loginButton.backgroundColor = UIColor(red: 0.4, green: 0.3, blue: 0.4, alpha: 0.6)
        loginButton.isEnabled = true
    }
    
    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, Error) in
            if Error != nil {
                self.loginErrorLabel.isHidden = false
                print(Error!.localizedDescription)
                if Error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.loginErrorLabel.text = "The account does not exist."
                }
                if Error?.localizedDescription == "The password is invalid or the user does not have a password." {
                    self.loginErrorLabel.text = "The password is incorrect."
                }
                if Error?.localizedDescription == "The email address is badly formatted." {
                    self.loginErrorLabel.text = "The email address is incorrect"
                }
                
            }
            else {
                self.loginErrorLabel.isHidden = true
                self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
            }
        })
    }
}
