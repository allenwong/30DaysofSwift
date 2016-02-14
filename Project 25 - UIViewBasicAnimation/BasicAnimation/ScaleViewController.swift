//
//  ScaleViewController.swift
//  BasicAnimation
//
//  Created by Allen on 16/2/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController {

    @IBOutlet weak var scaleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scaleImageView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseIn, animations: { () -> Void in
            
            self.scaleImageView.transform = CGAffineTransformMakeScale(2, 2)
            self.scaleImageView.alpha = 1
            
            }, completion: nil )
    }


}
