//
//  AnimationController.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 25/05/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let imagePickerSheetController: ImagePickerSheetController
    let presenting: Bool
    
    // MARK: - Initialization
    
    init(imagePickerSheetController: ImagePickerSheetController, presenting: Bool) {
        self.imagePickerSheetController = imagePickerSheetController
        self.presenting = presenting
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            animatePresentation(transitionContext)
        }
        else {
            animateDismissal(transitionContext)
        }
    }
    
    // MARK: - Animation
    
    private func animatePresentation(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView()!
        containerView.addSubview(imagePickerSheetController.view)
        
        let tableViewOriginY = imagePickerSheetController.tableView.frame.origin.y
        imagePickerSheetController.tableView.frame.origin.y = containerView.bounds.maxY
        imagePickerSheetController.backgroundView.alpha = 0
        
        UIView.animateWithDuration(transitionDuration(context), animations: {
            self.imagePickerSheetController.tableView.frame.origin.y = tableViewOriginY
            self.imagePickerSheetController.backgroundView.alpha = 1
        }, completion: { _ in
            context.completeTransition(true)
        })
    }
    
    private func animateDismissal(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView()!
        
        UIView.animateWithDuration(transitionDuration(context), animations: {
            self.imagePickerSheetController.tableView.frame.origin.y = containerView.bounds.maxY
            self.imagePickerSheetController.backgroundView.alpha = 0
        }, completion: { _ in
            self.imagePickerSheetController.view.removeFromSuperview()
            context.completeTransition(true)
        })
    }
    
}
