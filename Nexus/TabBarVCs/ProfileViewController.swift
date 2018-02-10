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
        self.performZoomInOnStartingImageView(startingImageView: instaCodeImageView)
    }
    
    @IBAction func didTapTwitterCodeImage(_ sender: Any) {
        self.performZoomInOnStartingImageView(startingImageView: twitterCodeImageView)
    }
    
    @IBAction func didTapContactImage(_ sender: Any) {
        self.performZoomInOnStartingImageView(startingImageView: contactCodeImageView)
    }
    
    
    
    var databaseHandle: DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
     //This calls the remaining urls
        retrieveInstaQrUrl()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
      //  let instaImageData = instaCodeImageView.image
    }
    var startingFrame: CGRect?
    var blackBackground: UIView?
    
    
    func performZoomInOnStartingImageView(startingImageView: UIImageView) {
        
        if startingImageView.image?.sd_imageData() != nil {
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        print(startingFrame!)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
      //  zoomingImageView.backgroundColor = UIColor.red
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
   
    func retrieveInstaQrUrl() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("InstagramQrUrl").observe(.childAdded) { (snapshot) in
           let instaCode = snapshot.value as? String
            self.retrieveTwitterQrUrl(uid: uid!,ref: ref)
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
                
            }
        }
        
    }
    
    func retrieveTwitterQrUrl(uid: String, ref: DatabaseReference) {
        databaseHandle = ref.child("users").child(uid).child("TwitterQrUrl").observe(.childAdded) { (snapshot) in
            let twitterCode = snapshot.value as? String
            if let actualCode  = twitterCode {
                let imageURL = URL(string: actualCode)
                self.retrieveSnapQrUrl(uid: uid, ref: ref)
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
    
    func retrieveSnapQrUrl(uid: String, ref: DatabaseReference) {
        databaseHandle = ref.child("users").child(uid).child("SnapQrUrl").observe(.childAdded) { (snapshot) in
            let snapCode = snapshot.value as? String
            if let actualCode  = snapCode {
                let imageURL = URL(string: actualCode)
                self.retrieveContactQrUrl(uid: uid, ref: ref)
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
    
    func retrieveContactQrUrl(uid: String, ref: DatabaseReference) {
        databaseHandle = ref.child("users").child(uid).child("ContactQrUrl").observe(.childAdded) { (snapshot) in
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
        print(ref)
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
        if (Setting.name == "Sign Out") {
            showSignOutConfirmation()
        }
        
        if(Setting.name == "Write A Review"){
            print("Will take user to app page on App Store")
        }
    }
    
    func showSignOutConfirmation() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let signOutAction = UIAlertAction(title: "Yes", style: .destructive) {
            (action: UIAlertAction!) in
            self.signOutUser()
        }
        
        alert.addAction(signOutAction)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        self.present(alert, animated: true)
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
