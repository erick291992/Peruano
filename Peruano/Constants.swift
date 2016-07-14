//
//  Constants.swift
//  Peruano
//
//  Created by Erick Manrique on 7/14/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import Foundation

struct Constants {
    struct OrderRightAPI {
        static let APIBaseURL = "http://184.72.110.159/api"
        static let APIScheme = "http"
        static let APIHost = "184.72.110.159"
        static let APIPath = "/api"
    }
    
    struct Firebase {
        static let KEY_UID = "uid"
        
    }
    struct Segues {
        static let SEGUE_LOGGED_IN = "loggedIn"
    }
    struct RestaurantDefaults {
        static let STATE = "New York"
        static let REGION = "Long Island"
    }
    
    struct EventDefaults {
        static let STATE = "New York"
        static let ALL = "All"
    }
    
    struct VideoDefaults {
        static let VIDEO = "Music"
        static let TYPE = "Cumbia"
        
    }
}