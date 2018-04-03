//
//  businessCardViewController.swift
//  Nexus
//
//  Created by Nick potts on 3/29/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class businessCardViewController: UIViewController {

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

       
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        
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
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        
    }
    
    @objc func canRotate() -> Void {}
   
    
    
}

