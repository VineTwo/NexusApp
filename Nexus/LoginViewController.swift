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
    let textFieldColor = UIColor(red: 0, green: 0.1, blue: 0.5, alpha: 0.2)
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.backgroundColor = textFieldColor
        userNameTextField.tintColor = UIColor.lightText
        userNameTextField.textColor = UIColor.black
        userNameTextField.attributedPlaceholder = NSAttributedString(string: userNameTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.8)])
        
        passwordTextField.backgroundColor = textFieldColor
        passwordTextField.tintColor = UIColor.gray
        passwordTextField.textColor = UIColor.black
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        loginButton.isEnabled = false
        loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        handleTextField()
    }
    func handleTextField() {
        userNameTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    @objc func textFieldDidChange() {
        guard let username = userNameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            return
        }
        loginButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        loginButton.isEnabled = true
    }
    
    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
        Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!, completion: { (user, Error) in
            if Error != nil {
                print(Error!.localizedDescription)
                return
            }

        })
    }
    

}
