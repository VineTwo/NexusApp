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
       
        
        instaLabel.isHidden = false
        twitterLabel.isHidden = false
        snapLabel.isHidden = false
        
        generateButton.isHidden = true
    
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
        if let twitterDefault = UserDefaults.standard.object(forKey: "myTwitter") as? String {
            twitterTextField.text = twitterDefault
        }
        if let snapDefault = UserDefaults.standard.object(forKey: "mySnap") as? String {
            snapchatTextField.text = snapDefault
        }
        
    }
    
    func instagramQRCode() {
        let insta = ("https://www.instagram.com/\(instagramTextField.text!)")
        
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(insta)")
        var image: UIImage?
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)!
                        self.qrCodeImage.image = image
                        self.qrCodeImage.sizeToFit()
                    }
                    else {
                    }
                    //This saves the image data and displays it but only when the button is pressed. Need a way to permenantly save it
                    UserDefaults.standard.set(imageData, forKey: "instaImageData")
                    let data = UserDefaults.standard.object(forKey: "instaImageData") as! NSData
                    self.qrCodeImage.image = UIImage(data: data as Data)
                    print("picture loaded")
                    
                }
            }
        }
    }
    
    
    func twitterQRCode() {
            let twitterURL = ("https://twitter.com/\(twitterTextField.text!)")
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(twitterURL)")
        var image: UIImage?
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)!
                        self.twitterqrCodeImage.image = image
                        self.twitterqrCodeImage.sizeToFit()
                    }
                    else {
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
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)!
                        self.snapqrCodeImage.image = image
                        self.snapqrCodeImage.sizeToFit()
                    }
                    else {
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
