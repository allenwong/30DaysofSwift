//
//  BaseTableViewController.swift
//  SlideMenu
//
//  Created by qianyb on 2018/12/25.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
}
