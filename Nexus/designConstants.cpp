//
//  designConstants.cpp
//  Nexus
//
//  Created by Nick potts on 1/27/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

/*
 For labels at the top of a VC describing the VC make it this
 FONT: System bold 20 point
 Height: 40
 WIDTH: Width of the safe area
 
 ERROR LABELS:
 
 TEXT COLOR: RED
 HEIGHT: 40
 FONT: SYSTEM 17
 
 BUTTONS:
 
 COLOR: GRAY
 TEXTCOLOR: BLACK
 CORNERRADIUS: 7.0
 SHADOW COLOR: GRAY
 SHADOW RADIUS: 2.5
 SHADOW OPACITY: .4
 SHADOW OFFSET: (0,0)
 
 
 TEXTFIELD LINE LAYER
 
 let bottomLayer = CALayer()
 bottomLayer.frame = CGRect(x: 0, y: 28, width: emailTextField.frame.width, height: 0.6)
 bottomLayer.backgroundColor = UIColor.white.cgColor
 emailTextField.layer.addSublayer(bottomLayer)
 emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1.0)])
 
 TEXT FONTS AND STYLES
 ALL USE PINGFANG HK
 
 BUTTONS:
 Semibold size 18
 
 SCENE LABELS:
 Semibold size 20
 
 ERROR LABELS and bottom scene buttons:
 Medium Size 16
 
 REGULAR LABELS(Labels for an object)
 Regular size 17
 
 
 */
