//
//  SocialCodeViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/14/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class SocialCodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var qrCodeImage: UIImageView!
    @IBOutlet weak var twitterqrCodeImage: UIImageView!
    @IBOutlet weak var snapqrCodeImage: UIImageView!
    @IBOutlet weak var instaLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var snapLabel: UILabel!
    
    
    @IBAction func generateQRButton_TouchUpInside(_ sender: Any) {
        self.snapchatTextField.delegate = self
        print("Pressed")
        UserDefaults.standard.set(instagramTextField.text, forKey: "myInsta")
        instagramQRCode()
        instagramTextField.isHidden = true
        twitterTextField.isHidden = true
        snapchatTextField.isHidden = true
        twitterQRCode()
        snapQRCode()
        
        instaLabel.isHidden = false
        twitterLabel.isHidden = false
        snapLabel.isHidden = false
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instaLabel.isHidden = true
        twitterLabel.isHidden = true
        snapLabel.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let instaDefault = UserDefaults.standard.object(forKey: "myInsta") as? String {
            instagramTextField.text = instaDefault
        }
    }
    
    func instagramQRCode() {
        let insta = ("https://www.instagram.com/\(instagramTextField.text!)")
        
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(insta)")
        var image: UIImage?
        if let url = imageURL {
            print("Test")
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        print("second test")
                        image = UIImage(data: imageData! as Data)!
                        self.qrCodeImage.image = image
                        self.qrCodeImage.sizeToFit()
                        print("YES")
                    }
                    else {
                        print("No")
                    }
                }
            }
        }
    }
    
    func twitterQRCode() {
            let twitterURL = ("https://twitter.com/\(twitterTextField.text!)")
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(twitterURL)")
        var image: UIImage?
        if let url = imageURL {
            print("Test")
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        print("second test")
                        image = UIImage(data: imageData! as Data)!
                        self.twitterqrCodeImage.image = image
                        self.twitterqrCodeImage.sizeToFit()
                        print("YES")
                    }
                    else {
                        print("No")
                    }
                }
            }
        }
        
    }
    
    func snapQRCode() {
        let snapURL = ("https://www.snapchat.com/add/\(snapchatTextField.text!)")
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(snapURL)")
        var image: UIImage?
        if let url = imageURL {
            print("Test")
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        print("second test")
                        image = UIImage(data: imageData! as Data)!
                        self.snapqrCodeImage.image = image
                        self.snapqrCodeImage.sizeToFit()
                        print("YES")
                    }
                    else {
                        print("No")
                    }
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   

}
