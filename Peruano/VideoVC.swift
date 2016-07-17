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
        launchCategoryVC(1, title: Constants.CategoryTitles.VIDEO, searchInDatabase: Constants.VideoDefaults.DatabasePath, delegate: self)
    }
    
    @IBAction func typePressed(sender: AnyObject) {
        launchCategoryVC(2, title: Constants.CategoryTitles.TYPE, searchInDatabase: "\(Constants.VideoDefaults.DatabasePath)/\(videoButton.currentTitle!)", delegate: self)
    }

    
    func loadVideos(){
        DataService.sharedInstance().getVideosByCategory(videoButton.currentTitle!, type: typeButton.currentTitle!) { (fetchedVideos) in
            self.videos = fetchedVideos
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
            if choice == "Movie" || choice == "Comedy"{
                typeButton.enabled = false
                typeButton.setTitle("All", forState: .Normal)
            }
            else{
                typeButton.enabled = true
            }
            videoButton.setTitle(choice, forState: .Normal)
        }
        if category == 2{
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let video = videos[indexPath.row]
        UrlAppLauncher.sharedInstance().launchYoutubeUsingLink(video.urlLink)
    }
}