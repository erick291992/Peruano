//
//  DataService.swift
//  Peruano
//
//  Created by Erick Manrique on 7/1/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import Foundation
import Firebase

class DataService {

    private var _REF_DATABASE = FIRDatabase.database().reference()
    
    var REF_STATES:FIRDatabaseReference {
        return _REF_DATABASE.child("States")
    }
    var REF_RESTAURANTS:FIRDatabaseReference {
        return _REF_DATABASE.child("Restaurants")
    }
    var REF_EVENTS:FIRDatabaseReference {
        return _REF_DATABASE.child("Events")
    }
    var REF_VIDEOS:FIRDatabaseReference {
        return _REF_DATABASE.child("Video")
    }
    var REF_FEEDBACK:FIRDatabaseReference {
        return _REF_DATABASE.child("Feedback")
    }
    
    func getCategory(databasePath:String, completionHandlerForCategory:(fetchedArray:[String], reference:FIRDatabaseReference)->Void){
        var categorys = [String]()
        let REF_CATEGORY = _REF_DATABASE.child(databasePath)
        REF_CATEGORY.observeSingleEventOfType(FIRDataEventType.Value, withBlock: {snapshot in
            for value in snapshot.children{
                let val = value as! FIRDataSnapshot
//                print(val.key)
                categorys.append(val.key)
            }
            completionHandlerForCategory(fetchedArray: categorys, reference: REF_CATEGORY)
        })
    }
    
    func postFeedBack(website:String, comment:String){
        let key = REF_FEEDBACK.childByAutoId().key
        var post = [String:String]()
        let web = website.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let comm = comment.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        print(web)
        if web != ""{
            post["website"] = website
        }
        if comm != ""{
            post["comment"] = comment
        }
        REF_FEEDBACK.child(key).setValue(post)
    }
    
    func getRestaurantsByRegion(state:String, region:String, completionHandlerForRestaurants:(fetchedRestaurants:[Info], reference:FIRDatabaseReference)->Void){
        var restaurants = [Info]()
        let REF = REF_RESTAURANTS.child(state).child(region)
        REF.queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let restaurant = Info(snapshot: snapshot)
            restaurants.append(restaurant)
            completionHandlerForRestaurants(fetchedRestaurants: restaurants, reference: REF)
        })
    }
    
    func getEveryThing(state:String,completionHandlerForRestaurants:(fetchedRestaurants:[Info], reference:FIRDatabaseReference)->Void){
        let REF = REF_RESTAURANTS.child(state)
        REF.observeSingleEventOfType(FIRDataEventType.Value, withBlock: {snapshot in
            var restaurants = [Info]()
            for value in snapshot.children{
                let region = value as! FIRDataSnapshot
                print("region one two")
                let REFRES = self.REF_RESTAURANTS.child(state).child(region.key)
                REFRES.queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
                    let restaurant = Info(snapshot: snapshot)
                    restaurants.append(restaurant)
                    
                    REFRES.removeAllObservers()
                    completionHandlerForRestaurants(fetchedRestaurants: restaurants, reference: REF)
                })
            }
        })
    }
    
    func getEventsByState(state:String, completionHandlerForEvents:(fetchedEvents:[Event], referece:FIRDatabaseReference)->Void){
        var events = [Event]()
        let REF = REF_EVENTS.child(state).child("All")
        REF.queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let event = Event(snapshot: snapshot)
            events.append(event)
            REF.removeAllObservers()
            completionHandlerForEvents(fetchedEvents: events, referece: REF)
        })
    }
    
    func getVideosByCategory(category:String, type:String, completionHandlerForVideos:(fetchedVideos:[Video])->Void){
        var videos = [Video]()
        let REF = REF_VIDEOS.child(category).child(type)
        REF.queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let video = Video(snapshot: snapshot)
            videos.append(video)
            REF.removeAllObservers()
            completionHandlerForVideos(fetchedVideos: videos)
        })
    }
    
    func getCurrentDay()-> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.stringFromDate(NSDate())
        return dayOfWeekString
    }
    
    class func sharedInstance() -> DataService {
        struct Singleton {
            static var sharedInstance = DataService()
        }
        return Singleton.sharedInstance
    }
}
