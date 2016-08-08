//
//  ORStackView+Private.m
//  ORStackView
//
//  Created by Orta on 10/09/2013.
//  Copyright (c) 2013 Orta. All rights reserved.
//

#import "ORStackView+Private.h"

@implementation StackView

- (NSString *)debugDescription
{
    NSMutableString *descriptionString = [@"StackView: " mutableCopy];
    if ([self.view respondsToSelector:@selector(text)]) {
        [descriptionString appendString:[(id)self.view text]];
    }
    [descriptionString appendFormat:@" ( %f )", self.constant];
    return descriptionString;
}

@end

@implementation ORStackView (Private)
@end
