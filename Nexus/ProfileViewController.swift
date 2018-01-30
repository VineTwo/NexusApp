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
    
    
    @IBOutlet weak var contactCodeImageView: UIImageView!
    
    @IBAction func didTapInstaCodeImage(_ sender: Any) {
        print("Insta Tapped")
        self.performZoomInOnStartingImageView(startingImageView: instaCodeImageView)

    }
    
    @IBAction func didTapTwitterCodeImage(_ sender: Any) {
        print("Twitter tapped")
        self.performZoomInOnStartingImageView(startingImageView: twitterCodeImageView)

    }
    
    @IBAction func didTapContactImage(_ sender: Any) {
        print("Contact Image tapped")
        self.performZoomInOnStartingImageView(startingImageView: contactCodeImageView)
    }
    
    
    
    var databaseHandle: DatabaseHandle?
    var instaURL = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileURL()
        retrieveInstaQrUrl()
        retrieveTwitterQrUrl()
        retrieveSnapQrUrl()
        retrieveContactQrUrl()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectImageView))
       
        instaCodeImageView.addGestureRecognizer(tapGesture)
        instaCodeImageView.isUserInteractionEnabled = true;
        
        twitterCodeImageView.addGestureRecognizer(tapGesture)
        twitterCodeImageView.isUserInteractionEnabled = true;
        
        contactCodeImageView.addGestureRecognizer(tapGesture)
        contactCodeImageView.isUserInteractionEnabled = true
        

        snapCodeImageView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    var startingFrame: CGRect?
    var blackBackground: UIView?
    
    
    func performZoomInOnStartingImageView(startingImageView: UIImageView) {
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        print(startingFrame!)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = UIColor.red
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        if let keyWindow = UIApplication.shared.keyWindow {
            blackBackground = UIView(frame: keyWindow.frame)
            blackBackground?.backgroundColor = UIColor.black
            blackBackground?.alpha = 0
            keyWindow.addSubview(blackBackground!)
            
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                
                self.blackBackground!.alpha = 1
                
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                zoomingImageView.center = keyWindow.center
            }, completion: nil)
        }
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer) {
       if let zoomOutImageView = tapGesture.view {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            zoomOutImageView.frame = self.startingFrame!
            self.blackBackground?.alpha = 0
            
        }, completion: { (Bool) in
            zoomOutImageView.removeFromSuperview()
            
        })
        
        }
    }
    @objc func handleSelectImageView(tapGesture: UITapGestureRecognizer) {
        self.performZoomInOnStartingImageView(startingImageView: snapCodeImageView)
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
    
    func retrieveContactQrUrl() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("ContactQrUrl").observe(.childAdded) { (snapshot) in
            let contactCode = snapshot.value as? String
            if let actualCode  = contactCode {
                let imageURL = URL(string: actualCode)
                print("First if let inside retrieve contact")
                var image: UIImage?
    
                if let url = imageURL {
                    print("Second if let of contact retrieval")
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
                                print("Should see contact code")
                                image = UIImage(data: imageData! as Data)!
                                self.contactCodeImageView.image = image
                                self.contactCodeImageView.sizeToFit()
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
    @IBAction func menu_TouchUpInside(_ sender: Any) {
        handleMenu()
        
    }
    lazy var menuLaunch: menuLauncher = {
        let launcher = menuLauncher()
        launcher.profileController = self
        return launcher
    }()
    
    func handleMenu() {
        menuLaunch.showMenu()
    }
    
    func showControllerForLogin(Setting: SignOut) {
      //  let dummyViewController = UIViewController()
        print(Setting.name)
        if (Setting.name == "Sign Out") {
            print("Sign out tapped")
            signOutUser()
        }
        
        if(Setting.name == "Write A Review"){
            print("Will take user to app page on App Store")
        }
        //navigationController?.pushViewController(dummyViewController, animated: true)
    }
    
    func signOutUser() {
       
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
