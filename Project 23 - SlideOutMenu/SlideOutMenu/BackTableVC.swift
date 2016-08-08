//
//  BackTableVC.swift
//  SlideOutMenu
//
//  Created by Allen on 16/1/31.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    
    var TableArrary = [String]()
    
    override func viewDidLoad() {
        
        TableArrary = ["FriendRead", "Article", "ReadLater"]
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red:0.159, green:0.156, blue:0.181, alpha:1)
        self.view.backgroundColor = UIColor.black
        UIApplication.shared.isStatusBarHidden = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArrary.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArrary[(indexPath as NSIndexPath).row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArrary[(indexPath as NSIndexPath).row]
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white

        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        selectedCell.contentView.backgroundColor = UIColor(red:0.245, green:0.247, blue:0.272, alpha:0.817)
    
    }
    
    
    
}
