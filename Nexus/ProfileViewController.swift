//
//  ProfileViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/12/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getName()
      
        
        self.welcomeLabel.text = ("Welcome, ")
        // Do any additional setup after loading the view.
    }
    
    func getName() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observe(.value)  { (snapshot: DataSnapshot) in
            print(snapshot)
            if let userInfo = snapshot.value as? [String: Any] {
                let fullName = userInfo["FullName"] as! String
                print("See this")
                self.welcomeLabel.text = (fullName)
            }
        }
    }
    func postName(name: String) {
        welcomeLabel.text = name
    }

    @IBAction func signOut_TouchUpInside(_ sender: Any) {
        print(Auth.auth().currentUser!)
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
       // print(Auth.auth().currentUser)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "UIViewController-BYZ-38-t0r")
        self.present(signInVC, animated: true, completion: nil)
    }
    
 

}
