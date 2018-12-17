//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by Allen on 16/1/9.
//  Copyright © 2016年 Allen. All rights reserved.
//

// 引入系统库，一个库是一个module。
import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    // Swift中mark的使用方式，效果等同OC重的 #pragma mark -
    //MARK:- Variables
    @IBOutlet weak var videoTableView: UITableView!
    
    var data = [
        // 给项目编译后属于同一个module，所以Video不需要import就可以使用
        Video(image: "videoScreenshot01",
              title: "Introduce 3DS Mario",
              source: "Youtube - 06:32"),
        Video(image: "videoScreenshot02",
              title: "Emoji Among Us",
              source: "Vimeo - 3:34"),
        Video(image: "videoScreenshot03",
              title: "Seals Documentary",
              source: "Vine - 00:06"),
        Video(image: "videoScreenshot04",
              title: "Adventure Time",
              source: "Youtube - 02:39"),
        Video(image: "videoScreenshot05",
              title: "Facebook HQ",
              source: "Facebook - 10:20"),
        Video(image: "videoScreenshot06",
              title: "Lijiang Lugu Lake",
              source: "Allen - 20:30")
    ]
    
    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
  
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.dataSource = self
        videoTableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playVideoButtonDidTouch(_ sender: AnyObject) {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        
        playerView = AVPlayer(url: URL(fileURLWithPath: path!))
        
        playViewController.player = playerView
        
        // 知识点：尾随闭包
        // 在使用尾随闭包时，你不用写出它的参数标签
        // 如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉
        // 完整形式如下：
        //self.present(playViewController, animated: true, completion: {
        //    self.playViewController.player?.play()
        //})
        self.present(playViewController, animated: true) {
            self.playViewController.player?.play()
        }
        
    }
 }

//MARK:- UIViewTableView DataSource & Delegate
// 知识点：扩展
// 扩展和 Objective-C 中的分类类似，但没有名称
// 扩展可以为一个类型添加新的功能，但是不能重写已有的功能。
// 扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // Extensions must not contain stored properties
    //var a = 1
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 220
    }

    func numberOfSections(in tableView: UITableView) -> Int {
    return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    // 知识点：向下转型
    // as! 强制类型转换，无法转换时会抛出运行时异常
    // as？可选类型转换，无法转换时返回nil
    let cell = videoTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
    let video = data[indexPath.row]

    cell.videoScreenshot.image = UIImage(named: video.image)
    cell.videoTitleLabel.text = video.title
    cell.videoSourceLabel.text = video.source

    return cell

    }
}

