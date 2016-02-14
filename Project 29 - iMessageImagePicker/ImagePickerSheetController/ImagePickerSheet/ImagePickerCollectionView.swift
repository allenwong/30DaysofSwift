//
//  ImagePickerCollectionView.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 07/09/14.
//  Copyright (c) 2014 Laurin Brandner. All rights reserved.
//

import UIKit

class ImagePickerCollectionView: UICollectionView {
    
    var bouncing: Bool {
        return contentOffset.x < -contentInset.left || contentOffset.x + frame.width > contentSize.width + contentInset.right
    }
    
    var imagePreviewLayout: ImagePreviewFlowLayout {
        return collectionViewLayout as! ImagePreviewFlowLayout
    }
    
    // MARK: - Initialization

    init() {
        super.init(frame: CGRectZero, collectionViewLayout: ImagePreviewFlowLayout())
        
        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        initialize()
    }
    
    private func initialize() {
        panGestureRecognizer.addTarget(self, action: "handlePanGesture:")
    }
    
    // MARK: - Panning

    @objc private func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .Ended {
            let translation = gestureRecognizer.translationInView(self)
            if translation == CGPointZero {
                if !bouncing {
                    let possibleIndexPath = indexPathForItemAtPoint(gestureRecognizer.locationInView(self))
                    if let indexPath = possibleIndexPath {
                        selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
                        delegate?.collectionView?(self, didSelectItemAtIndexPath: indexPath)
                    }
                }
            }
        }
    }
    
}
