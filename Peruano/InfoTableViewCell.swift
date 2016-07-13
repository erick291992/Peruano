//
//  InfoTableViewCell.swift
//  Peruano
//
//  Created by Erick Manrique on 7/3/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InfoTableViewCell.phoneTapped(_:)))
        tap.numberOfTapsRequired = 1
        phoneLabel.addGestureRecognizer(tap)
        phoneLabel.userInteractionEnabled = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func phoneTapped(sender: UITapGestureRecognizer) {
        if let phone = phoneLabel.text{
            UrlAppLauncher.sharedInstance().launchPhoneUsingNumber(phone)
        }
    }
}
