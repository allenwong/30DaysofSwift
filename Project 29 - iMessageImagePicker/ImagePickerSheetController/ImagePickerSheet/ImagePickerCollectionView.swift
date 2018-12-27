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
        super.init(frame: .zero, collectionViewLayout: ImagePreviewFlowLayout())
        
        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        initialize()
    }
    
    private func initialize() {
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
    }
    
    // MARK: - Panning

    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let translation = gestureRecognizer.translation(in: self)
            if translation == CGPoint.zero {
                if !bouncing {
                    let possibleIndexPath = indexPathForItem(at: gestureRecognizer.location(in: self))
                    if let indexPath = possibleIndexPath {
                        selectItem(at: indexPath, animated: false, scrollPosition: .top)
                        delegate?.collectionView?(self, didSelectItemAt: indexPath)
                    }
                }
            }
        }
    }
    
}
