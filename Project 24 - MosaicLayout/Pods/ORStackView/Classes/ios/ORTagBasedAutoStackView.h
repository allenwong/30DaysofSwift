//
//  ORTagBasedAutoStackView.h
//  ORStackView
//
//  Created by Orta on 10/09/2013.
//  Copyright (c) 2013 Orta. All rights reserved.
//

#import "ORStackView.h"

/// A ORStackView subclass that will use view.tag intergers to determine
/// the order of a view heirarchy. Will add above any view with a number higher
/// therefore 0 is the top.

@interface ORTagBasedAutoStackView : ORStackView


// Please don't use the insert methods on this class
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)margin __attribute__((unavailable("Inserting subviews is not supported on ORTagBasedAutoStackView.")));

// Please don't use the insert methods on this class
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index withPrecedingMargin:(CGFloat)precedingMargin sideMargin:(CGFloat)sideMargin __attribute__((unavailable("Inserting subviews is not supported on ORTagBasedAutoStackView.")));

// Please don't use the insert methods on this class
- (void)insertSubview:(UIView *)view afterSubview:(UIView *)siblingSubview withPrecedingMargin:(CGFloat)margin __attribute__((unavailable("Inserting subviews is not supported on ORTagBasedAutoStackView.")));

// Please don't use the insert methods on this class
- (void)insertSubview:(UIView *)view beforeSubview:(UIView *)siblingSubview withPrecedingMargin:(CGFloat)margin __attribute__((unavailable("Inserting subviews is not supported on ORTagBasedAutoStackView.")));

@end
