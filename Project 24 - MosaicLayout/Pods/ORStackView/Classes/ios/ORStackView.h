//
//  ORStackView.h
//  ORStackView
//
//  Created by Orta on 10/09/2013.
//  Copyright (c) 2013 Orta. All rights reserved.
//

/// A view that will handle vertical stacking subviews for you
/// allowing arbitrary insertion or removal

typedef NS_ENUM(NSUInteger, ORStackViewDirection)  {
    ORStackViewDirectionVertical,
    ORStackViewDirectionHorizontal
};

@interface ORStackView : UIView

/// Adds a view to the hierarchy, depending on the orientation it will place it
/// at the the top of the stack either vertically or horizontally.
/// After this views will be attached incrementally.
- (void)addSubview:(UIView *)view withPrecedingMargin:(CGFloat)margin;

/// Adds a view to the hierarchy like addSubview:withPrecedingMargin:
/// will also center and apply side margins as insets from edge
- (void)addSubview:(UIView *)view withPrecedingMargin:(CGFloat)precedingMargin sideMargin:(CGFloat)sideMargin;

/// Adds a view controller's view to the stack hierarchy
- (void)addViewController:(UIViewController *)viewController toParent:(UIViewController *)parentViewController withPrecedingMargin:(CGFloat)margin;

/// Adds a view controller's view to the stack hierarchy, and applies edge insets
- (void)addViewController:(UIViewController *)viewController toParent:(UIViewController *)parentViewController withPrecedingMargin:(CGFloat)margin sideMargin:(CGFloat)sideMargin;


// Note: These indexes are not z-order, but stack order.
//  z-index ordering can be done with the UIView methods bringSubviewToFront:

/// Insert a subview at an arbitrary index in the stack's order
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)margin;

/// Inserts a subview and centers it
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)precedingMargin sideMargin:(CGFloat)sideMargin;

/// Insert a subview after another view, or at the end if it cannot be found
- (void)insertSubview:(UIView *)view afterSubview:(UIView *)siblingSubview withPrecedingMargin:(CGFloat)margin;

/// Insert a subview before another view, will assert if view is not found
- (void)insertSubview:(UIView *)view beforeSubview:(UIView *)siblingSubview withPrecedingMargin:(CGFloat)margin;

/// Remove a subview from the Stack View
- (void)removeSubview:(UIView *)subview;

/// Remove all subviews from the Stack View
- (void)removeAllSubviews;

/// Perform insertion / removals without updating the constraints
- (void)performBatchUpdates:(void (^)(void))updates;


// Useful getters

/// Returns the first constraint for a specific view, depending on the orientation it will be top or left constraint.
- (NSLayoutConstraint *)precedingConstraintForView:(UIView *)view;

/// Returns the lowest view in the stack.
- (UIView *)lastView;

/// Setting this creates a last constraint letting the ORStackView set it's own height or width (depending on orientation), defaults to 0, use NSNotFound to not create constraint.
@property (nonatomic, assign) CGFloat lastMarginHeight;

/// Settings this will create a constraint on the top view making the view sit below the layout guide (and the top margin)
@property (nonatomic, strong) id<UILayoutSupport> topLayoutGuide;

/// Direction of stack layout.
@property (nonatomic, assign) ORStackViewDirection direction;

/// I'd prefer you to not use the UIView subview APIs please, things will break.
- (void)addSubview:(UIView *)view __attribute__((unavailable("addSubview is not supported on ORStackView.")));

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index __attribute__((unavailable("insertSubview is not supported on ORStackView.")));
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview __attribute__((unavailable("insertSubview is not supported on ORStackView.")));
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview __attribute__((unavailable("insertSubview is not supported on ORStackView.")));

@end
