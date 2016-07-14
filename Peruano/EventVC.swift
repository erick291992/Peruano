//
//  EventVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit

class EventVC: UIViewController, CategoryViewControllerDelegate {

    var events = [Event]()
    var state = "New York"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stateButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventVC loaded")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadEvents()
    }
    
    @IBAction func statePressed(sender: AnyObject) {
        pickState()
    }
    
    func pickState(){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
        controller.delegate = self
        controller.category = 1
        controller.searchInDatabase = "Events"
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func categoryPicker(categoryPicker: CategoryVC, didPickCategory category: Int?, withChoice choice:String?){
        guard let choice = choice else{
            return
        }
        print("this is a choice \(choice)")
        guard let category = category else{
            return
        }
        if category == 1{
            state = choice
            stateButton.setTitle(self.state, forState: .Normal)
        }
    }
    
    func loadEvents(){
        DataService.sharedInstance().getEventsByState(state) { (fetchedEvents) in
            print(fetchedEvents.count)
            self.events = fetchedEvents
            self.tableView.reloadData()
        }
    }
    
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

