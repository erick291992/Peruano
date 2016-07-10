//
//  InfoVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/3/16.
//  Copyright © 2016 appsathome. All rights reserved.
//

import UIKit
import Firebase
class InfoVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var infoToDisplay = [String]()
    var infos = [Info]()
    var state = "New York"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            let isAnonymous = user!.anonymous  // true
            print("this is a ano \(isAnonymous)")
            let uid = user!.uid
            print(uid)
        }
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
//        tableView.reloadData()
//        DataService.sharedInstance().getRestaurants { (fetchedRestaurants) in
//            self.infos = fetchedRestaurants
//            self.tableView.reloadData()
//        }
        DataService.sharedInstance().getRestaurantsByRegion("New York", region: "Long Island") { (fetchedRestaurants) in
            self.infos = fetchedRestaurants
            self.tableView.reloadData()
        }
//        tableView.tableFooterView = UIView(frame: CGRectZero)
//        setupBackground()
        
    }
    
//    let tableViewBackgroundView: TableViewBackgroundView = {
//        let tb = TableViewBackgroundView()
//        return tb
//    }()
    
    private func setupBackground(){
//        tableView.addSubview(tableViewBackgroundView)
        let width = view.frame.size.width
        let height = (view.frame.size.width) * 3/2
        print(width)
        print(height)
        let dim = "V:[v0(\(height))]"
        let dim2 = "H:[v0(\(width))]"
//        tableViewBackgroundView.addConstraintsWithFormat(dim2, views: tableViewBackgroundView)
//        tableViewBackgroundView.addConstraintsWithFormat(dim, views: tableViewBackgroundView)
//        let back = TableViewBackgroundView(frame: CGRectMake(0, 0, width, height))
//        let imageView = UIImageView(frame: CGRectMake(10, 0, width - 20, height - 10))
//        let image = UIImage(named: "Christmas.jpg")
//        imageView.contentMode = .ScaleAspectFill
//        imageView.image = image
//        tableView.backgroundView = UIImageView(image: UIImage(named: "naruto.jpg"))
//        tableView.backgroundView = tableViewBackgroundView
        
//        tableView.backgroundView = back
//        tableView.backgroundView = UIView()
//        tableView.backgroundView?.addSubview(imageView)
//        tableView.backgroundView = UIView()
//        tableView.backgroundView?.addSubview(back)
//        tableView.backgroundColor = UIColor.blueColor()
//        tableView.reloadData()
//        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func statePressed(sender: AnyObject) {
//        pickState()
    }
    
    @IBAction func regionPressed(sender: AnyObject) {
//        pickRegion()
    }
    
//    func pickState(){
//        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
//        
//        controller.delegate = self
//        
//        self.presentViewController(controller, animated: true, completion: nil)
//    }
    
//    func pickRegion(){
//        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
//        
//        controller.delegate = self
//        controller.selectedState = self.state
//        
//        self.presentViewController(controller, animated: true, completion: nil)
//    }
    
//    func categoryPicker(categoryPicker: CategoryVC, didPickCategory category: String?) {
//        if let newCategory = category{
//            print("this is a category \(newCategory)")
//            self.state = newCategory
//            print(state)
//        }
//        else{
//            print("this is not a category")
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
        //        print(post.postDescription)
        if let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as? InfoTableViewCell{
            configureCell(cell, data: info)
            return cell
        }
        
        return InfoTableViewCell()
    }
    
}