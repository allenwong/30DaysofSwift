//
// Created by florian on 25.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIView+FLKAutoLayout.h"
#import "FLKAutoLayoutPredicateList.h"

NSString * const FLKNoConstraint = @"0@1001"; // maximum valid priority is 1000, constraints with a priority > 1000 will be ignored by FLKAutoLayout

typedef NSArray* (^viewChainingBlock)(UIView* view1, UIView* view2);


@implementation UIView (FLKAutoLayout)


#pragma mark Generic constraint methods for two views

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute toView:(UIView*)view predicate:(NSString*)predicate {
    NSArray* views = view ? @[view] : nil;
    return [UIView alignAttribute:attribute ofViews:@[self] toViews:views predicate:predicate];
}

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView*)view predicate:(NSString*)predicate {
    NSArray* views = view ? @[view] : nil;
    return [UIView alignAttribute:attribute ofViews:@[self] toAttribute:toAttribute ofViews:views predicate:predicate];
}


#pragma mark Constrain multiple edges of two views

- (NSArray*)alignToView:(UIView*)view {
    return [self alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:view];
}

- (NSArray*)alignTop:(NSString*)top bottom:(NSString*)bottom toView:(UIView*)view {
	NSArray* topConstraints = [self alignTopEdgeWithView:view predicate:top];
    NSArray* bottomConstraints = [self alignBottomEdgeWithView:view predicate:bottom];
    return [topConstraints arrayByAddingObjectsFromArray:bottomConstraints];
}
- (NSArray*)alignLeading:(NSString*)leading trailing:(NSString*)trailing toView:(UIView*)view {
	NSArray* leadingConstraints = [self alignLeadingEdgeWithView:view predicate:leading];
    NSArray* trailingConstraints = [self alignTrailingEdgeWithView:view predicate:trailing];
    return [leadingConstraints arrayByAddingObjectsFromArray:trailingConstraints];
}

- (NSArray*)alignTop:(NSString*)top leading:(NSString*)leading bottom:(NSString*)bottom trailing:(NSString*)trailing toView:(UIView*)view {
    NSArray* topLeadingConstraints = [self alignTop:top leading:leading toView:view];
    NSArray* bottomTrailingConstraints = [self alignBottom:bottom trailing:trailing toView:view];
    return [topLeadingConstraints arrayByAddingObjectsFromArray:bottomTrailingConstraints];
}

- (NSArray*)alignTop:(NSString*)top leading:(NSString*)leading toView:(UIView*)view {
    NSArray* topConstraints = [self alignTopEdgeWithView:view predicate:top];
    NSArray* leadingConstraints = [self alignLeadingEdgeWithView:view predicate:leading];
    return [topConstraints arrayByAddingObjectsFromArray:leadingConstraints];
}

- (NSArray*)alignBottom:(NSString*)bottom trailing:(NSString*)trailing toView:(UIView*)view {
    NSArray* bottomConstraints = [self alignBottomEdgeWithView:view predicate:bottom];
    NSArray* trailingConstraints = [self alignTrailingEdgeWithView:view predicate:trailing];
    return [bottomConstraints arrayByAddingObjectsFromArray:trailingConstraints];
}


#pragma mark Constraining one edge of two views

- (NSArray*)alignLeadingEdgeWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeLeading toView:view predicate:predicate];
}

- (NSArray*)alignTrailingEdgeWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeTrailing toView:view predicate:predicate];
}

- (NSArray*)alignTopEdgeWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeTop toView:view predicate:predicate];
}

- (NSArray*)alignBottomEdgeWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeBottom toView:view predicate:predicate];
}

- (NSArray*)alignBaselineWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeBaseline toView:view predicate:predicate];
}

- (NSArray*)alignCenterXWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeCenterX toView:view predicate:predicate];
}

- (NSArray*)alignCenterYWithView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeCenterY toView:view predicate:predicate];
}

- (NSArray*)alignCenterWithView:(UIView*)view {
    NSArray* centerXConstraints = [self alignCenterXWithView:view predicate:nil];
    NSArray* centerYConstraints = [self alignCenterYWithView:view predicate:nil];
    return [centerXConstraints arrayByAddingObjectsFromArray:centerYConstraints];
}


#pragma mark Constrain width & height of a view

- (NSArray*)constrainWidth:(NSString*)widthPredicate height:(NSString*)heightPredicate {
    NSArray* widthConstraints = [self constrainWidth:widthPredicate];
    NSArray* heightConstraints = [self constrainHeight:heightPredicate];
    return [widthConstraints arrayByAddingObjectsFromArray:heightConstraints];
}

- (NSArray*)constrainWidth:(NSString*)widthPredicate {
    return [self alignAttribute:NSLayoutAttributeWidth toView:nil predicate:widthPredicate];
}

- (NSArray*)constrainHeight:(NSString*)heightPredicate {
    return [self alignAttribute:NSLayoutAttributeHeight toView:nil predicate:heightPredicate];
}

- (NSArray*)constrainWidthToView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeWidth toView:view predicate:predicate];
}

- (NSArray*)constrainHeightToView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeHeight toView:view predicate:predicate];
}

- (NSArray*)constrainAspectRatio:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeWidth toAttribute:NSLayoutAttributeHeight ofView:self predicate:predicate];
}


#pragma mark Spacing out two views

- (NSArray*)constrainLeadingSpaceToView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeLeading toAttribute:NSLayoutAttributeTrailing ofView:view predicate:predicate];
}

-(NSArray *)constrainTrailingSpaceToView:(UIView *)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeTrailing toAttribute:NSLayoutAttributeLeading ofView:view predicate:predicate];
}

- (NSArray*)constrainTopSpaceToView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofView:view predicate:predicate];
}

- (NSArray*)constrainBottomSpaceToView:(UIView*)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeTop ofView:view predicate:predicate];
}





#pragma mark Generic constraint methods for multiple views

+ (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)ofViews toViews:(NSArray*)toViews predicate:(NSString*)predicate {
    return [self alignAttribute:attribute ofViews:ofViews toAttribute:attribute ofViews:toViews predicate:predicate];
}

+ (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)views toAttribute:(NSLayoutAttribute)toAttribute ofViews:(NSArray*)toViews predicate:(NSString*)predicate {
    NSAssert(views.count == toViews.count || !toViews, @"Aligning attributes of multiple views to multiple views requires both view arrays to be the same length");
    FLKAutoLayoutPredicateList* predicateList = [FLKAutoLayoutPredicateList predicateListFromString:predicate];
    NSMutableArray* constraints = [NSMutableArray array];
    for (NSUInteger i = 0; i < views.count; i++) {
        NSArray* pairConstraints = [predicateList iteratePredicatesUsingBlock:^NSLayoutConstraint*(FLKAutoLayoutPredicate predicateElement) {
            return [views[i] applyPredicate:predicateElement toView:toViews[i] fromAttribute:attribute toAttribute:toAttribute];
        }];
        [constraints addObjectsFromArray:pairConstraints];
    }
    return constraints;
}


#pragma mark Aligning one edge of multiple views

+ (NSArray*)alignLeadingEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 alignLeadingEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)alignTrailingEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 alignTrailingEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)alignTopEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 alignTopEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)alignBottomEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 alignBottomEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)alignLeadingAndTrailingEdgesOfViews:(NSArray*)views {
    NSArray* leadingConstraints = [self alignLeadingEdgesOfViews:views];
    NSArray* trailingConstraints = [self alignTrailingEdgesOfViews:views];
    return [leadingConstraints arrayByAddingObjectsFromArray:trailingConstraints];
}

+ (NSArray*)alignTopAndBottomEdgesOfViews:(NSArray*)views {
    NSArray* topConstraints = [self alignTopEdgesOfViews:views];
    NSArray* bottomConstraints = [self alignBottomEdgesOfViews:views];
    return [topConstraints arrayByAddingObjectsFromArray:bottomConstraints];
}


#pragma mark Constraining widths & heights of multiple views

+ (NSArray*)equalWidthForViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 constrainWidthToView:view1 predicate:nil];
    }];
}

+ (NSArray*)equalHeightForViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 constrainHeightToView:view1 predicate:nil];
    }];
}


#pragma mark Space out multiple views

+ (NSArray*)spaceOutViewsHorizontally:(NSArray*)views predicate:(NSString*)predicate{
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 constrainLeadingSpaceToView:view1 predicate:predicate];
    }];
}

+ (NSArray*)spaceOutViewsVertically:(NSArray*)views predicate:(NSString*)predicate {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 constrainTopSpaceToView:view1 predicate:predicate];
    }];
}

+ (NSArray*)distributeCenterXOfViews:(NSArray*)views inView:(UIView*)inView {
    return [self distributeAttribute:NSLayoutAttributeCenterX OfViews:views inView:inView];
}

+ (NSArray*)distributeCenterYOfViews:(NSArray*)views inView:(UIView*)inView {
    return [self distributeAttribute:NSLayoutAttributeCenterY OfViews:views inView:inView];
}

+ (NSArray*)distributeAttribute:(NSLayoutAttribute)attribute OfViews:(NSArray*)views inView:(UIView*)inView {
    NSAssert(views.count > 1, @"Distribute views requires at least two views");
    CGFloat interval = 2.0f / (views.count - 1);
    CGFloat multiplier = 0;
    NSMutableArray* constraints = [NSMutableArray array];
    for (UIView* view in views) {
        FLKAutoLayoutPredicate predicate = FLKAutoLayoutPredicateMake(NSLayoutRelationEqual, multiplier, 0, 0);
        NSLayoutConstraint* constraint = [view applyPredicate:predicate toView:inView attribute:attribute];
        if (constraint) {
            [constraints addObject:constraint];
        }
        multiplier += interval;
    }
    return constraints;
}



#pragma mark Internal helpers

+ (NSArray*)chainViews:(NSArray*)views usingBlock:(viewChainingBlock)block {
    NSAssert(views.count > 1, @"Operations on multiple views require at least 2 views");
    NSMutableArray* constraints = [NSMutableArray array];
    for (NSUInteger i = 1; i < views.count; i++) {
        [constraints addObjectsFromArray:block(views[i-1], views[i])];
    }
    return constraints;
}

@end
