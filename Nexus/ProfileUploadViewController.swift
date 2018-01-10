//
//  ProfileUploadViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileUploadViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            let profileIdString = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("Profile Image").child(profileIdString)
            storageRef.putData(imageData, metadata: nil, completion: {
                (metadata, error) in
                if error != nil {
                    return
                }
                let profileImageUrl = metadata?.downloadURL()?.absoluteString
                self.sendDataToDatabase(profileImageUrl: profileImageUrl!)
            })
        }
      
    }
    
    func sendDataToDatabase(profileImageUrl: String) {
        let userID = Auth.auth().currentUser?.uid
       
        let ref = Database.database().reference().child("users").child(userID!)
        let profileImagesReference = ref.child("profileImages")
        let profileID = profileImagesReference.childByAutoId().key
        let newProfileImage = profileImagesReference.child(profileID)
        newProfileImage.setValue(["profileImageURL": profileImageUrl])
    }
  
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

