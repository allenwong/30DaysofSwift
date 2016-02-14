//
//  ColorViewController.swift
//  BasicAnimation
//
//  Created by Allen on 16/2/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var bgColorView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: .CurveEaseIn, animations: { () -> Void in
            
            self.bgColorView.backgroundColor = UIColor.blackColor()
            
            }, completion: nil )
        
        UIView.animateWithDuration(0.5, delay: 0.8, options: .CurveEaseOut, animations: { () -> Void in
            
            self.numberLabel.textColor = UIColor(red:0.959, green:0.937, blue:0.109, alpha:1)
            
            }, completion: nil)
        
        
    }


}
