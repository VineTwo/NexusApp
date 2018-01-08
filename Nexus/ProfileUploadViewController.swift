//
//  ProfileUploadViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileUploadViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    profilePicture.layer.cornerRadius = 40
    profilePicture.clipsToBounds = true

     //  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileUploadViewController.handleSelectProfileImageView))
  //  profilePicture.addGestureRecognizer(tapGesture)
        
func handleSelectProfileImageView() {
            
        }

    



    }
    
}
//extension ProfileUploadViewController: {
 //   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 //  }
    
 //  }
