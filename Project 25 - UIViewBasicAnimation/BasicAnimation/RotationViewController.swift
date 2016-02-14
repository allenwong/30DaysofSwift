//
//  RotationViewController.swift
//  BasicAnimation
//
//  Created by Allen on 16/2/2.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var rotationImageView: UIImageView!
    @IBOutlet weak var trump2: UIImageView!
    @IBOutlet weak var trump3: UIImageView!
    @IBOutlet weak var trump4: UIImageView!
    @IBOutlet weak var trump5: UIImageView!
    @IBOutlet weak var trump6: UIImageView!
    @IBOutlet weak var trump7: UIImageView!
    @IBOutlet weak var trump8: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func spin() {
        
        UIView.animateWithDuration(0.8, delay: 0, options: .CurveLinear, animations: {
        
            self.rotationImageView.transform = CGAffineTransformRotate(self.rotationImageView.transform, CGFloat(M_PI))
            self.trump2.transform = CGAffineTransformRotate(self.trump2.transform, CGFloat(M_PI))
            self.trump3.transform = CGAffineTransformRotate(self.trump3.transform, CGFloat(M_PI))
            self.trump4.transform = CGAffineTransformRotate(self.trump4.transform, CGFloat(M_PI))
            self.trump5.transform = CGAffineTransformRotate(self.trump5.transform, CGFloat(M_PI))
            self.trump6.transform = CGAffineTransformRotate(self.trump6.transform, CGFloat(M_PI))
            self.trump7.transform = CGAffineTransformRotate(self.trump7.transform, CGFloat(M_PI))
            self.trump8.transform = CGAffineTransformRotate(self.trump8.transform, CGFloat(M_PI))
            self.emojiLabel.transform = CGAffineTransformRotate(self.emojiLabel.transform, CGFloat(M_PI))
        
            }) { (finished) -> Void in
                self.spin()
        }
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.spin()
        
    }
    

}
