//
//  SettingCell.swift
//  Nexus
//
//  Created by Nick potts on 1/26/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray: UIColor.white
        }
    }
    
    var setting: SignOut? {
        didSet {
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Out"
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vertMenu")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        //horizontal and vertical constraints
        addConstraintsWithFormat(format: "H:|-10-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraints([NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])

    
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
