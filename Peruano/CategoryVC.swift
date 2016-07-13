//
//  CategoryVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/1/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit
import Firebase

protocol CategoryViewControllerDelegate {
    func categoryPicker(categoryPicker: CategoryVC, didPickCategory category: String?)
}

class CategoryVC: UIViewController {
    var states = [String]()
    var delegate: CategoryViewControllerDelegate?
    var categotyOne:Bool?
    var categoryTwo:Bool?
    var selectedState: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CategoryVC view did load")
        if let selectedState = selectedState{
            DataService.sharedInstance().getRegion(selectedState, completionHandlerForGetRegion: { (fetchedRegion) in
                self.states = fetchedRegion
                self.tableView.reloadData()
            })
            print("this is the selected state")
        }
        else{
            DataService.sharedInstance().getStates { (fetchedStates) in
                print(fetchedStates)
                self.states = fetchedStates
                self.tableView.reloadData()
            }
        }
        
    }

}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let state = states[indexPath.row]
        //        print(post.postDescription)
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell"){
            cell.textLabel!.text = state
            return cell
        }
        else{
            
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let state = states[indexPath.row]
        delegate?.categoryPicker(self, didPickCategory: state)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
