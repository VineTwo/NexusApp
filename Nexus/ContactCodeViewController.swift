//
//  ContactCodeViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/14/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class ContactCodeViewController: UIViewController {
    @IBOutlet weak var contactImageVIew: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
   
        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func generateButton_TouchUpInside(_ sender: Any) {
        let name = firstNameTextField.text! + lastNameTextField.text!
        let phone = phoneNumberTextField.text!
        let email = emailTextField.text!
       // "MECARD:N:Joe_Morales;TEL:6191029501;EMAIL:first.last@email.com;URL:http://website.com;;"
        let contactInfo = "MECARD:N:\(name);TEL:\(phone);EMAIL:\(email)"
        
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(contactInfo)")
        var image: UIImage?
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)!
                        self.contactImageVIew.image = image
                        self.contactImageVIew.sizeToFit()
                    }
                    
                }
            }
        }
        
        
        
        
    }
    

}
