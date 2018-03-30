//
//  jobAndEmailViewController.swift
//  Nexus
//
//  Created by Nick potts on 3/30/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class jobAndEmailViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var jobTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        jobTextField.center.x = self.view.frame.width + 300
        emailTextField.center.x = self.view.frame.width + 300
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.jobTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.emailTextField.center.x = self.view.frame.width / 2.4
            
        }), completion: nil)
        
        handleTextField()
        // Do any additional setup after loading the view.
    }
    
    func handleTextField() {
        jobTextField.addTarget(self, action: #selector(ContactCodeViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(ContactCodeViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }

    @objc func textFieldDidChange() {
        guard let jobTitle = jobTextField.text, !jobTitle.isEmpty, let email = emailTextField.text, !email.isEmpty else {
           // errorLabel.text = "Please fill out all fields."
            errorLabel.textColor = .red
            return
        }
        nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        nextButton.backgroundColor = UIColor.gray
        nextButton.layer.cornerRadius = 7.0
        nextButton.layer.shadowColor = UIColor.gray.cgColor
        nextButton.layer.shadowRadius = 2.5
        nextButton.layer.shadowOpacity = 0.4
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        handleTextField()
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.nextButton.center.x = self.view.frame.width / 2.2
            
        }), completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toFinalSegue" {
            if(isValidEmail(emailString: self.emailTextField.text!)  &&  !((self.jobTextField.text?.isEmpty)!)   ) {
                UserDefaults.standard.set(jobTextField.text, forKey: "jobTitle")
                UserDefaults.standard.set(emailTextField.text, forKey: "email")
                return true
            } else {
                self.errorLabel.text = "Please enter a valid email"
                return false
            }
            
        }
        return true
    }
    
    func isValidEmail(emailString: String)-> Bool {
        var validEmail = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailString as NSString
            let results = regex.matches(in: emailString, range: NSRange(location: 0, length: nsString.length))
            
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
    
    
    

}
