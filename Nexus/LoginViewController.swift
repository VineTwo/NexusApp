//
//  LoginViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let textFieldColor = UIColor(red: 0, green: 0.1, blue: 0.5, alpha: 0.2)
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    }


}
