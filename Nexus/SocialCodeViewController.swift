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
        handleTextField()
        
        //Design of Instagram Textfield
        let instagramLayerWidth = instagramTextField.frame.width
        instagramTextField.tintColor = UIColor.lightText
        instagramTextField.textColor = UIColor.black
        instagramTextField.attributedPlaceholder = NSAttributedString(string: instagramTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 28, width: instagramLayerWidth, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor.white.cgColor
        instagramTextField.layer.addSublayer(bottomLayerPassword)
        
        //Design of twitter textfield
        let twitterLayerWidth = twitterTextField.frame.width
        twitterTextField.tintColor = UIColor.lightText
        twitterTextField.textColor = UIColor.black
        twitterTextField.attributedPlaceholder = NSAttributedString(string: twitterTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let twitterBottomLayerPassword = CALayer()
        twitterBottomLayerPassword.frame = CGRect(x: 0, y: 28, width: twitterLayerWidth, height: 0.6)
        twitterBottomLayerPassword.backgroundColor = UIColor.white.cgColor
        twitterTextField.layer.addSublayer(twitterBottomLayerPassword)
        
        //Design of snapchat textfield
        let snapchatLayerWidth = snapchatTextField.frame.width
        snapchatTextField.tintColor = UIColor.lightText
        snapchatTextField.textColor = UIColor.black
        snapchatTextField.attributedPlaceholder = NSAttributedString(string: snapchatTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let snapchatBottomLayerPassword = CALayer()
        snapchatBottomLayerPassword.frame = CGRect(x: 0, y: 28, width: snapchatLayerWidth, height: 0.6)
        snapchatBottomLayerPassword.backgroundColor = UIColor.white.cgColor
        snapchatTextField.layer.addSublayer(snapchatBottomLayerPassword)
        
        areFieldsEmpty()
    }
    
    //Hide keyboard when user touches outside of keyboard

    
    override func viewDidAppear(_ animated: Bool) {
        
        if let instaDefault = UserDefaults.standard.object(forKey: "myInsta") as? String {
            instagramTextField.text = instaDefault
            generateButton.isEnabled = true
        }
        if let twitterDefault = UserDefaults.standard.object(forKey: "myTwitter") as? String {
            twitterTextField.text = twitterDefault
            generateButton.isEnabled = true
        }
        if let snapDefault = UserDefaults.standard.object(forKey: "mySnap") as? String {
            snapchatTextField.text = snapDefault
            generateButton.isEnabled = true
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
        let trimmed = instagramTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let insta = ("https://www.instagram.com/\(trimmed!)")
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("InstagramQrUrl")
        
        
        let instaQrUrl = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(insta)")
        userRef.setValue(["instQrURl": instaQrUrl])
 
    }
    
    
    func twitterQRCode() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("TwitterQrUrl")
        
        let trimmed = twitterTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let twitterURL = ("https://twitter.com/\(trimmed!)")
        let twitQrUrl = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(twitterURL)")
        userRef.setValue(["twitQrURl": twitQrUrl])
    }
    
    func snapQRCode() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("SnapQrUrl")
        
        let trimmed = snapchatTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let snapURL = ("https://www.snapchat.com/add/\(trimmed!)")
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
    
    //Generate button is enabled if one of the text fields contains text in case a user does not have an account on all 3 platforms
    @objc func textFieldDidChange() {
        if (instagramTextField.hasText || twitterTextField.hasText || snapchatTextField.hasText) {
            generateButtonIsEnabled()
        }
    }
    
    func areFieldsEmpty() {
        if(!(instagramTextField.text?.isEmpty)! && (twitterTextField.text?.isEmpty)! && (snapchatTextField.text?.isEmpty)!) {
           generateButtonIsEnabled()
            print("Fields arent empty")
        }
    }
    
    func generateButtonIsEnabled() {
        generateButton.isEnabled = true
        generateButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        generateButton.backgroundColor = UIColor.gray
        print("Button is enabled")
    }


}
