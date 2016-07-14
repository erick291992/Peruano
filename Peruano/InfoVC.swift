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
    var state = "New York"
    var region = "Long Island"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            let isAnonymous = user!.anonymous  // true
            print("this is a isAnonymous \(isAnonymous)")
            let uid = user!.uid
            print(uid)
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadRestaurants()
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
        launchCategoryVC(1, title: "States", searchInDatabase: "States")
    }
    
    func pickRegion(){
        launchCategoryVC(2, title: region, searchInDatabase: "States/\(self.state)")
    }
    
    func launchCategoryVC(category:Int, title:String, searchInDatabase:String){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
        controller.category = category
        controller.categoryTitle = title
        controller.delegate = self
        controller.searchInDatabase = searchInDatabase
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func loadRestaurants(){
        DataService.sharedInstance().getRestaurantsByRegion(state, region: region) { (fetchedRestaurants) in
            self.infos = fetchedRestaurants
            self.tableView.reloadData()
        }
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
        if category == 2{
            region = choice
            regionButton.setTitle(choice, forState: .Normal)
        }
    }
    
    func configureCell(cell:InfoTableViewCell, data:Info){
        cell.titleLabel.text = data.name
        cell.addressLabel.text = data.address
        cell.hoursLabel.text = data.hours
        cell.phoneLabel.text = data.phone
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let info = infos[indexPath.row]
        UrlAppLauncher.sharedInstance().launchMapUsingAddress(info.address)
    }
}