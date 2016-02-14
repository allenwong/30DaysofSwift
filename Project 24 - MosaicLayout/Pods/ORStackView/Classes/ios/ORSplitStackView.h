//
//  ARSplitStackView.h
//  ORStackView
//
//  Created by Orta on 24/10/2013.
//  Copyright (c) 2013 Orta. All rights reserved.
//

#import "ORStackView.h"

/// A wrapper for two ORStackView's that will be the height of the
/// lowest stack. 

@interface ORSplitStackView : UIView

/// Create a new split stack view with two optional width predicates for the left and right stackviews

- (instancetype)initWithLeftPredicate:(NSString *)left rightPredicate:(NSString *)right;

/// An accessor for the left aligned stack
@property (nonatomic, weak, readonly) ORStackView *leftStack;

/// An accessor for the right aligned stack
@property (nonatomic, weak, readonly) ORStackView *rightStack;

@end
