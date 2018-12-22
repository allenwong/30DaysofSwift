//
//  ViewController.swift
//  Where
//
//  Created by Allen on 16/1/12.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    // 强制自动解包，可以赋值为nil，为nil后再调用会报错
    // 建议定义为：
    // var locationManager: CLLocationManager
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func myLocationButtonDidTouch(_ sender: AnyObject) {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

