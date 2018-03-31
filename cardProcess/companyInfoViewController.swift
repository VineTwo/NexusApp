//
//  companyInfoViewController.swift
//  Nexus
//
//  Created by Nick potts on 3/30/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class companyInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var companyNameTextField: UITextField!
    
    @IBOutlet weak var companyAddyTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var stateZipTextField: UITextField!
   
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting items off the screen
        companyNameTextField.center.x = self.view.frame.width + 300
        companyAddyTextField.center.x = self.view.frame.width + 300
        cityTextField.center.x = self.view.frame.width + 300
        stateZipTextField.center.x = self.view.frame.width + 300
        nextButton.center.x = self.view.frame.width + 300
        
        //Button design
        nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        nextButton.backgroundColor = UIColor.gray
        nextButton.layer.cornerRadius = 7.0
        nextButton.layer.shadowColor = UIColor.gray.cgColor
        nextButton.layer.shadowRadius = 2.5
        nextButton.layer.shadowOpacity = 0.4
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        animateElements()
        
        // Do any additional setup after loading the view.
    }

    func animateElements() {
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.companyNameTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.companyAddyTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.4, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.cityTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.7, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.stateZipTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 2.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.nextButton.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        
    }
    

   

}
