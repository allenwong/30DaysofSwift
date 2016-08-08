//
// Created by florian on 25.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FLKAutoLayoutPredicateList.h"


@implementation FLKAutoLayoutPredicateList {
    NSMutableArray* predicates;
}

+ predicateListFromString:(NSString*)string {
    FLKAutoLayoutPredicateList* predicateList = [[FLKAutoLayoutPredicateList alloc] init];
    NSArray* predicateStrings = [string componentsSeparatedByString:@","];
    if (!predicateStrings.count) {
        predicateStrings = @[@"0"];
    }
    for (NSString* predicateString in predicateStrings) {
        [predicateList addPredicateFromString:predicateString];
    }
    NSAssert(predicateList->predicates.count > 0, @"Invalid layout predicate: %@", string);
    return predicateList;
}


- (id)init {
    self = [super init];
    if (self) {
        predicates = [NSMutableArray array];
    }
    return self;
}

- (NSArray*)iteratePredicatesUsingBlock:(predicateBlock)block {
    NSMutableArray* constraints = [NSMutableArray array];
    for (NSValue* predicateValue in predicates) {
        FLKAutoLayoutPredicate predicate;
        [predicateValue getValue:&predicate];
        NSLayoutConstraint* constraint = block(predicate);
        if (constraint) {
            [constraints addObject:constraint];
        }
    }
    return constraints;
}

- (void)addPredicateFromString:(NSString*)string {
    NSRegularExpression* predicateRegEx = [self predicateExpression];
    NSTextCheckingResult* match = [predicateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    NSAssert(match, @"Invalid layout predicate: %@", string);
    NSRange relationRange = [match rangeAtIndex:1];
    NSRange multiplierRange = [match rangeAtIndex:2];
    NSRange constantRange = [match rangeAtIndex:3];
    NSRange priorityRange = [match rangeAtIndex:4];

    FLKAutoLayoutPredicate predicate = [self defaultPredicate];
    if (multiplierRange.location != NSNotFound) {
        predicate.multiplier = [[string substringWithRange:multiplierRange] floatValue];
    }
    if (constantRange.location != NSNotFound) {
        predicate.constant = [[string substringWithRange:constantRange] floatValue];
    }
    if (relationRange.location != NSNotFound) {
        predicate.relation = [self relationFromString:[string substringWithRange:relationRange]];
    }
    if (priorityRange.location != NSNotFound) {
        predicate.priority = [[string substringWithRange:priorityRange] integerValue];
    }
    [predicates addObject:[NSValue valueWithBytes:&predicate objCType:@encode(FLKAutoLayoutPredicate)]];
}

- (NSLayoutRelation)relationFromString:(NSString*)relationString {
    if ([relationString isEqualToString:@"<="]) {
        return NSLayoutRelationLessThanOrEqual;
    } else if ([relationString isEqualToString:@">="]) {
        return NSLayoutRelationGreaterThanOrEqual;
    } else {
        return NSLayoutRelationEqual;
    }
}


- (FLKAutoLayoutPredicate)defaultPredicate {
    return FLKAutoLayoutPredicateMake(NSLayoutRelationEqual, 1, 0, 0);
}

- (NSRegularExpression*)predicateExpression {
    static NSRegularExpression* predicateRegEx;
    if (!predicateRegEx) {
        predicateRegEx = [NSRegularExpression regularExpressionWithPattern:@"^\\s*(==|>=|<=)?\\s*(?:\\*([+\\-]?[\\d\\.]+))?\\s*([+\\-]?[\\d\\.]+)?\\s*(?:@(\\d+))?\\s*$"
                                                                   options:NSRegularExpressionCaseInsensitive
                                                                     error:NULL];
    }
    return predicateRegEx;
}

@end
