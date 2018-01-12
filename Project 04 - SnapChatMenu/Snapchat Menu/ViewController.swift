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
        
        UIApplication.shared.isStatusBarHidden = true

        let leftView: LeftView = LeftView(nibName: "LeftView", bundle: nil)
        let centerView: CameraView = CameraView(nibName: "CameraView", bundle: nil)
        let rightView: RightView = RightView(nibName: "RightView", bundle: nil)

        
        self.addChildViewController(leftView)
        self.scrollView.addSubview(leftView.view)
        leftView.didMove(toParentViewController: self)
        
        self.addChildViewController(rightView)
        self.scrollView.addSubview(rightView.view)
        rightView.didMove(toParentViewController: self)
        
        self.addChildViewController(centerView)
        self.scrollView.addSubview(centerView.view)
        centerView.didMove(toParentViewController: self)
        
        var centerViewFrame: CGRect = centerView.view.frame
        centerViewFrame.origin.x = self.view.frame.width
        centerView.view.frame = centerViewFrame
        
        var rightViewFrame: CGRect = rightView.view.frame
        rightViewFrame.origin.x = 2 * self.view.frame.width
        rightView.view.frame = rightViewFrame
 
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

