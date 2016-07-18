//
//  EventTableViewCell.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var urlLink:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGestureRecognizer()
    }
    
    func setupGestureRecognizer(){
        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(EventTableViewCell.phoneTapped(_:)))
        tapPhone.numberOfTapsRequired = 1
        phoneLabel.addGestureRecognizer(tapPhone)
        phoneLabel.userInteractionEnabled = true
        
        let tapAddress = UITapGestureRecognizer(target: self, action: #selector(EventTableViewCell.addressTapped(_:)))
        tapAddress.numberOfTapsRequired = 1
        addressLabel.addGestureRecognizer(tapAddress)
        addressLabel.userInteractionEnabled = true
        
        let tapTitle = UITapGestureRecognizer(target: self, action: #selector(EventTableViewCell.titleTapped(_:)))
        tapTitle.numberOfTapsRequired = 1
        titleLabel.addGestureRecognizer(tapTitle)
        titleLabel.userInteractionEnabled = true
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
    
    func addressTapped(sender: UITapGestureRecognizer) {
        if let address = addressLabel.text{
            UrlAppLauncher.sharedInstance().launchMapUsingAddress(address)
        }
    }
    func titleTapped(sender: UITapGestureRecognizer) {
        if let link = urlLink{
            UrlAppLauncher.sharedInstance().openLink(link)
        }
    }
    
}
