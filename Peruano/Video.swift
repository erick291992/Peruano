//
//  Video.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import Foundation
import Firebase

class Video{
    struct Keys {
        static let Name = "name"
        static let Description = "description"
        static let UrlLink = "urlLink"
    }
    var name:String!
    var description:String!
    var urlLink:String!
    
    
    init(snapshot: FIRDataSnapshot){
        self.name = snapshot.value![Keys.Name] as! String
        self.description = snapshot.value![Keys.Description] as! String
        self.urlLink = snapshot.value![Keys.UrlLink] as! String
    }
}