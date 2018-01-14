//
//  SignUpViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PageTwoSignUpViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
        addName()
        self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func addName() {
        let userID = Auth.auth().currentUser?.uid
        let fullName = self.fullNameTextField.text
        let ref = Database.database().reference()
        let namePath = ref.child("users").child(userID!).child("FullName")
        namePath.setValue([fullName])
        
    }

}
