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
    
    func getCategoryOne(databasePath:String, completionHandlerForCategory:(fetchedArray:[String])->Void){
        var categorys = [String]()
        let REF_CATEGORY = _REF_DATABASE.child(databasePath)
        REF_CATEGORY.observeSingleEventOfType(FIRDataEventType.Value, withBlock: {snapshot in
            for value in snapshot.children{
                let val = value as! FIRDataSnapshot
//                print(val.key)
                categorys.append(val.key)
            }
            completionHandlerForCategory(fetchedArray: categorys)
        })
    }
    
    
    func getStates(completionHandlerForGetStates:(fetchedStates:[String])->Void){
        var states = [String]()
        REF_STATES.observeSingleEventOfType(FIRDataEventType.Value, withBlock: {snapshot in
            for value in snapshot.children{
                let state = value as! FIRDataSnapshot
                print(state.key)
                states.append(state.key)
            }
            completionHandlerForGetStates(fetchedStates: states)
        })
//        print(REF_GEOFIRE)
    }
    
    func getRestaurants(completionHandlerForRestaurants:(fetchedRestaurants:[Info])->Void){
        var restaurants = [Info]()
        REF_RESTAURANTS.child("New York").queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let restaurant = Info(snapshot: snapshot)
            restaurants.append(restaurant)
            completionHandlerForRestaurants(fetchedRestaurants: restaurants)
        })
    }
    
    func getRestaurantsByRegion(state:String, region:String, completionHandlerForRestaurants:(fetchedRestaurants:[Info])->Void){
        var restaurants = [Info]()
        REF_RESTAURANTS.child(state).child(region).queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let restaurant = Info(snapshot: snapshot)
            restaurants.append(restaurant)
            completionHandlerForRestaurants(fetchedRestaurants: restaurants)
        })
    }
    
    func getEveryThing(state:String,completionHandlerForRestaurants:(fetchedRestaurants:[Info])->Void){
        REF_RESTAURANTS.child(state).observeSingleEventOfType(FIRDataEventType.Value, withBlock: {snapshot in
            var restaurants = [Info]()
            for value in snapshot.children{
                let region = value as! FIRDataSnapshot
                self.REF_RESTAURANTS.child(state).child(region.key).queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
                    let restaurant = Info(snapshot: snapshot)
                    restaurants.append(restaurant)
                    completionHandlerForRestaurants(fetchedRestaurants: restaurants)
                })
            }
        })
    }
    func getRegion(state:String,completionHandlerForGetRegion:(fetchedRegion:[String])->Void){
        var regions = [String]()
        REF_STATES.child(state).observeSingleEventOfType(FIRDataEventType.Value, withBlock: {snapshot in
            for value in snapshot.children{
                let region = value as! FIRDataSnapshot
//                print(region.key)
                regions.append(region.key)
            }
            completionHandlerForGetRegion(fetchedRegion: regions)
        })
    }
    
    func getEventsByState(state:String, completionHandlerForEvents:(fetchedEvents:[Event])->Void){
        var events = [Event]()
        REF_EVENTS.child(state).child("All").queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let event = Event(snapshot: snapshot)
            events.append(event)
            completionHandlerForEvents(fetchedEvents: events)
        })
    }
    
    func getVideosByCategory(category:String, type:String, completionHandlerForVideos:(fetchedVideos:[Video])->Void){
        var videos = [Video]()
        REF_VIDEOS.child(category).child(type).queryOrderedByChild("name").observeEventType(FIRDataEventType.ChildAdded, withBlock: {snapshot in
            let video = Video(snapshot: snapshot)
            videos.append(video)
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
