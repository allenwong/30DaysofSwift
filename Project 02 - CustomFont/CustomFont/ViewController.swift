//
//  ViewController.swift
//  CustomFont
//
//  Created by Allen on 16/1/7.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "FontCell"
    
    var data = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」",
                "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体",
                "呵呵，再见🤗 See you next Project", "微博 @Allen朝辉",
                "测试测试测试测试测试测试", "123", "Alex", "@@@@@@"]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular",
                     "MFJinHei_Noncommercial-Regular",
                     "MFZhiHei_Noncommercial-Regular",
                     "Zapfino",
                     "Gaspar Regular"]
    
    var fontRowIndex = 0
 
    @IBOutlet weak var changeFontLabel: UILabel!
    @IBOutlet weak var fontTableView: UITableView!
    
    func changeFontDidTouch(_ sender: AnyObject) {
        
        fontRowIndex = (fontRowIndex + 1) % 5
        print(fontNames[fontRowIndex])
        fontTableView.reloadData()
        
    }
  
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 在storyboard中直接设置了
        // fontTableView.dataSource = self
        // fontTableView.delegate = self
        
        // 使用手势加Label替换button
        changeFontLabel.layer.cornerRadius = 50
        changeFontLabel.layer.masksToBounds = true
        // 设置为true才能响应手势
        changeFontLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(changeFontDidTouch(_:)))
        changeFontLabel.addGestureRecognizer(gesture)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = fontTableView.dequeueReusableCell(withIdentifier: ViewController.identifier)
        let cell = fontTableView.dequeueReusableCell(withIdentifier: ViewController.identifier, for: indexPath)
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size:16)
        
        return cell
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

}

