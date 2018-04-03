//
//  businessCardViewController.swift
//  Nexus
//
//  Created by Nick potts on 3/29/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class businessCardViewController: UIViewController {

    @IBOutlet weak var orientationErrorLabel: UILabel!
    @IBOutlet weak var bottomLayer: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var topLayer: UIView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var jobTextField: UILabel!
    
    @IBOutlet weak var phoneNumTextField: UILabel!
    
    @IBOutlet weak var emailTextField: UILabel!
    
    @IBOutlet weak var websiteTextField: UILabel!
    
    @IBOutlet weak var addressTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            orientationErrorLabel.isHidden = true
       
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        
        let company = UserDefaults.standard.object(forKey: "companyName") as? String
        companyLabel.text = company
        let name = UserDefaults.standard.object(forKey: "name") as? String
        nameTextField.text = name
        let job = UserDefaults.standard.object(forKey: "jobTitle") as? String
        jobTextField.text = job
        let phone = UserDefaults.standard.object(forKey: "phone") as? String
        phoneNumTextField.text = phone
        let email = UserDefaults.standard.object(forKey: "email") as? String
        emailTextField.text = email
      //  let website = UserDefaults.standard.object(forKey: "website") as? String need to add this to card process
        let address = UserDefaults.standard.object(forKey: "address") as? String
        addressTextField.text = address
        
        // Do any additional setup after loading the view.

   }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            bottomLayer.isHidden = false
            companyLabel.isHidden = false
            topLayer.isHidden = false
            nameTextField.isHidden = false
            jobTextField.isHidden = false
            phoneNumTextField.isHidden = false
            emailTextField.isHidden = false
            websiteTextField.isHidden = false
            addressTextField.isHidden = false
            print("Landscape")
            orientationErrorLabel.isHidden = true
        } else {
            bottomLayer.isHidden = true
            companyLabel.isHidden = true
            topLayer.isHidden = true
            nameTextField.isHidden = true
            jobTextField.isHidden = true
            phoneNumTextField.isHidden = true
            emailTextField.isHidden = true
            websiteTextField.isHidden = true
            addressTextField.isHidden = true
            print("Portrait")
            orientationErrorLabel.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Inside disappear")
        //If we remove this if statement it works. HOWEVER, the other views get fucked up even worse than if we keep it
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
            print("Inside if")
        }
        
    }
    
    @objc func canRotate() -> Void {}
   
    
    
}

