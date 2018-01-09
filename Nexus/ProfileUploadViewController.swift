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
import FirebaseStorage

class ProfileUploadViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // using this to send photo to Firebase
       // let ref = Database.database().reference()
       // let usersReference = ref.child("users")
      //  let uid = user?.uid
        
        //Changes look of profile picture lower # = more square
    profilePicture.layer.cornerRadius = 25
    profilePicture.clipsToBounds = true
    //allows user to tap on the image
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileUploadViewController.handleSelectProfileImageView))
    profilePicture.addGestureRecognizer(tapGesture)
    profilePicture.isUserInteractionEnabled = true
        
    }
    //function that handles when image is tapped
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self //self is delegate of the image picker
        present(pickerController, animated: true, completion: nil)
    }
    
 //   let storageRef = Storage.storage().reference(forURL: "gs://nexus-app-6f0eb.appspot.com").child("Profile_Image").child(SignUpViewController.uid!)
}
extension ProfileUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did finish picking picture")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            profilePicture.image = image
        }
        dismiss(animated: true, completion: nil)
   }
    
    }
