//
//  ViewController.swift
//  SpotifyVideoBackground
//
//  Created by Allen on 16/1/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        
        loginButton.layer.cornerRadius = 4
        signupButton.layer.cornerRadius = 4
        
    }
    
    func setupVideoBackground() {
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        view.isUserInteractionEnabled = false
        
    }



}

