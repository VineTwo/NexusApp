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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contactInfo = "MECARD:N:Joe_Morales;TEL:6191029501;EMAIL:first.last@email.com;URL:http://website.com;;"
        
        let imageURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(contactInfo)")
        //userRef.setValue(["instQrURl": contactInfo])
        var image: UIImage?
        if let url = imageURL {
            print("Inside first if let")
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        print("Should see image")
                        image = UIImage(data: imageData! as Data)!
                        self.contactImageVIew.image = image
                        self.contactImageVIew.sizeToFit()
                    }
                    
                }
            }
        }
        // Do any additional setup after loading the view.
    }



}
