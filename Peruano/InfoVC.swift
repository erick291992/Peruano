//
//  InfoVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/3/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import AddressBook
import MapKit

class InfoVC: UIViewController,CategoryViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stateButton: CustomButton!
    @IBOutlet weak var regionButton: CustomButton!
    
//    var infoToDisplay = [String]()
    var infos = [Info]()
    var REF_RESTAURANT:FIRDatabaseReference?
    var REF_EVERYTHING:FIRDatabaseReference?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadRestaurants()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("removing")
        if let refRestaurant = REF_RESTAURANT{
            refRestaurant.removeAllObservers()
        }
        if let refEverything = REF_EVERYTHING{
            refEverything.removeAllObservers()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func statePressed(sender: AnyObject) {
        regionButton.setTitle("Region", forState: .Normal)
        pickState()
    }
    
    @IBAction func regionPressed(sender: AnyObject) {
        pickRegion()
    }
    
    func pickState(){
        launchCategoryVC(1, title: Constants.CategoryTitles.STATES, searchInDatabase: Constants.RestaurantDefaults.DatabasePath, delegate: self)
    }
    
    func pickRegion(){
        launchCategoryVC(2, title: Constants.CategoryTitles.REGION, searchInDatabase: "\(Constants.RestaurantDefaults.DatabasePath)/\(stateButton.currentTitle!)", delegate: self)
    }
    
    func loadRestaurants(){
        if regionButton.currentTitle! == "All"{
            DataService.sharedInstance().getEveryThing(stateButton.currentTitle!) { (fetchedRestaurants, reference) in
                self.infos = fetchedRestaurants
                self.tableView.reloadData()
                self.REF_EVERYTHING = reference
            }
        }
        else{
            DataService.sharedInstance().getRestaurantsByRegion(stateButton.currentTitle!, region: regionButton.currentTitle!) { (fetchedRestaurants, reference) in
                self.infos = fetchedRestaurants
                self.tableView.reloadData()
                self.REF_RESTAURANT = reference
            }
        }
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
        if category == 2{
            regionButton.setTitle(choice, forState: .Normal)
        }
    }
    
    func configureCell(cell:InfoTableViewCell, data:Info){
        cell.titleLabel.text = data.name
        cell.addressLabel.text = data.address
        cell.hoursLabel.text = data.hours
        cell.phoneLabel.text = data.phone
        cell.urlLink = data.link
    }

}

extension InfoVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let info = infos[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as? InfoTableViewCell{
            configureCell(cell, data: info)
            return cell
        }
        return InfoTableViewCell()
    }
}