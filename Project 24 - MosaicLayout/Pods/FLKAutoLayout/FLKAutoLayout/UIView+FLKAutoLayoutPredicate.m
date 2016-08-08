//
// Created by florian on 26.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIView+FLKAutoLayoutPredicate.h"

FLKAutoLayoutPredicate FLKAutoLayoutPredicateMake(NSLayoutRelation relation, CGFloat multiplier, CGFloat constant, UILayoutPriority priority) {
    FLKAutoLayoutPredicate predicate;
    predicate.relation = relation;
    predicate.multiplier = multiplier;
    predicate.constant = constant;
    predicate.priority = priority;
    return predicate;
}


@implementation UIView (FLKAutoLayoutPredicate)


- (NSLayoutConstraint*)applyPredicate:(FLKAutoLayoutPredicate)predicate toView:(UIView*)toView attribute:(NSLayoutAttribute)attribute {
    return [self applyPredicate:predicate toView:toView fromAttribute:attribute toAttribute:attribute];
}

- (NSLayoutConstraint*)applyPredicate:(FLKAutoLayoutPredicate)predicate toView:(UIView*)view fromAttribute:(NSLayoutAttribute)fromAttribute toAttribute:(NSLayoutAttribute)toAttribute {
    if (predicate.priority > UILayoutPriorityRequired) return nil;

    UIView* commonSuperview = [self commonSuperviewWithView:view];
    self.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                              attribute:fromAttribute
                                              relatedBy:predicate.relation
                                                 toItem:view
                                              attribute:toAttribute
                                             multiplier:predicate.multiplier
                                               constant:predicate.constant];
    if (predicate.priority) {
        constraint.priority = predicate.priority;
    }
    [commonSuperview addConstraint:constraint];

    return constraint;
}

- (UIView*)commonSuperviewWithView:(UIView*)view {
    if (!view) {
        return self;
    } else if (self.superview == view) {
        return view;
    } else if (self == view.superview) {
        return self;
    } else if (self.superview == view.superview) {
        return self.superview;
    } else {
        UIView* commonSuperview = [self traverseViewTreeForCommonSuperViewWithView:view];
        NSAssert(commonSuperview, @"Cannot find common superview of %@ and %@. Did you forget to call addSubview: before adding constraints?", self, view);
        return commonSuperview;
    }
}

- (UIView*)traverseViewTreeForCommonSuperViewWithView:(UIView*)view {
    NSMutableOrderedSet* selfSuperviews = [NSMutableOrderedSet orderedSet];
    UIView* selfSuperview = self;
    while (selfSuperview) {
        [selfSuperviews addObject:selfSuperview];
        selfSuperview = selfSuperview.superview;
    }
    UIView* superview = view;
    while (superview) {
        if ([selfSuperviews containsObject:superview]) {
            return superview;
        }
        superview = superview.superview;
    }
    return nil;
}

@end
