//
//  VideoVC.swift
//  Peruano
//
//  Created by Erick Manrique on 7/9/16.
//  Copyright © 2016 appsathome. All rights reserved.
//


import UIKit

class VideoVC: UIViewController {
    var videos = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.sharedInstance().getVideosByCategory("Music", type: "Cumbia") { (fetchedVideos) in
            self.videos = fetchedVideos
            self.tableView.reloadData()
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