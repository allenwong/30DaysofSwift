//
//  AnimationCollectionViewCell.swift
//  CollectionViewAnimation
//
//  Created by Patrick Reynolds on 2/15/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var animationTextView: UITextView!
    
    var backButtonTapped: (() -> Void)?
    
    func prepareCell(viewModel: AnimationCellModel) {
        animationImageView.image = UIImage(named: viewModel.imagePath)
        animationTextView.scrollEnabled = false
        backButton.hidden = true
        addTapEventHandler()
    }
    
    func handleCellSelected() {
        animationTextView.scrollEnabled = false
        backButton.hidden = false
        self.superview?.bringSubviewToFront(self)
    }
    
    private func addTapEventHandler() {
        backButton.addTarget(self, action: Selector("backButtonDidTouch:"), forControlEvents: .TouchUpInside)
    }
    
    func backButtonDidTouch(sender: UIGestureRecognizer) {
        backButtonTapped?()
    }
}
