//
//  MenuTransitionManager.swift
//  TumblrMenu
//
//  Created by Allen on 16/1/24.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    private var presenting = false
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        let container = transitionContext.containerView
        
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey)!, transitionContext.viewController(forKey: UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if (self.presenting) {
        
            self.offStageMenuController(menuViewController)
            
        }
        
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                
                self.onStageMenuController(menuViewController)
                
            } else {
                
                self.offStageMenuController(menuViewController)
                
            }
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                UIApplication.shared.keyWindow!.addSubview(screens.to.view)
                
        })

        
        
    }
    
    
    func offstage(_ amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(_ menuViewController: MenuViewController) {
        
        menuViewController.view.alpha = 0
        
        let topRowOffset  : CGFloat = 300
        let middleRowOffset : CGFloat = 150
        let bottomRowOffset  : CGFloat = 50
        
        menuViewController.textButton.transform = self.offstage(-topRowOffset)
        menuViewController.textLabel.transform = self.offstage(-topRowOffset)
        
        menuViewController.quoteButton.transform = self.offstage(-middleRowOffset)
        menuViewController.quoteLabel.transform = self.offstage(-middleRowOffset)
        
        menuViewController.chatButton.transform = self.offstage(-bottomRowOffset)
        menuViewController.chatLabel.transform = self.offstage(-bottomRowOffset)
        
        menuViewController.photoButton.transform = self.offstage(topRowOffset)
        menuViewController.photoLabel.transform = self.offstage(topRowOffset)
        
        menuViewController.linkButton.transform = self.offstage(middleRowOffset)
        menuViewController.linkLabel.transform = self.offstage(middleRowOffset)
        
        menuViewController.audioButton.transform = self.offstage(bottomRowOffset)
        menuViewController.audioLabel.transform = self.offstage(bottomRowOffset)
        
    }
    
    func onStageMenuController(_ menuViewController: MenuViewController) {
     
        
        menuViewController.view.alpha = 1
        
        menuViewController.textButton.transform = CGAffineTransform.identity
        menuViewController.textLabel.transform = CGAffineTransform.identity
        menuViewController.quoteButton.transform = CGAffineTransform.identity
        menuViewController.quoteLabel.transform = CGAffineTransform.identity
        menuViewController.chatButton.transform = CGAffineTransform.identity
        menuViewController.chatLabel.transform = CGAffineTransform.identity
        menuViewController.photoButton.transform = CGAffineTransform.identity
        menuViewController.photoLabel.transform = CGAffineTransform.identity
        menuViewController.linkButton.transform = CGAffineTransform.identity
        menuViewController.linkLabel.transform = CGAffineTransform.identity
        menuViewController.audioButton.transform = CGAffineTransform.identity
        menuViewController.audioLabel.transform = CGAffineTransform.identity
        
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = false
        return self
    }
    
}
