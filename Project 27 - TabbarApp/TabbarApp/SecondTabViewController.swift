//
//  SecondTabViewController.swift
//  TabbarApp
//
//  Created by Allen on 16/2/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class SecondTabViewController: UIViewController {

    @IBOutlet weak var exploreImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exploreImageView.alpha = 0
        self.exploreImageView.transform = CGAffineTransformMakeScale(0.5, 0.5)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseIn, animations: { () -> Void in
            
            self.exploreImageView.transform = CGAffineTransformMakeScale(1, 1)
            self.exploreImageView.alpha = 1
            
            }, completion: nil )
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
