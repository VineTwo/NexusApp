//
//  SignUpViewController.swift
//  Nexus2
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        handleTextField()
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            print("Empty")
            return
        }
        signUpButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        print("filled")
    }

    @IBAction func SignUpBtn_TouchUpInside(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: {
            (user: User?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            let uid = user?.uid
            
            // all users are a giant node with each individual user being their own node
            let ref = Database.database().reference()
            let usersReference = ref.child("users")
            /*
             Might need these for storing profile url to specific user
            let profileRef = Database.database().reference()
            let profileReference = profileRef.child("profileImage")
            
             let profileImageReference = usersReference.child(uid!)
             profileImageReference.setValue(["profileImage": nil])
             */
            
            let newUsersReference = usersReference.child(uid!)
            newUsersReference.setValue(["email": self.emailTextField.text!])
        
            print(newUsersReference.description()) // prints out link to database
        })
    }
    
}

