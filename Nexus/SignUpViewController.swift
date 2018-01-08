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
//sends email and password to firebase in order to create a new user
    @IBAction func SignUpBtn_TouchUpInside(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text! , password: passwordTextField.text! , completion: {
            (user: User?, error: Error?) in
            if error != nil { //if an error occurs it will print to the console
                print(error!.localizedDescription)
                return
            }
            // All users are one giant node and each user is a child node
            // reference a location in the database
            let ref = Database.database().reference()
            let usersReference = ref.child("users")
            // print(usersReference.description()) prints out https://nexus-app-6f0eb.firebaseio.com/users
            let uid = user?.uid // id is created by firebase upon account creation
            let newUsersReference = usersReference.child(uid!) // points to new user on database
            newUsersReference.setValue(["email": self.emailTextField.text!]) // self is the view controller need this process for other user info entered
            print(newUsersReference.description())
        })
    }
}
