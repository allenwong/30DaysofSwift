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
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
            self.rotationImageView.transform = self.rotationImageView.transform.rotated(by: CGFloat(Double.pi))
            self.trump2.transform = self.trump2.transform.rotated(by: CGFloat(Double.pi))
            self.trump3.transform = self.trump3.transform.rotated(by: CGFloat(Double.pi))
            self.trump4.transform = self.trump4.transform.rotated(by: CGFloat(Double.pi))
            self.trump5.transform = self.trump5.transform.rotated(by: CGFloat(Double.pi))
            self.trump6.transform = self.trump6.transform.rotated(by: CGFloat(Double.pi))
            self.trump7.transform = self.trump7.transform.rotated(by: CGFloat(Double.pi))
            self.trump8.transform = self.trump8.transform.rotated(by: CGFloat(Double.pi))
            self.emojiLabel.transform = self.emojiLabel.transform.rotated(by: CGFloat(Double.pi))
            }) { (finished) -> Void in
                self.spin()
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.spin()
        
    }
    

}
