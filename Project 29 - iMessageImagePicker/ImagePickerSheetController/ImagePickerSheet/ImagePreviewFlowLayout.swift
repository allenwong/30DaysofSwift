//
//  ImagePreviewFlowLayout.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 06/09/14.
//  Copyright (c) 2014 Laurin Brandner. All rights reserved.
//

import UIKit

class ImagePreviewFlowLayout: UICollectionViewFlowLayout {
    
    var invalidationCenteredIndexPath: NSIndexPath?
    
    var showsSupplementaryViews: Bool = true {
        didSet {
            invalidateLayout()
        }
    }
    
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var contentSize = CGSizeZero
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        initialize()
    }
    
    private func initialize() {
        scrollDirection = .Horizontal
    }

    // MARK: - Layout
    
    override func prepareLayout() {
        super.prepareLayout()
        
        layoutAttributes.removeAll(keepCapacity: false)
        contentSize = CGSizeZero

        if let collectionView = collectionView,
               dataSource = collectionView.dataSource,
               delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            var origin = CGPoint(x: sectionInset.left, y: sectionInset.top)
            let numberOfSections = dataSource.numberOfSectionsInCollectionView?(collectionView) ?? 0
            
            for s in 0 ..< numberOfSections {
                let indexPath = NSIndexPath(forRow: 0, inSection: s)
                let size = delegate.collectionView?(collectionView, layout: self, sizeForItemAtIndexPath: indexPath) ?? CGSizeZero
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = CGRect(origin: origin, size: size)
                attributes.zIndex = 0
                
                layoutAttributes.append(attributes)
                
                origin.x = attributes.frame.maxX + sectionInset.right
            }
            
            contentSize = CGSize(width: origin.x, height: collectionView.frame.height)
        }
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        return contentSize
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        var contentOffset = proposedContentOffset
        if let indexPath = invalidationCenteredIndexPath {
            if let collectionView = collectionView {
                let frame = layoutAttributes[indexPath.section].frame
                contentOffset.x = frame.midX - collectionView.frame.width / 2.0
                
                contentOffset.x = max(contentOffset.x, -collectionView.contentInset.left)
                contentOffset.x = min(contentOffset.x, collectionViewContentSize().width - collectionView.frame.width + collectionView.contentInset.right)
            }
            invalidationCenteredIndexPath = nil
        }
        
        return super.targetContentOffsetForProposedContentOffset(contentOffset)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { CGRectIntersectsRect(rect, $0.frame) }.reduce([UICollectionViewLayoutAttributes]()) { memo, attributes in
            let supplementaryAttributes = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: attributes.indexPath)
            var allAttributes = memo
            allAttributes.append(attributes)
            allAttributes.append(supplementaryAttributes!)
            return allAttributes
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.section]
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        if let collectionView = collectionView,
            _ = collectionView.dataSource,
            delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            let itemAttributes = layoutAttributesForItemAtIndexPath(indexPath)
            
            let inset = collectionView.contentInset
            let bounds = collectionView.bounds
            let contentOffset: CGPoint = {
                var contentOffset = collectionView.contentOffset
                contentOffset.x += inset.left
                contentOffset.y += inset.top
                
                return contentOffset
            }()
            let visibleSize: CGSize = {
                var size = bounds.size
                size.width -= (inset.left+inset.right)
                
                return size
            }()
            let visibleFrame = CGRect(origin: contentOffset, size: visibleSize)
            
            let size = delegate.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: indexPath.section) ?? CGSizeZero
            let originX = max(itemAttributes!.frame.minX, min(itemAttributes!.frame.maxX - size.width, visibleFrame.maxX - size.width))
            
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
            attributes.zIndex = 1
            attributes.hidden = !showsSupplementaryViews
            attributes.frame = CGRect(origin: CGPoint(x: originX, y: itemAttributes!.frame.minY), size: size)
            
            return attributes
        }
        
        return nil
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributesForItemAtIndexPath(itemIndexPath)
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributesForItemAtIndexPath(itemIndexPath)
    }
    
}
