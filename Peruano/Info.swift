//
//  Info.swift
//  Peruano
//
//  Created by Erick Manrique on 7/5/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import Foundation
import Firebase
class Info{
    struct Keys {
        static let Name = "name"
        static let Phone = "phone"
        static let Hours = "hours"
        static let Address = "address"
    }
    var name:String!
    var phone:String!
    var hours:String!
    var address:String!
    
    
    init(snapshot: FIRDataSnapshot){
        self.name = snapshot.value![Keys.Name] as! String
        self.address = snapshot.value![Keys.Address] as! String
        self.hours = snapshot.value![Keys.Hours] as! String
        self.phone = snapshot.value![Keys.Phone] as! String
    }
}