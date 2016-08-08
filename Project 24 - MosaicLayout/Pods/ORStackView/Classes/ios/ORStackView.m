//
//  ORStackView.m
//  ORStackView
//
//  Created by Orta on 10/09/2013.
//  Copyright (c) 2014 Orta. All rights reserved.
//

#import "ORStackView.h"
#import <FLKAutoLayout/UIView+FLKAutoLayout.h>
#import "ORStackView+Private.h"

@interface ORStackView()

/// Delay updating constraints when true
@property (nonatomic, assign) BOOL batchingUpdates;
@property (nonatomic, strong) NSLayoutConstraint *lastConstraint;

@end

@implementation ORStackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    [self _setup];

    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)awakeFromNib
{
    [self _setup];
}

- (void)_setup
{
    _viewStack = [NSMutableArray array];
    _lastMarginHeight = 0;
    _direction = ORStackViewDirectionVertical;
}

- (void)updateConstraints
{
    // Remove all constraints
    for (StackView *stackView in self.viewStack) {
        [self removeConstraint:stackView.precedingConstraint];
    }

    // Add the new constraints
    for (StackView *stackView in self.viewStack) {
        UIView *view = stackView.view;
        NSString *constraint = @(stackView.constant).stringValue;
        NSInteger index = [self.viewStack indexOfObject:stackView];

        if (self.direction == ORStackViewDirectionVertical) {
            if (index == 0) {
                if (self.topLayoutGuide) {
                    id topLayoutGuide = self.topLayoutGuide;
                    NSString *vhl = [NSString stringWithFormat:@"V:[topLayoutGuide]-%@-[view]", constraint];
                    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:vhl options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(view, topLayoutGuide)];
                    [self addConstraints:constraints];
                    stackView.precedingConstraint = [constraints firstObject];
                } else {
                    stackView.precedingConstraint = [[view alignTopEdgeWithView:self predicate:constraint] lastObject];
                }
            } else {
                UIView *viewAbove = [self.viewStack[index - 1] view];
                stackView.precedingConstraint = [[view constrainTopSpaceToView:viewAbove predicate:constraint] lastObject];
            }
        } else {
            if (index == 0) {
                stackView.precedingConstraint = [[view alignLeadingEdgeWithView:self predicate:constraint] lastObject];
            } else {
                UIView *viewAbove = [self.viewStack[index - 1] view];
                stackView.precedingConstraint = [[view constrainLeadingSpaceToView:viewAbove predicate:constraint] lastObject];
            }
        }
    }

    if (self.lastMarginHeight != NSNotFound) {
        [self removeConstraint:self.lastConstraint];
        UIView *lastView = self.lastView;
        if (self.lastView) {
            NSString *constraint = @(self.lastMarginHeight).stringValue;
            if (self.direction == ORStackViewDirectionVertical) {
                self.lastConstraint = [[self alignBottomEdgeWithView:lastView predicate:constraint] lastObject];
            } else {
                self.lastConstraint = [[self alignTrailingEdgeWithView:lastView predicate:constraint] lastObject];
            }
        }
    }

    [super updateConstraints];
}

#pragma mark - Adding Subviews

- (void)addSubview:(UIView *)view withPrecedingMargin:(CGFloat)margin
{
    [self _addSubview:view withPrecedingMargin:margin centered:NO sideMargin:0];
}

- (void)addSubview:(UIView *)view withPrecedingMargin:(CGFloat)precedingMargin sideMargin:(CGFloat)sideMargin
{
    [self _addSubview:view withPrecedingMargin:precedingMargin centered:YES sideMargin:sideMargin];
}

- (void)_addSubview:(UIView *)view withPrecedingMargin:(CGFloat)precedingMargin centered:(BOOL)centered sideMargin:(CGFloat)sideMargin
{
    NSInteger index = self.viewStack.count;
    [self _insertSubview:view atIndex:index withPrecedingMargin:precedingMargin centered:centered sideMargin:sideMargin];
}

#pragma mark - Inserting Subviews

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)margin;
{
    [self _insertSubview:view atIndex:index withPrecedingMargin:margin centered:NO sideMargin:0];
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)precedingMargin sideMargin:(CGFloat)sideMargin
{
    [self _insertSubview:view atIndex:index withPrecedingMargin:precedingMargin centered:YES sideMargin:sideMargin];
}


- (void)insertSubview:(UIView *)view afterSubview:(UIView *)siblingSubview withPrecedingMargin:(CGFloat)margin
{
    BOOL hasSibling = [self.subviews containsObject:siblingSubview];
    NSInteger index = hasSibling ? [self indexOfView:siblingSubview] : self.viewStack.count;
    [self _insertSubview:view atIndex:index withPrecedingMargin:margin centered:NO sideMargin:0];
}

- (void)insertSubview:(UIView *)view beforeSubview:(UIView *)siblingSubview withPrecedingMargin:(CGFloat)margin
{
    NSAssert([self.subviews containsObject:siblingSubview], @"SiblingSubview not found in ORStackView");

    NSInteger index = [self indexOfView:siblingSubview] - 1;
    [self _insertSubview:view atIndex:index withPrecedingMargin:margin centered:NO sideMargin:0];
}

- (void)_insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)precedingMargin
                                                                          centered:(BOOL)centered sideMargin:(CGFloat)sideMargin
{
    NSParameterAssert(view);
    if ([self.subviews containsObject:view]) return;

    [super addSubview:view];

    StackView *stackView = [[StackView alloc] init];
    stackView.view = view;
    stackView.constant = precedingMargin;
    [self.viewStack insertObject:stackView atIndex:index];

    if (centered) {
        if (self.direction == ORStackViewDirectionVertical) {
            [view constrainWidthToView:self predicate:@(-sideMargin).stringValue];
            [view alignCenterXWithView:self predicate:nil];
        } else {
            [view constrainHeightToView:self predicate:@(-sideMargin).stringValue];
            [view alignCenterYWithView:self predicate:nil];
        }
    }

    if (!self.batchingUpdates) [self setNeedsUpdateConstraints];
}

#pragma mark Removal

- (void)removeSubview:(UIView *)subview
{
    if (![self.subviews containsObject:subview]) return;

    [subview removeFromSuperview];

    for (StackView *stackView in self.viewStack.copy) {
        if ([subview isEqual:stackView.view]) {
            [self.viewStack removeObject:stackView];
        }
    }

    if (!self.batchingUpdates) [self setNeedsUpdateConstraints];
}

- (void)removeAllSubviews
{
    for (StackView *stackView in [self.viewStack copy]) {
        [self.viewStack removeObject:stackView];
        [stackView.view removeFromSuperview];
    }

    if (!self.batchingUpdates) [self setNeedsUpdateConstraints];
}

#pragma mark Batching

- (void)performBatchUpdates:(void (^)(void))updates;
{
    NSParameterAssert(updates);

    self.batchingUpdates = YES;
    updates();
    self.batchingUpdates = NO;

    [self setNeedsUpdateConstraints];
}

- (void)addViewController:(UIViewController *)viewController toParent:(UIViewController *)parentViewController withPrecedingMargin:(CGFloat)margin
{
    [viewController willMoveToParentViewController:parentViewController];
    [parentViewController addChildViewController:viewController];
    [self addSubview:viewController.view withPrecedingMargin:margin];
    [viewController didMoveToParentViewController:parentViewController];
}

- (void)addViewController:(UIViewController *)viewController toParent:(UIViewController *)parentViewController withPrecedingMargin:(CGFloat)margin sideMargin:(CGFloat)sideMargin;
{
    [viewController willMoveToParentViewController:parentViewController];
    [parentViewController addChildViewController:viewController];
    [self addSubview:viewController.view withPrecedingMargin:margin sideMargin:sideMargin];
    [viewController didMoveToParentViewController:parentViewController];
}


#pragma mark Helper functions

- (NSInteger)indexOfView:(UIView *)view
{
    for (StackView *stackView in self.viewStack) {
        if ([view isEqual:stackView.view]) {
            return [self.viewStack indexOfObject:stackView];
        }
    }
    return NSNotFound;
}

- (NSLayoutConstraint *)precedingConstraintForView:(UIView *)view
{
    for (StackView *stackView in self.viewStack) {
        if ([view isEqual:stackView.view]) {
            return stackView.precedingConstraint;
        }
    }
    return nil;
}

- (UIView *)lastView
{
    return [[self.viewStack lastObject] view];
}

#pragma mark - Layout Guides

- (void)setTopLayoutGuide:(id<UILayoutSupport>)topLayoutGuide {
    _topLayoutGuide = topLayoutGuide;
    [self needsUpdateConstraints];
}

#pragma mark - Direction

- (void)setDirection:(ORStackViewDirection)direction {
    _direction = direction;
    [self setNeedsUpdateConstraints];
}

@end
