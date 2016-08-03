//
//  ReadLater.swift
//  SlideOutMenu
//
//  Created by Allen on 16/1/31.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation

class ReadLater : UIViewController {
    
    override func viewDidLoad() {
        UIApplication.shared.isStatusBarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
}
