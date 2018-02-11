//
//  ConnectViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/12/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

    @IBOutlet weak var socialCodeButton: UIButton!
    
    @IBOutlet weak var contactCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        socialCodeButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        socialCodeButton.layer.cornerRadius = 7.0
        socialCodeButton.layer.shadowColor = UIColor.gray.cgColor
        socialCodeButton.layer.shadowRadius = 2.5
        socialCodeButton.layer.shadowOpacity = 0.4
        socialCodeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        contactCodeButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        contactCodeButton.layer.cornerRadius = 7.0
        contactCodeButton.layer.shadowColor = UIColor.gray.cgColor
        contactCodeButton.layer.shadowRadius = 2.5
        contactCodeButton.layer.shadowOpacity = 0.4
        contactCodeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    

}
