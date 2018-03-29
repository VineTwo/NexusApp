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
    

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        //For the activity indicator
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
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
        getImageFromCache(keyName: "instagramURL", imageName: instaCodeImageView)
        getImageFromCache(keyName: "twitterURL", imageName: twitterCodeImageView)
        getImageFromCache(keyName: "snapchatURL", imageName: snapCodeImageView)
        // Need to cache the contact url
        getImageFromCache(keyName: "contactURL", imageName: contactCodeImageView)
    }
    var startingFrame: CGRect?
    var blackBackground: UIView?
    
    func getImageFromCache(keyName: String, imageName: UIImageView) {
         let instaCache = UserDefaults.standard.object(forKey: keyName) as? String
            activityIndicator.stopAnimating()
            if let instaAsString = instaCache {
                let imageURL = URL(string: instaAsString)
                var image: UIImage?
            if let url = imageURL {
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = NSData(contentsOf: url)
                    //All UI operations has to run on main thread.
                    DispatchQueue.main.async {
                        if imageData != nil {
                            image = UIImage(data: imageData! as Data)!
                            imageName.image = image
                            imageName.sizeToFit()
                        }
                        
                    }
                }
            }
            }
        
        
    }

    var startingImageView: UIImageView?
    
    func performZoomInOnStartingImageView(startingImageView: UIImageView) {
        
        self.startingImageView = startingImageView
        self.startingImageView?.alpha = 0.0
        
        if startingImageView.image?.sd_imageData() != nil {
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        
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
            self.startingImageView?.alpha = 1.0
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
                self.activityIndicator.stopAnimating()
                if let url = imageURL {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
                                image = UIImage(data: imageData! as Data)!
                                UserDefaults.standard.set(imageData, forKey: "defaultInstaImage")
                                print(UserDefaults.standard.data(forKey: "defaultInstaImage") as Any)
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
                self.activityIndicator.stopAnimating()
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
                self.activityIndicator.stopAnimating()
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
        print("Inside contact")
        databaseHandle = ref.child("users").child(uid).child("ContactQrUrl").observe(.childAdded) { (snapshot) in
            let contactCode = snapshot.value as? String
            print(contactCode! + " This is contact code")
            if let actualCode  = contactCode {
                print(actualCode)
                let imageURL = URL(string: actualCode)
                print(imageURL!)
                var image: UIImage?
                self.activityIndicator.stopAnimating()
                if let url = imageURL {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
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
           //Link to app store review page
           /*
            let appID = "959379869"
            if let checkURL = URL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8") {
                open(url: checkURL)
            } else {
                print("invalid url")
            }
*/
            rateApp(appId: "1349876313") { success in
                print("RateApp \(success)")
            }
 
        }
    }
 
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "https://itunes.apple.com/us/app/nexus-communications/id1349876313?ls=1&mt=8") else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
 /*
    func open(url: URL) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open \(url): \(success)")
            })
        } else if UIApplication.shared.openURL(url) {
            print("Open \(url)")
        }
    }
   */
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
        UserDefaults.standard.removeObject(forKey: "instagramURL")
        UserDefaults.standard.removeObject(forKey: "snapchatURL")
        UserDefaults.standard.removeObject(forKey: "twitterURL")
        UserDefaults.standard.removeObject(forKey: "contactURL")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "UIViewController-BYZ-38-t0r")
        self.present(signInVC, animated: true, completion: nil)
    }
}
