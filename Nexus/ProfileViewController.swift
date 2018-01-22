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
    
    @IBOutlet weak var instaCodeImageView: UIImageView!
    
    @IBOutlet weak var twitterCodeImageView: UIImageView!
    
    @IBOutlet weak var snapCodeImageView: UIImageView!
    
    @IBAction func didTapInstaCodeImage(_ sender: Any) {
        print("Insta Tapped")
    }
    
    @IBAction func didTapTwitterCodeImage(_ sender: Any) {
        print("Twitter tapped")
    }
    
    
    var databaseHandle: DatabaseHandle?
    var instaURL = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileURL()
        retrieveInstaQrUrl()
        retrieveTwitterQrUrl()
        retrieveSnapQrUrl()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectImageView))
       
        instaCodeImageView.addGestureRecognizer(tapGesture)
        instaCodeImageView.isUserInteractionEnabled = true;
        
        twitterCodeImageView.addGestureRecognizer(tapGesture)
        twitterCodeImageView.isUserInteractionEnabled = true;

        snapCodeImageView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSelectImageView(tapGesture: UITapGestureRecognizer) {
        print("Snap Tapped")
    }
    // need to get this to work
    func retrieveInstaQrUrl() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("InstagramQrUrl").observe(.childAdded) { (snapshot) in
           let instaCode = snapshot.value as? String
            if let actualCode  = instaCode {
                let imageURL = URL(string: actualCode)
                
                var image: UIImage?
                
                if let url = imageURL {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
                                image = UIImage(data: imageData! as Data)!
                                self.instaCodeImageView.image = image
                                self.instaCodeImageView.sizeToFit()
                            }
                            
                        }
                    }
                }
    
                print(self.instaURL)
                
            }
        }
        
    }
    
    func retrieveTwitterQrUrl() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("TwitterQrUrl").observe(.childAdded) { (snapshot) in
            let twitterCode = snapshot.value as? String
            if let actualCode  = twitterCode {
                let imageURL = URL(string: actualCode)
                
                var image: UIImage?
                
                if let url = imageURL {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
                                image = UIImage(data: imageData! as Data)!
                                self.twitterCodeImageView.image = image
                                self.twitterCodeImageView.sizeToFit()
                            }
                            
                        }
                    }
                }
                
                
            }
        }
        
    }
    
    func retrieveSnapQrUrl() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("SnapQrUrl").observe(.childAdded) { (snapshot) in
            let snapCode = snapshot.value as? String
            if let actualCode  = snapCode {
                let imageURL = URL(string: actualCode)
                
                var image: UIImage?
                
                if let url = imageURL {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
                                image = UIImage(data: imageData! as Data)!
                                self.snapCodeImageView.image = image
                                self.snapCodeImageView.sizeToFit()
                            }
                            
                        }
                    }
                }
                
                
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


