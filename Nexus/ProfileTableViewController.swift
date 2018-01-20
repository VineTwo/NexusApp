//
//  ProfileTableViewController.swift
//  Nexus
//
//  Created by Nick potts on 1/19/18.
//  Copyright © 2018 Matthew Foote. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileTableViewController: UITableViewController {
    var databaseHandle = DatabaseHandle()
    var imageURLs = [String]()
    let uid = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        imageURLs = ["https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=https://www.instagram.com/nick_potts21"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell")
        let imageView = cell?.viewWithTag(1) as! UIImageView
        
        imageView.sd_setImage(with: URL(string: imageURLs[indexPath.row]))
        
        return cell!
    }
    
}
