//
//  SignUpViewController.swift
//  Nexus2
//
//  Created by Nick potts on 1/7/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import GoogleSignIn

class SignUpViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
  
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var signUpErrorLabel: UILabel!
   // @IBOutlet weak var signInButton: GIDSignInButton!
    
    var selectedImage: UIImage?
    var defaultImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpErrorLabel.isHidden = true
        //Google sign in
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        
        emailTextField.tintColor = UIColor.lightText
        emailTextField.textColor = UIColor.black
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 34, width: 335.53, height: 0.6)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        passwordTextField.tintColor = UIColor.lightText
        passwordTextField.textColor = UIColor.black
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 34, width: 335.53, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        
        signUpButton.isEnabled = false
        signUpButton.layer.cornerRadius = 10.0
       // signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
       // signUpButton.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
        profilePicture.layer.cornerRadius = 30
        profilePicture.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectProfileImageView))
        profilePicture.addGestureRecognizer(tapGesture)
        profilePicture.isUserInteractionEnabled = true
        
        
        
        handleTextField()
        
        //google
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 625, width: view.frame.width - 32, height: 36)
        view.addSubview(googleButton)
       
        
      
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let err = error {
            print(err)
        }
        else {
            self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
        }
    }
 /*
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        print("Google")
        if (error == nil) {
            print("No error from signupVC")
           return
        } else {
            print("\(error.localizedDescription)")
            print("Error")
        }

    }
    */
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to login:", err)
            return
        }
        print("Login successfull", user)
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let err = error {
                print("Failed to create Firebase user with Google account", err)
                return
            }
            // User is signed in
            guard let uid = user?.uid else {return}
            var phone = " "
            let email = user?.email
            if user?.phoneNumber != nil {
                phone = (user?.phoneNumber)!
            }
            let name = user?.displayName
            let ref = Database.database().reference()
            let usersReference = ref.child("users")
            let newUsersReference = usersReference.child(uid)
            newUsersReference.setValue(["email": email!, "phone": phone, "Name": name!])
            print("Successfuly in firebase auth and database", uid)
            print("before segue")
            self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
        }
    }
 
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            return
        }
        if isValidEmailAddress(emailAddressString: emailTextField.text!) {
            signUpButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            signUpButton.isEnabled = true
        }
        
    }
    
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    

    @IBAction func SignUpBtn_TouchUpInside(_ sender: Any) {
        if !isValidEmailAddress(emailAddressString: emailTextField.text!) {
            displayAlertMessage(messageToDisplay: "Invalid Email Address.")
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: {
            (user: User?, error: Error?) in
            if error != nil {
                self.signUpErrorLabel.isHidden = false
                if error?.localizedDescription == "The email address is already in use by another account." {
                    self.signUpErrorLabel.text = "Sign up error. Email already used."
                }
                if error?.localizedDescription == "The password must be 6 characters long or more." {
                    self.signUpErrorLabel.text = "Password must be 6 characters."
                }
                print(error?.localizedDescription as Any)
                return
            }
        
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("Profile Image").child(uid!)
            
            if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
                storageRef.putData(imageData, metadata: nil, completion: {
                    (metadata, error) in
                    if error != nil {
                        print("Error when no profile selected")
                      // self.setUserInfo(email: self.emailTextField.text!, password: self.passwordTextField.text!, uid: uid!)
                    }
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
                    self.setUserInformation(email: self.emailTextField.text!, password: self.passwordTextField.text!, uid: uid!,profileImgUrl: profileImageUrl! )
                })
                
            }
            else {
                self.setUserInformation(email: self.emailTextField.text!, password: self.passwordTextField.text!, uid: uid!, profileImgUrl: " ")
               // self.setUserInfo(email: self.emailTextField.text!, password: self.passwordTextField.text!, uid: uid!)

            }

        })

    }
 
    func setUserInformation(email: String, password: String, uid: String, profileImgUrl: String) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUsersReference = usersReference.child(uid)
        newUsersReference.setValue(["email": email, "passwords": password, "ProfileIMG": profileImgUrl, "name": " "])
        print("Added to database")
        self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
        
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var validEmail = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                validEmail = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            validEmail = false
        }
        
        return  validEmail
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did finish picking picture")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            profilePicture.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
