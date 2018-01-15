//
//  SocialCodeViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/14/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class SocialCodeViewController: UIViewController {

    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    
    @IBAction func generateQRButton_TouchUpInside(_ sender: Any) {
        instagramTextField.isHidden = true
        twitterTextField.isHidden = true
        snapchatTextField.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   

}
