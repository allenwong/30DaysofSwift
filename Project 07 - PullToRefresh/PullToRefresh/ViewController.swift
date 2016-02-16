//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Allen on 16/1/13.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifer = "NewCellIdentifier"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    var tableViewController = UITableViewController(style: .Plain)
    
    var refreshControl = UIRefreshControl()
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiData = favoriteEmoji
        let emojiTableView = tableViewController.tableView
        
        emojiTableView.backgroundColor = UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        emojiTableView.dataSource = self
        emojiTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: "didRoadEmoji", forControlEvents: .ValueChanged)
        
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(NSDate())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.whiteColor()
        
        self.title = "emoji"
        self.navBar.barStyle = UIBarStyle.BlackTranslucent
        
        emojiTableView.rowHeight = UITableViewAutomaticDimension
        emojiTableView.estimatedRowHeight = 60.0
        emojiTableView.tableFooterView = UIView(frame: CGRectZero)
        emojiTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        self.view.addSubview(emojiTableView)
        self.view.addSubview(navBar)
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer)! as UITableViewCell
        
        cell.textLabel!.text = self.emojiData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.Center
        cell.textLabel!.font = UIFont.systemFontOfSize(50)
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        return cell
    }
    
    
    //RoadEmoji
    
    func didRoadEmoji() {
        self.emojiData = newFavoriteEmoji
        self.tableViewController.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


}

