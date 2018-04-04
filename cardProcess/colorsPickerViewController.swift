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
    let myPickerData = [String](arrayLiteral: "Blue", "Brown", "Black", "Red", "Green", "Yellow", "Gray",  "Orange", "Purple", "Magenta", "White")
    override func viewDidLoad() {
        super.viewDidLoad()
        firstColorTextField.inputView = colorPicker
        colorPicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1}
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return myPickerData.count}
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return myPickerData[row]}
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { firstColorTextField.text = myPickerData[row]}

    

  

}
