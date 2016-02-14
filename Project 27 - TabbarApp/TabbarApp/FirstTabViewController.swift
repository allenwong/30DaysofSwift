//
//  FirstTabViewController.swift
//  TabbarApp
//
//  Created by Allen on 16/2/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var articleTableView: UITableView!
    
    var data = [
    
        article(avatarImage: "allen", sharedName: "Allen Wang", actionType: "Read Later", articleTitle: "Giphy Cam Lets You Create And Share Homemade Gifs", articleCoverImage: "giphy", articleSouce: "TheNextWeb", articleTime: "5min  •  13:20"),
        article(avatarImage: "Daniel Hooper", sharedName: "Daniel Hooper", actionType: "Shared on Twitter", articleTitle: "Principle. The Sketch of Prototyping Tools", articleCoverImage: "my workflow flow", articleSouce: "SketchTalk", articleTime: "3min  •  12:57"),
        article(avatarImage: "davidbeckham", sharedName: "David Beckham", actionType: "Shared on Facebook", articleTitle: "Ohlala, An Uber For Escorts, Launches Its ‘Paid Dating’ Service In NYC", articleCoverImage: "Ohlala", articleSouce: "TechCrunch", articleTime: "1min  •  12:59"),
        article(avatarImage: "bruce", sharedName: "Bruce Fan", actionType: "Shared on Weibo", articleTitle: "Lonely Planet’s new mobile app helps you explore major cities like a pro", articleCoverImage: "Lonely Planet", articleSouce: "36Kr", articleTime: "5min  •  11:21"),

    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.dataSource = self
        articleTableView.delegate = self
        articleTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        articleTableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        animateTable()
        
    }
    
    func animateTable() {
        
        self.articleTableView.reloadData()
        
        let cells = articleTableView.visibleCells
        let tableHeight: CGFloat = articleTableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 165
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = articleTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        let article = data[indexPath.row]
        
        cell.avatarImage.image = UIImage(named: article.avatarImage)
        cell.articleCoverImage.image = UIImage(named: article.articleCoverImage)
        cell.sharedNameLabel.text = article.sharedName
        cell.actionTypeLabel.text = article.actionType
        cell.articleTitleLabel.text = article.articleTitle
        cell.articleSouceLabel.text = article.articleSouce
        cell.articelCreatedAtLabel.text = article.articleTime
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }

}
