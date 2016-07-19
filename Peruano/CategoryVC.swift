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
    func categoryPicker(categoryPicker: CategoryVC, didPickCategory category: Int?, withChoice choice:String?)
}

class CategoryVC: UIViewController {
    var choices = [String]()
    var delegate: CategoryViewControllerDelegate?
    var categotyOne = false
    var category:Int!
    var searchInDatabase:String!
    var categoryTitle:String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = categoryTitle
        DataService.sharedInstance().getCategoryOne(searchInDatabase, completionHandlerForCategory: { (fetchedArray) in
            self.choices = fetchedArray
            self.tableView.reloadData()
        })
    }
    
    @IBAction func DonePressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let choice = choices[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell"){
            cell.textLabel!.text = choice
            return cell
        }
        else{
            
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let choice = choices[indexPath.row]
        delegate?.categoryPicker(self, didPickCategory: category, withChoice: choice)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
extension UIViewController{
    func launchCategoryVC(category:Int, title:String, searchInDatabase:String, delegate:CategoryViewControllerDelegate){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
        controller.category = category
        controller.categoryTitle = title
        controller.delegate = delegate
        controller.searchInDatabase = searchInDatabase
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
