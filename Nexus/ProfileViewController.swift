//
//  ProfileViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/12/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    var databaseHandle: DatabaseHandle?
    var instaURL = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileURL()
        retrieveInstaQrUrl()
        
        
        // Do any additional setup after loading the view.
    }
    // need to get this to work
    func retrieveInstaQrUrl() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("InstagramQrUrl").observe(.childAdded) { (snapshot) in
           let instaCode = snapshot.value as? String
            if let actualCode  = instaCode {
                self.instaURL.append(actualCode)
                print(self.instaURL)
                
                
                //Turn instaURL into a picture reuse from the social code page
            }
        }
        
    }
    
    
    
    func profileURL() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users").child(uid!)
        print("before")
        print(ref)
        print("after")
        
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


