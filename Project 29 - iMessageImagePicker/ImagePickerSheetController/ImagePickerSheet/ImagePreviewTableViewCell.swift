//
//  ImagePreviewTableViewCell.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 06/09/14.
//  Copyright (c) 2014 Laurin Brandner. All rights reserved.
//

import UIKit

class ImagePreviewTableViewCell : UITableViewCell {
    
    var collectionView: ImagePickerCollectionView? {
        willSet {
            if let collectionView = collectionView {
                collectionView.removeFromSuperview()
            }
            
            if let collectionView = newValue {
                addSubview(collectionView)
            }
        }
    }
    
    // MARK: - Other Methods
    
    override func prepareForReuse() {
        collectionView = nil
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Setting the frame of the collectionView this large avoids a small animation glitch when resizing the previews. You'll get a beer from @larcus94 if you'll get it to work without this workaround :)
        
        if let collectionView = collectionView {
            collectionView.frame = CGRect(x: -bounds.width, y: bounds.minY, width: bounds.width*3, height: bounds.height)
            collectionView.contentInset = UIEdgeInsetsMake(0.0, bounds.width, 0.0, bounds.width)
        }
    }
    
}
