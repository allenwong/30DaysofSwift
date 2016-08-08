//
//  MenuTableViewController.swift
//  SlideMenu
//
//  Created by Allen on 16/1/22.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var menuItems = ["Everyday Moments", "Popular", "Editors", "Upcoming", "Fresh", "Stock-photos", "Trending"]
    var currentItem = "Everyday Moments"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.backgroundColor = UIColor(red:0.109, green:0.114, blue:0.128, alpha:1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell

        cell.titleLabel.text = menuItems[(indexPath as NSIndexPath).row]
        cell.titleLabel.textColor = (menuItems[(indexPath as NSIndexPath).row] == currentItem) ? UIColor.white : UIColor.gray
        cell.backgroundColor = UIColor.clear

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let menuTableViewController = segue.source as! MenuTableViewController
        
        if let selectedRow = (menuTableViewController.tableView.indexPathForSelectedRow as NSIndexPath?)?.row {
            currentItem = menuItems[selectedRow]
        }
        
    }
    
  
    
}
