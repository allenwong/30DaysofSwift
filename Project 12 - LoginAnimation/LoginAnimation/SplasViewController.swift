//
//  SplasViewController.swift
//  LoginAnimation
//
//  Created by Allen on 16/1/18.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class SplasViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
