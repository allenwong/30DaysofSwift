//
//  ViewController.swift
//  Snapchat Menu
//
//  Created by Allen on 16/1/10.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 已经废弃了，使用prefersStatusBarHidden属性返回设置的值
        // UIApplication.shared.isStatusBarHidden = true
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let leftView: UIViewController = UINib(nibName: "LeftView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIViewController
        let centerView: CameraView = CameraView(nibName: "CameraView", bundle: nil)
        let rightView: RightView = RightView(nibName: "RightView", bundle: nil)
        
        leftView.view.frame = CGRect(x: 0, y: 0, width: screenWidth-200, height: screenHeight)
        centerView.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        rightView.view.frame = CGRect(x: 2*screenWidth, y: 0, width: screenWidth, height: screenHeight)
 
        self.scrollView.addSubview(leftView.view)
        self.scrollView.addSubview(rightView.view)
        self.scrollView.addSubview(centerView.view)
        self.scrollView.contentSize = CGSize(width: screenWidth * 3, height: screenHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // View controller-based status bar appearance 需要设置为YES
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

