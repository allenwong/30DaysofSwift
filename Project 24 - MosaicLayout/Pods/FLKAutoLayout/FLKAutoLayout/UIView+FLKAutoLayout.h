//
// Created by florian on 25.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


FOUNDATION_EXTERN NSString * const FLKNoConstraint;

@interface UIView (FLKAutoLayout)

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView*)view predicate:(NSString*)predicate;


- (NSArray*)alignToView:(UIView*)view;
- (NSArray*)alignTop:(NSString*)top leading:(NSString*)leading bottom:(NSString*)bottom trailing:(NSString*)trailing toView:(UIView*)view;
- (NSArray*)alignTop:(NSString*)top leading:(NSString*)leading toView:(UIView*)view;
- (NSArray*)alignBottom:(NSString*)bottom trailing:(NSString*)trailing toView:(UIView*)view;
- (NSArray*)alignTop:(NSString*)top bottom:(NSString*)bottom toView:(UIView*)view;
- (NSArray*)alignLeading:(NSString*)leading trailing:(NSString*)trailing toView:(UIView*)view;


- (NSArray*)alignLeadingEdgeWithView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)alignTrailingEdgeWithView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)alignTopEdgeWithView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)alignBottomEdgeWithView:(UIView*)view predicate:(NSString*)predicate;

- (NSArray*)alignBaselineWithView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)alignCenterXWithView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)alignCenterYWithView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)alignCenterWithView:(UIView*)view;


- (NSArray*)constrainWidth:(NSString*)widthPredicate height:(NSString*)heightPredicate;
- (NSArray*)constrainWidth:(NSString*)widthPredicate;
- (NSArray*)constrainHeight:(NSString*)heightPredicate;

- (NSArray*)constrainWidthToView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)constrainHeightToView:(UIView*)view predicate:(NSString*)predicate;

- (NSArray*)constrainAspectRatio:(NSString*)predicate;

- (NSArray*)constrainLeadingSpaceToView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray *)constrainTrailingSpaceToView:(UIView *)view predicate:(NSString *)predicate;
- (NSArray*)constrainTopSpaceToView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)constrainBottomSpaceToView:(UIView*)view predicate:(NSString*)predicate;


+ (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)ofViews toViews:(NSArray*)toViews predicate:(NSString*)predicate;
+ (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)views toAttribute:(NSLayoutAttribute)toAttribute ofViews:(NSArray*)toViews predicate:(NSString*)predicate;


+ (NSArray*)equalWidthForViews:(NSArray*)views;
+ (NSArray*)equalHeightForViews:(NSArray*)views;


+ (NSArray*)alignLeadingEdgesOfViews:(NSArray*)views;
+ (NSArray*)alignTrailingEdgesOfViews:(NSArray*)views;
+ (NSArray*)alignTopEdgesOfViews:(NSArray*)views;
+ (NSArray*)alignBottomEdgesOfViews:(NSArray*)views;
+ (NSArray*)alignLeadingAndTrailingEdgesOfViews:(NSArray*)views;
+ (NSArray*)alignTopAndBottomEdgesOfViews:(NSArray*)views;


+ (NSArray*)spaceOutViewsHorizontally:(NSArray*)views predicate:(NSString*)predicate;
+ (NSArray*)spaceOutViewsVertically:(NSArray*)views predicate:(NSString*)predicate;

+ (NSArray*)distributeCenterXOfViews:(NSArray*)views inView:(UIView*)view;
+ (NSArray*)distributeCenterYOfViews:(NSArray*)views inView:(UIView*)inView;

@end
