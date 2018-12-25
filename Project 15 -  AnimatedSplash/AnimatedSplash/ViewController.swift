//
//  ViewController.swift
//  AnimatedSplash
//
//  Created by Allen on 16/1/20.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    var mask: CALayer?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "twitter")?.cgImage
        self.mask!.contentsGravity = kCAGravityResizeAspect
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 81)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.imageView.setNeedsLayout()
        self.imageView.layoutIfNeeded()
        self.mask!.position = CGPoint(x: self.imageView.frame.size.width / 2, y: self.imageView.frame.size.height / 2)
        self.imageView.layer.mask = mask
        
        animateMask()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        do {
            // 动画需要加上这段代码，否则会造成页面闪一下
            keyFrameAnimation.fillMode = kCAFillModeForwards
            keyFrameAnimation.isRemovedOnCompletion = false
        }
        let initalBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90*0.9, height: 73*0.9))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1600, height: 1300))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.add(keyFrameAnimation, forKey: "bounds")
    }
}

extension ViewController : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.imageView.layer.mask = nil
    }
}
