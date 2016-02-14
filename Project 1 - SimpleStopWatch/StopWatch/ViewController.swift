//
//  ViewController.swift
//  StopWatch
//
//  Created by Allen on 16/1/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var Counter:Double = 0
    var Timer: NSTimer = NSTimer()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        timeLabel.text = String(Counter)
        super.viewDidLoad()
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func resetButtonDidTouch(sender: AnyObject) {
        Timer.invalidate()
        Counter = 0
        timeLabel.text = String(Counter)
    }
    
    @IBAction func playButtonDidTouch(sender: AnyObject) {
        Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("UpdateTimer"), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseButtonDidTouch(sender: AnyObject) {
        Timer.invalidate()
    }
    
    func UpdateTimer() {
        Counter = Counter + 0.1
        timeLabel.text = String(Counter)
    }


}

