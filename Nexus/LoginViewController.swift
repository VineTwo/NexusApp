//
//  LoginViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    let textFieldColor = UIColor(red: 0, green: 0.1, blue: 0.4, alpha: 0.2)
    
    @IBOutlet weak var emailTextField: UITextField!
    // @IBOutlet weak var userNameTextField: UITextField!
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
        emailTextField.tintColor = UIColor.lightText
        emailTextField.textColor = UIColor.black
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 33, width: 335.53, height: 0.6)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        
        passwordTextField.tintColor = UIColor.lightText
        passwordTextField.textColor = UIColor.black
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 33, width: 335.53, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        loginButton.layer.cornerRadius = 10.0
        loginButton.isEnabled = false
        loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        loginButton.backgroundColor = UIColor.clear
        
        handleTextField()
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
                print(Error!.localizedDescription)
            }
            else {
                self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
            }
        })
    }
}
