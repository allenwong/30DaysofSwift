//
// FMMosaicLayout.m
// FMMosaicLayout
//
// Created by Julian Villella on 2015-01-30.
// Copyright (c) 2015 Fluid Media. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "FMMosaicLayout.h"

static const NSInteger kFMDefaultNumberOfColumnsInSection = 2;
static const FMMosaicCellSize kFMDefaultCellSize = FMMosaicCellSizeSmall;
static const FMMosaicCellSize kFMDefaultHeaderFooterHeight = 0.0;
static const BOOL kFMDefaultHeaderShouldOverlayContent = NO;
static const BOOL kFMDefaultFooterShouldOverlayContent = NO;

@interface FMMosaicLayout ()

/**
 *  A 2D array holding an array of columns heights for each section
 */
@property (nonatomic, strong) NSMutableArray *columnHeightsPerSection;

/**
 *  Array of cached layout attributes for each cell
 */
@property (nonatomic, strong) NSMutableDictionary *cellLayoutAttributes;

/**
 *  Array of cached layout attributes for each supplementary view (only headers and footer kinds are currently supported)
 */
@property (nonatomic, strong) NSMutableDictionary *supplementaryLayoutAttributes;

@end

@implementation FMMosaicLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    [self resetLayoutState];
    
    // Calculate layout attritbutes in each section
    for (NSInteger sectionIndex = 0; sectionIndex < [self.collectionView numberOfSections]; sectionIndex++) {

        CGFloat interitemSpacing = [self interitemSpacingAtSection:sectionIndex];
        
        // Add top section insets
        [self growColumnHeightsBy:[self insetForSectionAtIndex:sectionIndex].top section:sectionIndex];
        
        // Adds header view
        UICollectionViewLayoutAttributes *headerLayoutAttribute =
            [self addLayoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                      indexPath:[NSIndexPath indexPathForItem:0 inSection:sectionIndex]];
        
        if (![self headerShouldOverlayContent]) {
            [self growColumnHeightsBy:headerLayoutAttribute.frame.size.height + interitemSpacing section:sectionIndex];
        }
        
        // Calculate cell attributes in each section
        NSMutableArray *smallMosaicCellIndexPathsBuffer = [[NSMutableArray alloc] initWithCapacity:2];
        for (NSInteger cellIndex = 0; cellIndex < [self.collectionView numberOfItemsInSection:sectionIndex]; cellIndex++) {
            
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForItem:cellIndex inSection:sectionIndex];
            FMMosaicCellSize mosaicCellSize = [self mosaicCellSizeForItemAtIndexPath:cellIndexPath];
            NSInteger indexOfShortestColumn = [self indexOfShortestColumnInSection:sectionIndex]; // must be recalculated every time a new cell is added

            if (mosaicCellSize == FMMosaicCellSizeBig) {
                // Add big cell to shortest column, calculate layout attributes, and recalculate column height now that it's been added
                UICollectionViewLayoutAttributes *layoutAttributes = [self addBigMosaicLayoutAttributesForIndexPath:cellIndexPath inColumn:indexOfShortestColumn];
                CGFloat columnHeight = [self.columnHeightsPerSection[sectionIndex][indexOfShortestColumn] floatValue];
                self.columnHeightsPerSection[sectionIndex][indexOfShortestColumn] = @(columnHeight + layoutAttributes.frame.size.height + interitemSpacing);
                
            } else if(mosaicCellSize == FMMosaicCellSizeSmall) {
                [smallMosaicCellIndexPathsBuffer addObject:cellIndexPath];
                
                // Wait until small cell buffer is full (widths add up to one big cell), then add small cells to column heights array and layout attributes
                if(smallMosaicCellIndexPathsBuffer.count >= 2) {
                    UICollectionViewLayoutAttributes *layoutAttributes = [self addSmallMosaicLayoutAttributesForIndexPath:smallMosaicCellIndexPathsBuffer[0]
                                                            inColumn:indexOfShortestColumn bufferIndex:0];
                    [self addSmallMosaicLayoutAttributesForIndexPath:smallMosaicCellIndexPathsBuffer[1] inColumn:indexOfShortestColumn bufferIndex:1];
                    
                    // Add to small cells to shortest column, and recalculate column height now that they've been added
                    CGFloat columnHeight = [self.columnHeightsPerSection[sectionIndex][indexOfShortestColumn] floatValue];
                    self.columnHeightsPerSection[sectionIndex][indexOfShortestColumn] = @(columnHeight + layoutAttributes.frame.size.height + interitemSpacing);
                    [smallMosaicCellIndexPathsBuffer removeAllObjects];
                }
            }
        }
        
        // Handle remaining cells that didn't fill the buffer
        if (smallMosaicCellIndexPathsBuffer.count > 0) {
            NSInteger indexOfShortestColumn = [self indexOfShortestColumnInSection:sectionIndex];
            UICollectionViewLayoutAttributes *layoutAttributes = [self addSmallMosaicLayoutAttributesForIndexPath:smallMosaicCellIndexPathsBuffer[0]
                                                                                                         inColumn:indexOfShortestColumn bufferIndex:0];
            
            // Add to small cells to shortest column, and recalculate column height now that they've been added
            CGFloat columnHeight = [self.columnHeightsPerSection[sectionIndex][indexOfShortestColumn] floatValue];
            self.columnHeightsPerSection[sectionIndex][indexOfShortestColumn] = @(columnHeight + layoutAttributes.frame.size.height + interitemSpacing);
            [smallMosaicCellIndexPathsBuffer removeAllObjects];
        }
        
        // Adds footer view
        UICollectionViewLayoutAttributes *footerLayoutAttribute =
        [self addLayoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                  indexPath:[NSIndexPath indexPathForItem:1 inSection:sectionIndex]];

        if (![self footerShouldOverlayContent]) {
            [self growColumnHeightsBy:footerLayoutAttribute.frame.size.height section:sectionIndex];
        }
        
        // Add bottom section insets, and remove extra added inset
        [self growColumnHeightsBy:[self insetForSectionAtIndex:sectionIndex].bottom section:sectionIndex];
    }
}

// Calculate and return all layout attributes in a given rect
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesInRect = [[NSMutableArray alloc] initWithCapacity:self.cellLayoutAttributes.count];
    
    // Cells
    [self.cellLayoutAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        if(CGRectIntersectsRect(rect, attributes.frame)){
            [attributesInRect addObject:attributes];
        }
    }];
    
    // Supplementary views
    [self.supplementaryLayoutAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        if(CGRectIntersectsRect(rect, attributes.frame)){
            [attributesInRect addObject:attributes];
        }
    }];
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellLayoutAttributes objectForKey:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return [self.supplementaryLayoutAttributes objectForKey:indexPath];
}

// Content size is the width of the collection view, and the height of all sections combined
- (CGSize)collectionViewContentSize {
    CGFloat width = [self collectionViewContentWidth];
    __block CGFloat height = 0.0;
    
    [self.columnHeightsPerSection enumerateObjectsUsingBlock:^(NSArray *columnHeights, NSUInteger sectionIndex, BOOL *stop) {
        NSInteger indexOfTallestColumn = [self indexOfTallestColumnInSection:sectionIndex];
        height += [columnHeights[indexOfTallestColumn] floatValue];
    }];
    
    return CGSizeMake(width, height);
}

- (CGFloat)collectionViewContentWidth {
    return self.collectionView.bounds.size.width;
}

#pragma mark - Orientation

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    
    // Invalidate if the bounds has changed
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        [self prepareLayout];
        return YES;
    }
    return NO;
}

- (void)resetLayoutState {
    [self.columnHeightsPerSection removeAllObjects];
    _columnHeightsPerSection = nil;
    
    [self.cellLayoutAttributes removeAllObjects];
    _cellLayoutAttributes = nil;
    
    [self.supplementaryLayoutAttributes removeAllObjects];
    _supplementaryLayoutAttributes = nil;
}

#pragma mark - Accessors

- (NSArray *)columnHeightsPerSection {
    if (!_columnHeightsPerSection) {
        NSInteger sectionCount = [self.collectionView numberOfSections];
        _columnHeightsPerSection = [[NSMutableArray alloc] initWithCapacity:sectionCount];
        
        for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
            NSInteger numberOfColumnsInSection = [self numberOfColumnsInSection:sectionIndex];
            NSMutableArray *columnHeights = [[NSMutableArray alloc] initWithCapacity:numberOfColumnsInSection];
            
            for (NSInteger columnIndex = 0; columnIndex < numberOfColumnsInSection; columnIndex++) {
                [columnHeights addObject:@0];
            }
            
            [_columnHeightsPerSection addObject:columnHeights];
        }
    }
    
    return _columnHeightsPerSection;
}

- (NSMutableDictionary *)cellLayoutAttributes {
    if (!_cellLayoutAttributes) {
        _cellLayoutAttributes = [[NSMutableDictionary alloc] init];
    }
    return _cellLayoutAttributes;
}

- (NSMutableDictionary *)supplementaryLayoutAttributes {
    if (!_supplementaryLayoutAttributes) {
        _supplementaryLayoutAttributes = [[NSMutableDictionary alloc] init];
    }
    return _supplementaryLayoutAttributes;
}

#pragma mark - Helpers

#pragma mark Layout Attributes Helpers

// Calculates layout attributes for a small cell, adds to layout attributes array and returns it
- (UICollectionViewLayoutAttributes *)addSmallMosaicLayoutAttributesForIndexPath:(NSIndexPath *)cellIndexPath
                                                inColumn:(NSInteger)column bufferIndex:(NSInteger)bufferIndex {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
    CGRect frame = [self mosaicCellRectWithSize:FMMosaicCellSizeSmall atIndexPath:cellIndexPath inColumn:column];

    // Account for first or second small mosaic cell
    CGFloat interitemSpacing = [self interitemSpacingAtSection:cellIndexPath.section];
    CGFloat cellWidth = [self cellHeightForMosaicSize:FMMosaicCellSizeSmall section:cellIndexPath.section];
    frame.origin.x += (cellWidth + interitemSpacing) * bufferIndex;
    layoutAttributes.frame = frame;
    
    [self.cellLayoutAttributes setObject:layoutAttributes forKey:cellIndexPath];
    
    return layoutAttributes;
}

// Calculates layout attributes for a big cell, adds to layout attributes array and returns it
- (UICollectionViewLayoutAttributes *)addBigMosaicLayoutAttributesForIndexPath:(NSIndexPath *)cellIndexPath inColumn:(NSInteger)column {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
    CGRect frame = [self mosaicCellRectWithSize:FMMosaicCellSizeBig atIndexPath:cellIndexPath inColumn:column];
    layoutAttributes.frame = frame;
    
    [self.cellLayoutAttributes setObject:layoutAttributes forKey:cellIndexPath];
    
    return layoutAttributes;
}

- (CGRect)mosaicCellRectWithSize:(FMMosaicCellSize)mosaicCellSize atIndexPath:(NSIndexPath *)cellIndexPath inColumn:(NSInteger)column {
    NSInteger sectionIndex = cellIndexPath.section;
    
    CGFloat cellHeight = [self cellHeightForMosaicSize:mosaicCellSize section:sectionIndex];
    CGFloat cellWidth = cellHeight;
    CGFloat columnHeight = [self.columnHeightsPerSection[sectionIndex][column] floatValue];
    
    CGFloat originX = column * [self columnWidthInSection:sectionIndex];
    CGFloat originY = [self verticalOffsetForSection:sectionIndex] + columnHeight;
    
    // Factor in interitem spacing and insets
    UIEdgeInsets sectionInset = [self insetForSectionAtIndex:sectionIndex];
    CGFloat interitemSpacing = [self interitemSpacingAtSection:sectionIndex];
    originX += sectionInset.left;
    originX += column * interitemSpacing;
    
    return CGRectMake(originX, originY, cellWidth, cellHeight);
}

- (UICollectionViewLayoutAttributes *)addLayoutAttributesForSupplementaryViewOfKind:(NSString *)kind indexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    UIEdgeInsets sectionInset = [self insetForSectionAtIndex:indexPath.section];
    CGFloat originX = sectionInset.left;
    CGFloat originY = [self verticalOffsetForSection:indexPath.section];
    CGFloat width   = [self collectionViewContentWidth] - sectionInset.left - sectionInset.right;
    CGFloat height  = 0.0;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        height = [self heightForHeaderAtSection:indexPath.section];
        
    } else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        height = [self heightForFooterAtSection:indexPath.section];
        if ([self footerShouldOverlayContent]) {
            originY -= height;
        }
    }
    
    NSInteger tallestColumnIndex = [self indexOfTallestColumnInSection:indexPath.section];
    CGFloat sectionColumnHeight  = [self.columnHeightsPerSection[indexPath.section][tallestColumnIndex] floatValue];
    
    layoutAttributes.frame = CGRectMake(originX, sectionColumnHeight + originY, width, height);
    layoutAttributes.zIndex = 1;
    
    [self.supplementaryLayoutAttributes setObject:layoutAttributes forKey:indexPath];
    
    return layoutAttributes;
}

#pragma mark Sizing Helpers

- (CGFloat)cellHeightForMosaicSize:(FMMosaicCellSize)mosaicCellSize section:(NSInteger)section {
    CGFloat bigCellSize = [self columnWidthInSection:section];
    CGFloat interitemSpacing = [self interitemSpacingAtSection:section];
    return mosaicCellSize == FMMosaicCellSizeBig ? bigCellSize : (bigCellSize - interitemSpacing) / 2.0;
}

// The width of a column refers to the width of one FMMosaicCellSizeBig cell w/o interitem spacing
- (CGFloat)columnWidthInSection:(NSInteger)section {
    UIEdgeInsets sectionInset = [self insetForSectionAtIndex:section];
    CGFloat combinedInteritemSpacing = ([self numberOfColumnsInSection:section] - 1) * [self interitemSpacingAtSection:section];
    CGFloat combinedColumnWidth = [self collectionViewContentWidth] - sectionInset.left - sectionInset.right - combinedInteritemSpacing;
    
    return combinedColumnWidth / [self numberOfColumnsInSection:section];
}

// The vertical position where this section begins
- (CGFloat)verticalOffsetForSection:(NSInteger)section {
    CGFloat verticalOffset = 0.0;
    
    // Add up heights of all previous sections to get vertical position of this section
    for (NSInteger i = 0; i < section; i++) {
        NSInteger indexOfTallestColumn = [self indexOfTallestColumnInSection:i];
        CGFloat sectionHeight = [self.columnHeightsPerSection[i][indexOfTallestColumn] floatValue];
        verticalOffset += sectionHeight;
    }
    
    return verticalOffset;
}

- (void)growColumnHeightsBy:(CGFloat)increase section:(NSInteger)section {
    NSMutableArray *columnHeights = [self.columnHeightsPerSection objectAtIndex:section];
    
    for (int i = 0; i < columnHeights.count; i++) {
        columnHeights[i] = @([columnHeights[i] floatValue] + increase);
    }
}

#pragma mark Index Helpers

- (NSInteger)indexOfShortestColumnInSection:(NSInteger)section {
    NSArray *columnHeights = [self.columnHeightsPerSection objectAtIndex:section];

    NSInteger indexOfShortestColumn = 0;
    for (int i = 1; i < columnHeights.count; i++) {
        if([columnHeights[i] floatValue] < [columnHeights[indexOfShortestColumn] floatValue])
            indexOfShortestColumn = i;
    }
    
    return indexOfShortestColumn;
}

- (NSInteger)indexOfTallestColumnInSection:(NSInteger)section {
    NSArray *columnHeights = [self.columnHeightsPerSection objectAtIndex:section];
    
    NSInteger indexOfTallestColumn = 0;
    for (int i = 1; i < columnHeights.count; i++) {
        if([columnHeights[i] floatValue] > [columnHeights[indexOfTallestColumn] floatValue])
            indexOfTallestColumn = i;
    }
    
    return indexOfTallestColumn;
}

#pragma mark - Delegate Wrappers

- (NSInteger)numberOfColumnsInSection:(NSInteger)section {
    NSInteger columnCount = kFMDefaultNumberOfColumnsInSection;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:numberOfColumnsInSection:)]) {
        columnCount = [self.delegate collectionView:self.collectionView layout:self numberOfColumnsInSection:section];
    }
    return columnCount;
}

- (FMMosaicCellSize)mosaicCellSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMMosaicCellSize cellSize = kFMDefaultCellSize;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:mosaicCellSizeForItemAtIndexPath:)]) {
        cellSize = [self.delegate collectionView:self.collectionView layout:self mosaicCellSizeForItemAtIndexPath:indexPath];
    }
    return cellSize;
}

- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        inset = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return inset;
}

- (CGFloat)interitemSpacingAtSection:(NSInteger)section {
    CGFloat interitemSpacing = 0.0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:interitemSpacingForSectionAtIndex:)]) {
        interitemSpacing = [self.delegate collectionView:self.collectionView layout:self interitemSpacingForSectionAtIndex:section];
    }
    return interitemSpacing;
}

- (CGFloat)heightForHeaderAtSection:(NSInteger)section {
    CGFloat height = kFMDefaultHeaderFooterHeight;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
        height = [self.delegate collectionView:self.collectionView layout:self heightForHeaderInSection:section];
    }
    return height;
}

- (CGFloat)heightForFooterAtSection:(NSInteger)section {
    CGFloat height = kFMDefaultHeaderFooterHeight;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForFooterInSection:)]) {
        height = [self.delegate collectionView:self.collectionView layout:self heightForFooterInSection:section];
    }
    return height;
}

- (BOOL)headerShouldOverlayContent {
    CGFloat shouldOverlay = kFMDefaultHeaderShouldOverlayContent;
    if ([self.delegate respondsToSelector:@selector(headerShouldOverlayContentInCollectionView:layout:)]) {
        shouldOverlay = [self.delegate headerShouldOverlayContentInCollectionView:self.collectionView layout:self];
    }
    return shouldOverlay;
}

- (BOOL)footerShouldOverlayContent {
    CGFloat shouldOverlay = kFMDefaultFooterShouldOverlayContent;
    if ([self.delegate respondsToSelector:@selector(footerShouldOverlayContentInCollectionView:layout:)]) {
        shouldOverlay = [self.delegate footerShouldOverlayContentInCollectionView:self.collectionView layout:self];
    }
    return shouldOverlay;
}

// If layout delegate hasn't been provided, resort to collection view's delegate which is likely a UICollectionViewController
- (id<FMMosaicLayoutDelegate>)delegate {
    return _delegate ? _delegate : (id)self.collectionView.delegate;
}

@end
