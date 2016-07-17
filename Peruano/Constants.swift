//
//  Constants.swift
//  Peruano
//
//  Created by Erick Manrique on 7/14/16.
//  Copyright © 2016 SolorApps. All rights reserved.
//

import Foundation

struct Constants {
    struct RestaurantDefaults {
        static let STATE = "New York"
        static let REGION = "Long Island"
        static let DatabasePath = "Restaurants"
    }
    
    struct EventDefaults {
        static let STATE = "New York"
        static let ALL = "All"
        static let DatabasePath = "Events"
    }
    
    struct VideoDefaults {
        static let VIDEO = "Music"
        static let TYPE = "Cumbia"
        static let DatabasePath = "Video"
        
    }
    
    struct Selectors {
        static let KeyboardWillShow: Selector = "keyboardWillShow:"
        static let KeyboardWillHide: Selector = "keyboardWillHide:"
        static let KeyboardDidShow: Selector = "keyboardDidShow:"
        static let KeyboardDidHide: Selector = "keyboardDidHide:"
    }
}