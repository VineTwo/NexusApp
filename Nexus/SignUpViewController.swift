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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignUpBtn_TouchUpInside(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: {
            (user: User?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            // all users are a giant node with each individual user being their own node
            let ref = Database.database().reference()
            let usersReference = ref.child("users")
            
            let uid = user?.uid
            let newUsersReference = usersReference.child(uid!)
            newUsersReference.setValue(["email": self.emailTextField.text!])
            
            print(newUsersReference.description()) // prints out link to database
        })
    }
}
