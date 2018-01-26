//
//  ContactCodeViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/14/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ContactCodeViewController: UIViewController {
 //   @IBOutlet weak var contactImageVIew: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var profilePagePrompt: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePagePrompt.isHidden = true
   
        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func generateButton_TouchUpInside(_ sender: Any) {
        let name = firstNameTextField.text! + lastNameTextField.text!
        let phone = phoneNumberTextField.text!
        let email = emailTextField.text!
       // "MECARD:N:Joe_Morales;TEL:6191029501;EMAIL:first.last@email.com;URL:http://website.com;;"
        let contactInfo = "MECARD:N:\(name);TEL:\(phone);EMAIL:\(email)"
        
        
        let contactInfoAsString = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(contactInfo)")
        setContactQrCode(contactImageString: contactInfoAsString)
        
   
        firstNameTextField.isHidden = true
        lastNameTextField.isHidden = true
        emailTextField.isHidden = true
        phoneNumberTextField.isHidden = true
        profilePagePrompt.isHidden = false
        
    }
    
    func setContactQrCode(contactImageString: String) {
        
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("ContactQrUrl")
        userRef.setValue(["ContactQrURL": contactImageString])
        
    }
    

}
