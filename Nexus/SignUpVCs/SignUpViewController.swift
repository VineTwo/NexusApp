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
//import GoogleSignIn


class SignUpViewController: UIViewController, UITextFieldDelegate {
  
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var signUpErrorLabel: UILabel!
   // @IBOutlet weak var signInButton: GIDSignInButton!
    
    var selectedImage: UIImage?
    var defaultImage: UIImage?
    
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextField.isHidden = false
        passwordTextField.isHidden = false
        signUpButton.isHidden = false
        emailTextField.center.x = self.view.frame.width + 300
        passwordTextField.center.x = self.view.frame.width + 300
        signUpButton.center.x = self.view.frame.width + 300
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.emailTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.passwordTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.8, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.signUpButton.center.x = self.view.frame.width / 2.0
            
        }), completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpErrorLabel.isHidden = false
        emailTextField.isHidden = true
        passwordTextField.isHidden = true
        signUpButton.isHidden = true
        
        
        emailTextField.tintColor = UIColor.lightText
        emailTextField.textColor = UIColor.black
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: emailTextField.frame.height, width: emailTextField.frame.width, height: 0.6)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        passwordTextField.tintColor = UIColor.lightText
        passwordTextField.textColor = UIColor.black
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 0 + passwordTextField.frame.height
            , width: passwordTextField.frame.width, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        
        signUpButton.isEnabled = false
        signUpButton.layer.cornerRadius = 7.0
        signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        signUpButton.backgroundColor = UIColor.clear
        
        
        
       // signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
       // signUpButton.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
        profilePicture.layer.cornerRadius = 30
        profilePicture.clipsToBounds = true
        
        //layer above sign in button on bottom of screen
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 3, width: view.frame.width, height: 0.7)
        topLayer.backgroundColor = UIColor.darkGray.cgColor
        signInButton.layer.addSublayer(topLayer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectProfileImageView))
        profilePicture.addGestureRecognizer(tapGesture)
        profilePicture.isUserInteractionEnabled = true
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.tag = 1
        
        handleTextField()
        
        //google
      //  let googleButton = GIDSignInButton()
      //  googleButton.frame = CGRect(x: 16, y: 625, width: view.frame.width - 32, height: 36)
      //  view.addSubview(googleButton)
       
        
      
    }
    
    //Hide keyboard when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
  /*
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let err = error {
            print(err)
        }
        else {
            self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
        }
    }
 */
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
 */
     func emailHasBeenUsedBefore() {
        
        let err = NSError()
        if let errCode = AuthErrorCode(rawValue: err.code) {
            
            if errCode == AuthErrorCode.emailAlreadyInUse {
                print("Email has been used")
                self.signUpErrorLabel.text = "The email has already been used."
                self.signUpButton.isEnabled = false
            }
  
            signUpButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(red: 0.4, green: 0.3, blue: 0.4, alpha: 0.6)
        }
        
    }
    
    @objc func passwordIsLongEnough() {
        if (passwordTextField.text?.count)! < 6 {
        signUpButton.isEnabled = false
        self.passwordTextField.shake()
        signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        signUpButton.backgroundColor = UIColor.clear
        self.signUpErrorLabel.text = "The password must be 6 characters."
        }
        else {
            self.signUpErrorLabel.text = " "
        }
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
      //  emailTextField.addTarget(self, action: #selector(SignUpViewController.emailHasBeenUsedBefore), for: UIControlEvents.editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.passwordIsLongEnough), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            return
        }
        if isValidEmailAddress(emailAddressString: emailTextField.text!) {
            emailHasBeenUsedBefore()
            signUpButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            //signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(red: 0.4, green: 0.3, blue: 0.4, alpha: 0.6)
        }
        self.signUpErrorLabel.text = "Please enter a valid email."
    }
    
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    

    @IBAction func SignUpBtn_TouchUpInside(_ sender: Any) {
        if !isValidEmailAddress(emailAddressString: emailTextField.text!) {
            self.signUpErrorLabel.text = "Please enter a valid email address."
            self.emailTextField.shake()
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: {
            (user: User?, error: Error?) in
           /*
            let err = NSError()
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: err.code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        self.signUpErrorLabel.text = "The email has already been used."
                        break;
                    case .invalidCustomToken:
                        break;
                    case .customTokenMismatch:
                        break;
                    case .invalidCredential:
                        break;
                    case .userDisabled:
                        break;
                    case .operationNotAllowed:
                        break;
                    case .invalidEmail:
                        break;
                    case .wrongPassword:
                        break;
                    case .tooManyRequests:
                        break;
                    case .userNotFound:
                        break;
                    case .accountExistsWithDifferentCredential:
                        break;
                    case .requiresRecentLogin:
                        break;
                    case .providerAlreadyLinked:
                        break;
                    case .noSuchProvider:
                        break;
                    case .invalidUserToken:
                        break;
                    case .networkError:
                        break;
                    case .userTokenExpired:
                        break;
                    case .invalidAPIKey:
                        break;
                    case .userMismatch:
                        break;
                    case .credentialAlreadyInUse:
                        break;
                    case .weakPassword:
                        break;
                    case .appNotAuthorized:
                        break;
                    case .expiredActionCode:
                        break;
                    case .invalidActionCode:
                        break;
                    case .invalidMessagePayload:
                        break;
                    case .invalidSender:
                        break;
                    case .invalidRecipientEmail:
                        break;
                    case .missingEmail:
                        break;
                    case .missingIosBundleID:
                        break;
                    case .missingAndroidPackageName:
                        break;
                    case .unauthorizedDomain:
                        break;
                    case .invalidContinueURI:
                        break;
                    case .missingContinueURI:
                        break;
                    case .missingPhoneNumber:
                        break;
                    case .invalidPhoneNumber:
                        break;
                    case .missingVerificationCode:
                        break;
                    case .invalidVerificationCode:
                        break;
                    case .missingVerificationID:
                        break;
                    case .invalidVerificationID:
                        break;
                    case .missingAppCredential:
                        break;
                    case .invalidAppCredential:
                        break;
                    case .sessionExpired:
                        break;
                    case .quotaExceeded:
                        break;
                    case .missingAppToken:
                        break;
                    case .notificationNotForwarded:
                        break;
                    case .appNotVerified:
                        break;
                    case .captchaCheckFailed:
                        break;
                    case .webContextAlreadyPresented:
                        break;
                    case .webContextCancelled:
                        break;
                    case .appVerificationUserInteractionFailure:
                        break;
                    case .invalidClientID:
                        break;
                    case .webNetworkRequestFailed:
                        break;
                    case .webInternalError:
                        break;
                    case .keychainError:
                        break;
                    case .internalError:
                        break;
                    }
                    
                }
                self.signUpErrorLabel.isHidden = false
                if error!.localizedDescription == "The email address is already in use by another account." {
                    self.signUpErrorLabel.text = "Sign up error. Email already used."
                }
                print(error!.localizedDescription as Any)
                return
            } */
           // else {
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("Profile Image").child(uid!)
            
            if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
                storageRef.putData(imageData, metadata: nil, completion: {
                    (metadata, error) in
                    if error != nil {
                        //There is an error so the profile image was not selected thus the URL is blank
                    }
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
                    self.setUserInformation(email: self.emailTextField.text!, uid: uid!,profileImgUrl: profileImageUrl! )
                })
            }
                self.setUserInformation(email: self.emailTextField.text!, uid: uid!, profileImgUrl: " ")
                
            //}

        })

    }
    
    func isValidPassword(passwordLength: String) -> Bool {
       // let length = passwordTextField.text?.count
        if (passwordLength.count < 6) {
            return false;
        }
        return true
    }
 
    func setUserInformation(email: String, uid: String, profileImgUrl: String) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUsersReference = usersReference.child(uid)
        newUsersReference.setValue(["email": email, "ProfileIMG": profileImgUrl, "Name": " "])
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
            validEmail = false
            print(error)
        }
        
        return  validEmail
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
            profilePicture.image = editedImage
        }
    
        else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            profilePicture.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
