//
//  ViewController.swift
//  StopWatch
//
//  Created by Allen on 16/1/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    // 浮点数默认是Double类型，若要使用Float，需要显示声明
    // var counter: Float = 0.0
    var counter: Float = 0.0 {
        // 属性观察器
        didSet {
            timeLabel.text = String(format: "%.1f", counter)
        }
    }
    // 给予timer一个默认值，这样timer就不会为Optional,
    // 后续可以不用再解包
    // var timer = Timer()
    
    // 这样定义可以在不用timer时回收内存
    var timer: Timer? = Timer()
    var isPlaying = false
    
    // 知识点：存储属性和计算属性
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // 只读计算属性，可以去掉get和花括号
//        get {
//            return UIStatusBarStyle.lightContent
//        }
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 符合LosslessStringConvertible协议的，
        // 都可以直接初始化一个String对象
        // timeLabel.text = String(counter)
        
        // 改成使用属性观察器监控和响应属性值的变化
        counter = 0.0
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIButton) {
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
        counter = 0
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true
    }
    
    @IBAction func playButtonDidTouch(_ sender: UIButton) {
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        // 调用实例的方法时建议用self.UpdateTimer,
        // 不建议使用ViewController.UpdateTimer
        // 因为若方法定义成了类方法，第二种方式编译器不会报错。
        timer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pauseButtonDidTouch(_ sender: UIButton) {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
        
    }
    
   @objc func UpdateTimer() {
        counter = counter + 0.1
    }
    
    
}

