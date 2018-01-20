//
//  ProfileTableViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/19/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
 
    var imageURLs = [String]()
    
    override func viewDidLoad() {
        imageURLs = ["https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=https://www.instagram.com/nick_potts21", "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/iphone/iphone7plus/iphone7plus-colors.jpg", "https://firebasestorage.googleapis.com/v0/b/nexus-app-6f0eb.appspot.com/o/Profile%20Image%2F4FXl8AciMgY0mRXedtU8iAA8KaJ2?alt=media&token=4199dc8c-2777-424d-a602-b5b23e53e2b9"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell")
        let imageView = cell?.viewWithTag(1) as! UIImageView
        
        
        
        return cell!
    }
    
}
