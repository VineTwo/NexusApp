//
//  SocialCodeViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/14/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SocialCodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var profilePrompt: UILabel!
    @IBOutlet weak var socialMediaTitleLabel: UILabel!
    
   
    @IBOutlet weak var generateButton: UIButton!
    
    
    @IBAction func generateQRButton_TouchUpInside(_ sender: Any) {
        self.snapchatTextField.delegate = self
        
        UserDefaults.standard.set(instagramTextField.text, forKey: "myInsta")
        UserDefaults.standard.set(twitterTextField.text, forKey: "myTwitter")
        UserDefaults.standard.set(snapchatTextField.text, forKey: "mySnap")
        instagramQRCode()
        twitterQRCode()
        snapQRCode()
        instagramTextField.isHidden = true
        twitterTextField.isHidden = true
        snapchatTextField.isHidden = true
        generateButton.isHidden = true
        
    
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePrompt.isHidden = true
        
        self.instagramTextField.delegate = self
        self.twitterTextField.delegate = self
        self.snapchatTextField.delegate = self
        
        instagramTextField.tag = 0
        twitterTextField.tag = 1
        snapchatTextField.tag = 2
        
        //button look
        generateButton.setTitleColor(UIColor.lightText, for: .normal)
        generateButton.backgroundColor = UIColor.clear
        generateButton.isEnabled = false
        generateButton.layer.cornerRadius = 7.0
        generateButton.layer.shadowColor = UIColor.gray.cgColor
        generateButton.layer.shadowRadius = 2.5
        generateButton.layer.shadowOpacity = 0.4
        generateButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
    }
    
    //Hide keyboard when user touches outside of keyboard

    
    override func viewDidAppear(_ animated: Bool) {
        
        if let instaDefault = UserDefaults.standard.object(forKey: "myInsta") as? String {
            instagramTextField.text = instaDefault
        }
        if let twitterDefault = UserDefaults.standard.object(forKey: "myTwitter") as? String {
            twitterTextField.text = twitterDefault
        }
        if let snapDefault = UserDefaults.standard.object(forKey: "mySnap") as? String {
            snapchatTextField.text = snapDefault
        }
        
    }
   
    //If not last textField it will go to next textField when enter is pressed
    //If last textField, keyboard will dismiss when enter key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func instagramQRCode() {
        let insta = ("https://www.instagram.com/\(instagramTextField.text!)")
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("InstagramQrUrl")
        
        
      //  let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(insta)")
        let instaQrUrl = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(insta)")
        userRef.setValue(["instQrURl": instaQrUrl])
 
    }
    
    
    func twitterQRCode() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("TwitterQrUrl")
        
            let twitterURL = ("https://twitter.com/\(twitterTextField.text!)")
       // let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(twitterURL)")
        
        let twitQrUrl = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(twitterURL)")
        userRef.setValue(["twitQrURl": twitQrUrl])
        
   
        
    }
    
    func snapQRCode() {
        
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("SnapQrUrl")
        
        let snapURL = ("https://www.snapchat.com/add/\(snapchatTextField.text!)")
      //  let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(snapURL)")
        
        let snapQrUrl = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(snapURL)")
        userRef.setValue(["snapQrURl": snapQrUrl])
        
   
        profilePrompt.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func handleTextField() {
        instagramTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        twitterTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        snapchatTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let instagram = instagramTextField.text, !instagram.isEmpty,  let twitter = twitterTextField.text, !twitter.isEmpty, let snapchat = snapchatTextField.text, !snapchat.isEmpty else {
            return
        }
    }
    
    

}
