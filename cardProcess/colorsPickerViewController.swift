//
//  colorsPickerViewController.swift
//  Nexus
//
//  Created by Nick potts on 4/4/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class colorsPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var firstColorTextField: UITextField!
    
    @IBOutlet weak var secondColorTextField: UITextField!
    
    let colorPicker = UIPickerView()
    let secondColorPicker = UIPickerView()
    let myPickerData = [String](arrayLiteral: "Blue", "Brown", "Black", "Red", "Green", "Yellow", "Gray",  "Orange", "Purple", "Magenta", "White")
    let secondPickerData = [String](arrayLiteral: "Blue", "Brown", "Black", "Red", "Green", "Yellow", "Gray",  "Orange", "Purple", "Magenta", "White")
    override func viewDidLoad() {
        super.viewDidLoad()
        firstColorTextField.inputView = colorPicker
        secondColorTextField.inputView = secondColorPicker
        colorPicker.delegate = self
        secondColorPicker.delegate = self
        

        // Do any additional setup after loading the view.
    }

    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1}
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(firstColorTextField.isFirstResponder) {
            return myPickerData.count
        } else {
            return secondPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(secondColorTextField.isFirstResponder) {
            return secondPickerData[row]
        } else {
            return myPickerData[row]
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        firstColorTextField.text = myPickerData[row]
        secondColorTextField.text = secondPickerData[row]
    }

    
    @IBAction func finishButton_TouchUpInside(_ sender: Any) {
        UserDefaults.standard.set(firstColorTextField.text, forKey: "firstColor")
        UserDefaults.standard.set(firstColorTextField.text, forKey: "secondColor")
    }
    
  

}
