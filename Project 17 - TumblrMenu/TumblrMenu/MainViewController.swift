//
//  ViewController.swift
//  TumblrMenu
//
//  Created by Allen on 16/1/23.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToMainViewController (_ sender: UIStoryboardSegue){
        self.dismiss(animated: true, completion: nil)
    }
}

