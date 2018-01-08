//
//  SignUpViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignUpBtn_TouchUpInside(_ sender: Any) {
        Auth.auth().createUser(withEmail: "pnick622@gmail.com", password: "123kyle", completion: {
            (user: User?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            print(user)
        })
    }
}
