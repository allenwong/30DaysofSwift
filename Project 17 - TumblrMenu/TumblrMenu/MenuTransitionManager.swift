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
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
        let container = transitionContext.containerView()
        
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if (self.presenting) {
        
            self.offStageMenuController(menuViewController)
            
        }
        
        container!.addSubview(bottomView)
        container!.addSubview(menuView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                
                self.onStageMenuController(menuViewController)
                
            } else {
                
                self.offStageMenuController(menuViewController)
                
            }
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })

        
        
    }
    
    
    func offstage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuController(menuViewController: MenuViewController) {
        
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
    
    func onStageMenuController(menuViewController: MenuViewController) {
     
        
        menuViewController.view.alpha = 1
        
        menuViewController.textButton.transform = CGAffineTransformIdentity
        menuViewController.textLabel.transform = CGAffineTransformIdentity
        menuViewController.quoteButton.transform = CGAffineTransformIdentity
        menuViewController.quoteLabel.transform = CGAffineTransformIdentity
        menuViewController.chatButton.transform = CGAffineTransformIdentity
        menuViewController.chatLabel.transform = CGAffineTransformIdentity
        menuViewController.photoButton.transform = CGAffineTransformIdentity
        menuViewController.photoLabel.transform = CGAffineTransformIdentity
        menuViewController.linkButton.transform = CGAffineTransformIdentity
        menuViewController.linkLabel.transform = CGAffineTransformIdentity
        menuViewController.audioButton.transform = CGAffineTransformIdentity
        menuViewController.audioLabel.transform = CGAffineTransformIdentity
        
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = false
        return self
    }
    
}
