//
//  Extensions.swift
//  Peruano
//
//  Created by Erick Manrique on 7/11/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import UIKit

extension String{
    //IOS 9 ONLY
//    func removeAll(characters: [Character]) -> String {
//        return String(self.characters.filter({ !characters.contains($0)}))
//    }
    
}

let imageCache = NSCache()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        let url = NSURL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.objectForKey(urlString) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString)
            })
            
        }).resume()
    }
    
}