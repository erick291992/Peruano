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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stateButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        launchCategoryVC(1, title: Constants.CategoryTitles.STATES, searchInDatabase: Constants.EventDefaults.DatabasePath)
    }
    
    func launchCategoryVC(category:Int, title:String, searchInDatabase:String){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
        controller.category = category
        controller.categoryTitle = title
        controller.delegate = self
        controller.searchInDatabase = searchInDatabase
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func categoryPicker(categoryPicker: CategoryVC, didPickCategory category: Int?, withChoice choice:String?){
        guard let choice = choice else{
            return
        }
        guard let category = category else{
            return
        }
        if category == 1{
            stateButton.setTitle(choice, forState: .Normal)
        }
    }
    
    func loadEvents(){
        DataService.sharedInstance().getEventsByState(stateButton.currentTitle!) { (fetchedEvents) in
//            print(fetchedEvents.count)
            self.events = fetchedEvents
            self.tableView.reloadData()
        }
    }
    
    func configureCell(cell:EventTableViewCell, data:Event){
        cell.titleLabel.text = data.name
        cell.addressLabel.text = data.address
        cell.dateLabel.text = data.date
        cell.phoneLabel.text = data.phone
        cell.urlLink = data.link
    }
}

extension EventVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as? EventTableViewCell{
            configureCell(cell, data: event)
            return cell
        }
        return EventTableViewCell()
    }
    
}

