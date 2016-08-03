//
//  ORStackScrollView.h
//  ORStackView
//
//  Created by Orta on 10/09/2013.
//  Copyright (c) 2013 Orta. All rights reserved.
//

#import "ORStackScrollView.h"
#import "ORStackView.h"

/// A UIScrollView subclass that is automatically set up with the
/// common constraints for a scrollable ORStackView

@interface ORStackScrollView : UIScrollView

@property (nonatomic, strong, readonly) ORStackView *stackView;

/// Optional init method in case you want to use a subclass of ORStackView
- (instancetype)initWithStackViewClass:(Class)klass;

@end
