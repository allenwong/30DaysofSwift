//
// Created by florian on 25.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "UIView+FLKAutoLayoutPredicate.h"


typedef NSLayoutConstraint* (^predicateBlock)(FLKAutoLayoutPredicate predicate);


@interface FLKAutoLayoutPredicateList : NSObject

+ (id)predicateListFromString:(NSString*)string;
- (NSArray*)iteratePredicatesUsingBlock:(predicateBlock)block;

@end
