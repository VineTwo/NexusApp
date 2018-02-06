//
//  SplashScreenViewController.swift
//  Nexus
//
//  Created by Nick potts on 2/6/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var nexusLogoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: nexusLogoImage.frame.width, height: 0.6)
        topLayer.backgroundColor = UIColor.red.cgColor
        nexusLogoImage.layer.addSublayer(topLayer)
        
        

        // Do any additional setup after loading the view.
    }

   

}
