//
//  VideoVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//


import UIKit

class VideoVC: UIViewController, CategoryViewControllerDelegate {
    var videos = [Video]()
    var videoCategory = "Music"
    var videoType = "Cumbia"
    
    @IBOutlet weak var videoButton: CustomButton!
    @IBOutlet weak var typeButton: CustomButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadVideos()
    }
    
    @IBAction func videoPressed(sender: AnyObject) {
        pickVideo()
    }
    
    @IBAction func typePressed(sender: AnyObject) {
        pickType()
    }

    
    func loadVideos(){
        DataService.sharedInstance().getVideosByCategory(videoCategory, type: videoType) { (fetchedVideos) in
            self.videos = fetchedVideos
            self.tableView.reloadData()
        }
    }
    func pickVideo(){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
        controller.delegate = self
        controller.category = 1
        controller.searchInDatabase = "Video"
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func pickType(){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CategoryVC") as! CategoryVC
        controller.category = 2
        controller.delegate = self
        controller.searchInDatabase = "Video/\(self.videoCategory)"
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
            videoCategory = choice
            if choice == "Movie" || choice == "Comedy"{
                videoType = "All"
                typeButton.enabled = false
                typeButton.setTitle("All", forState: .Normal)
            }
            else{
                typeButton.enabled = true
            }
            videoButton.setTitle(choice, forState: .Normal)
        }
        if category == 2{
            videoType = choice
            typeButton.setTitle(choice, forState: .Normal)
        }
    }

    func configureCell(cell:VideoTableViewCell, data:Video){
        cell.titleLabel.text = data.name
        cell.descriptionLabel.text = data.description
    }
}

extension VideoVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell") as? VideoTableViewCell{
            configureCell(cell, data: video)
            return cell
        }
        
        return EventTableViewCell()
    }
    
}