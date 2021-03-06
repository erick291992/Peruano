//
//  Event.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import Foundation
import Firebase

class Event{
    struct Keys {
        static let Name = "name"
        static let Phone = "phone"
        static let Date = "date"
        static let Address = "address"
        static let Link = "urlLink"
        static let ImageUrl = "imageUrl"
    }
    var name:String!
    var phone:String!
    var date:String!
    var address:String!
    var link:String!
    var imageUrl:String?
    
    
    init(snapshot: FIRDataSnapshot){
        self.name = snapshot.value![Keys.Name] as! String
        self.address = snapshot.value![Keys.Address] as! String
        self.date = snapshot.value![Keys.Date] as! String
        self.phone = snapshot.value![Keys.Phone] as! String
        self.link = snapshot.value![Keys.Link] as! String
        if let url =  snapshot.value![Keys.ImageUrl]{
            self.imageUrl = url as? String
        }
    }
}