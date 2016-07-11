//
//  UrlAppLauncher.swift
//  Peruano
//
//  Created by Erick Manrique on 7/11/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import Foundation
import UIKit

class UrlAppLauncher {
    
    func launchMapUsingAddress(address: String){
        
        let newAddress = address.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let url = "http://maps.apple.com/?q=\(newAddress)"
        let targetURL = NSURL(string: url)!
        launchIfAppAvailable(targetURL)
    }
    func launchPhoneUsingNumber(phone:String){
//        let number = phone.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let ph = "(555) 555-5555"
//        let phone = ph.formatStringForPhone()
        let phone = replacePunctuationSpace(ph)
        let url = "tel://\(phone)"
        let targetURL = NSURL(string: url)!
        launchIfAppAvailable(targetURL)
    }
    private func launchIfAppAvailable(targetURL:NSURL){
        let isAvailable = UIApplication.sharedApplication().canOpenURL(targetURL)
        if isAvailable{
            UIApplication.sharedApplication().openURL(targetURL)
        }
    }
    
    func replacePunctuationSpace(inputText: String) -> String {
        let characters = ["-"," ","(",")"]
        print(characters) //Testing in console
        var newString = inputText
        
        for character in characters{
            newString = newString.stringByReplacingOccurrencesOfString(character, withString: "")
            print("Replacing \(character)  ... \(newString)")
        }
        return newString
    }
    
    
    class func sharedInstance() -> UrlAppLauncher {
        struct Singleton {
            static var sharedInstance = UrlAppLauncher()
        }
        return Singleton.sharedInstance
    }
    
}