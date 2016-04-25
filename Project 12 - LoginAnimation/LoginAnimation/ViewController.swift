//
//  ViewController.swift
//  LoginAnimation
//
//  Created by Allen on 16/1/18.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func backButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var uesernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uesernameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        centerAlignUsername.constant -= view.bounds.width
        centerAlignPassword.constant -= view.bounds.width
        loginButton.alpha = 0
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.00, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.centerAlignUsername.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.10, options: .CurveEaseOut, animations: {
            
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.20, options: .CurveEaseOut, animations: {
            
            self.loginButton.alpha = 1
            
            }, completion: nil)
    
    }

    @IBAction func loginButtonDidTouch(sender: UIButton) {
        
        let bounds = self.loginButton.bounds
        
        //Animate
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.loginButton.enabled = false
            
			}, completion: { finished in self.loginButton.enabled = true })
		
    }

}

