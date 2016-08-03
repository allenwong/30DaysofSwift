//
//  ORStackView+Private.h
//  ORStackView
//
//  Created by Orta on 10/09/2013.
//  Copyright (c) 2013 Orta. All rights reserved.
//

#import "ORStackView.h"

// Private interfaces for ORStackView ///////////////////////

@interface StackView : NSObject
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSLayoutConstraint *precedingConstraint;
@property (nonatomic, assign) CGFloat constant;
@end

@interface ORStackView()

/// An array of StackView objects in the order they should be shown
@property (nonatomic, strong) NSMutableArray *viewStack;

// Methods that allow subclasses to make changes around how views are inserted.
- (void)_addSubview:(UIView *)view withPrecedingMargin:(CGFloat)precedingMargin centered:(BOOL)centered sideMargin:(CGFloat)sideMargin;

// Methods that allow subclasses to make changes around how views are inserted.
- (void)_insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)precedingMargin centered:(BOOL)centered sideMargin:(CGFloat)sideMargin;
@end
