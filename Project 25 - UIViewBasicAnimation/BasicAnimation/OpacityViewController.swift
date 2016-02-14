//
//  OpacityViewController.swift
//  BasicAnimation
//
//  Created by Allen on 16/2/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class OpacityViewController: UIViewController {

    @IBOutlet weak var exampleImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(2, animations: {
        
            self.exampleImageView.alpha = 0
            
        })
    }
    

}
