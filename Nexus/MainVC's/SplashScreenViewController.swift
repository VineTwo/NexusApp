//
//  SplashScreenViewController.swift
//  Nexus
//
//  Created by Nick potts on 2/6/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var nexusLogo: UIImageView!
    //@IBOutlet weak var nexusLogoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Splashscreen did show")
        
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: nexusLogo.frame.height, width: nexusLogo.frame.width, height: 5)
        bottomLayer.backgroundColor = UIColor.red.cgColor
        bottomLayer.cornerRadius = 5;
        nexusLogo.layer.addSublayer(bottomLayer)
        
       /*
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10)
        topLayer.backgroundColor = UIColor.red.cgColor
        topLayer.frame.origin.y = self.view.frame.origin.y
        self.view.layer.addSublayer(topLayer)
        
      */
        let signedInView: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let signUpView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = signedInView.instantiateInitialViewController()
        let logInVC = signUpView.instantiateViewController(withIdentifier: "UIViewController-BYZ-38-t0r")
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseIn, animations: {
            bottomLayer.frame = CGRect(x: 0, y: self.nexusLogo.frame.height, width: self.nexusLogo.frame.width, height: 5)
        }, completion: { (signedIn: Bool) in
    
            UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveEaseIn, animations: {
                bottomLayer.frame = CGRect(x: 0, y: 0, width: self.nexusLogo.frame.width, height: 5)
            }, completion: { (isDone: Bool) in
                if(Auth.auth().currentUser != nil) {
                    self.present(profileVC!, animated: false, completion: nil)
                    print("Is signed in")
                }
                else {
                    self.present(logInVC, animated: false, completion: nil)
                    print("Is not signed in")
                }
                
            })
            
        })

        
    }

   

}
