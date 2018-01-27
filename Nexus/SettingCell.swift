//
//  SettingCell.swift
//  Nexus
//
//  Created by Nick potts on 1/26/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Out"
        return label
    }()
    override func setUpViews() {
        super.setUpViews()
        addSubview(nameLabel)
        //horizontal and vertical constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)

    
    }
}


//adds contrant to collection view cells
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
