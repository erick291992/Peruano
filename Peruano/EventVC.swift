//
//  EventVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class EventVC: UIViewController {

    var events = [Event]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventVC loaded")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        DataService.sharedInstance().getEventsByState("New York") { (fetchedEvents) in
            print(fetchedEvents.count)
            self.events = fetchedEvents
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func configureCell(cell:EventTableViewCell, data:Event){
        cell.titleLabel.text = data.name
        cell.addressLabel.text = data.address
        cell.dateLabel.text = data.date
        cell.phoneLabel.text = data.phone
    }

}

extension EventVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        print(event.name)
        //        print(post.postDescription)
        if let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as? EventTableViewCell{
            configureCell(cell, data: event)
            return cell
        }
        
        return EventTableViewCell()
    }
    
}

