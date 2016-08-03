# ORStackView

[![Build Status](https://travis-ci.org/orta/ORStackView.svg)](https://travis-ci.org/orta/ORStackView)
[![Coverage Status](https://coveralls.io/repos/orta/ORStackView/badge.svg?branch=master)](https://coveralls.io/r/orta/ORStackView?branch=master)
[![Version](http://cocoapod-badges.herokuapp.com/v/ORStackView/badge.png)](http://cocoadocs.org/docsets/ORStackView)
[![Platform](http://cocoapod-badges.herokuapp.com/p/ORStackView/badge.png)](http://cocoadocs.org/docsets/ORStackView)

Makes setting up a collection of stacked views simple.
Uses [FLKAutoLayout](https://github.com/dkduck/FLKAutoLayout) to simplify the API, you should probably be using it anyway. Depending on demand this can be switched out. If you're interested in more information you can read  [ORStackView.h](https://github.com/orta/ORStackView/blob/master/Classes/ios/ORStackView.h)



### ORStackView

You can create an ORStackView and simply add subviews to it in the order in which you'd like them to appear. New subviews are added to the bottom of the ORStackView. In the this example, tapping the first subview will add a new subview to the bottom of the stack.

<a href="https://github.com/1aurabrown/ORStackView/tree/split/web/simple1.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/simple1.png" /></a> <a href="https://github.com/1aurabrown/ORStackView/tree/split/web/simple2.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/simple2.png" /></a>

```objc
- (void)loadView
{
    self.view = [[ORStackView alloc] init];
}

- (void)viewDidLoad
{
  ORColourView *view1 = [[ORColourView alloc] init];
  view1.text = @"ORStackView - Tap Me";
  view1.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 40};

  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
    initWithTarget:self action:@selector(addView)];
  [view1 addGestureRecognizer:tapGesture];

  ORColourView *view2 = [[ORColourView alloc] init];
  view2.text = @"Subtitle";
  view2.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 20 };

  ORColourView *view3 = [[ORColourView alloc] init];
  view3.text = @"By default, new subviews are added to the bottom of ORStackView.";
  view3.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 100 };

  [self.view addSubview:view1 withTopMargin:@"20" sideMargin:@"30"];
  [self.view addSubview:view2 withTopMargin:@"40" sideMargin:@"70"];
  [self.view addSubview:view3 withTopMargin:@"30" sideMargin:@"20"];
}

- (void)addView
{
  ORColourView *view = [[ORColourView alloc] init];
  view.text = @"Tap to remove";
  view.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 24 };
  [self.view addSubview:view withTopMargin:@"5" sideMargin:@"40"];
}
```



### ORStackView with ordering

If you have views which should only appear once you've got confirmation from an external source, you can add your subviews using `insertSubview:atIndex:withTopMargin:`, `insertSubview:atIndex:withTopMargin:sideMargin:`, `insertSubview:belowSubview:withTopMargin:` or `insertSubview:aboveSubview:withTopMargin:`

In this example, subviews appear in a different order than they are added chronologically. Tapping the first subview adds a new subview to the middle of the stack.

<a href="https://github.com/1aurabrown/ORStackView/tree/split/web/ordered1.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/ordered1.png" /></a> <a href="https://github.com/1aurabrown/ORStackView/tree/split/web/ordered2.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/ordered2.png" /></a>

```objc
- (void)loadView
{
    self.view = [[ORStackView alloc] init];
}

- (void)viewDidLoad
{
  ORColourView *view1 = [[ORColourView alloc] init];
  view1.text = @"1 - ORStackView - Tap Me";
  view1.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 40};
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
    initWithTarget:self action:@selector(addView)];
  [view1 addGestureRecognizer:tapGesture];

  ORColourView *view2 = [[ORColourView alloc] init];
  view2.text = @"2 - You can control the order your ORStackView's subviews";
  view2.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 50 };

  ORColourView *view3 = [[ORColourView alloc] init];
  view3.text = @"3 - Lorem ipsum, etc. etc.";
  view3.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 20 };

  ORColourView *view4 = [[ORColourView alloc] init];
  view4.text = @"4 - Lorem ipsum, etc. etc.";
  view4.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 20 };

  [self.view insertSubview:view2 atIndex:0 withTopMargin:@"20" sideMargin:@"20"];
  [self.view insertSubview:view4 atIndex:1 withTopMargin:@"15" sideMargin:@"20"];
  [self.view insertSubview:view1 atIndex:0 withTopMargin:@"10" sideMargin:@"20"];
  [self.view insertSubview:view3 atIndex:2 withTopMargin:@"10" sideMargin:@"20"];
}

- (void)addView
{
  ORColourView *view = [[ORColourView alloc] init];
  view.text = @"Tap to remove";
  view.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 24 };
  [self.view addSubview:view withTopMargin:@"5" sideMargin:@"40"];
}
```



### ORTagBasedAutoStackView

 Another option is to use ORTagBasedAutoStackView to order your subviews visually in a different order than you will be adding them chronologically. ORTagBasedAutoStackView uses view tags to specify the order in which views will appear from top to bottom. For example these views will be ordered correctly regardless of the insertion order chronologically. Tapping the first view adds a new view with a `tag` of `3` to the middle of the stack.

<a href="https://github.com/1aurabrown/ORStackView/tree/split/web/tagged1.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/tagged1.png" /></a> <a href="https://github.com/1aurabrown/ORStackView/tree/split/web/tagged2.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/tagged2.png" /></a>

```objc
- (void)loadView
{
    self.view = [[ORTagBasedAutoStackView alloc] init];
}

- (void)viewDidLoad
{
  ORColourView *view1 = [[ORColourView alloc] init];
  view1.text = @"Tap Me\ntag = 1";
  view1.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 70};
  view1.tag = 1;

  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
    initWithTarget:self action:@selector(addView)];
  [view1 addGestureRecognizer:tapGesture];

  ORColourView *view2 = [[ORColourView alloc] init];
  view2.text = @"ORTagBasedAutoStackView uses view tags to order your subviews\ntag = 2";
  view2.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 70 };
  view2.tag = 2;

  ORColourView *view4 = [[ORColourView alloc] init];
  view4.text = @"tag = 4";
  view4.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 50 };
  view4.tag = 4;

  ORColourView *view5 = [[ORColourView alloc] init];
  view5.text = @"tag = 5";
  view5.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 60 };
  view5.tag = 5;

  [self.view addSubview:view2 withTopMargin:@"10" sideMargin:@"40"];
  [self.view addSubview:view5 withTopMargin:@"20" sideMargin:@"20"];
  [self.view addSubview:view4 withTopMargin:@"10" sideMargin:@"20"];
  [self.view addSubview:view1 withTopMargin:@"20" sideMargin:@"30"];
}

- (void)addView
{
  if ([[self.view.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tag = 3"]] count] > 0) return;

  ORColourView *view3 = [[ORColourView alloc] init];
  view3.text = @"tap to remove me\ntag = 3";
  view3.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 50 };
  view3.tag = 3;

  [self.view addSubview:view3 withTopMargin:@"20" sideMargin:@"70"];
}
```


### ORSplitStackView

ORSplitStackView is a view containing two ORStackView columns. Add subviews to the `leftStack` and `rightStack` views. ORSplitStackView adjusts its height to fit the taller of the two stack views.

<a href="https://github.com/1aurabrown/ORStackView/tree/split/web/split1.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/split1.png" /></a> <a href="https://github.com/1aurabrown/ORStackView/tree/split/web/split2.png"><img width="360" src="https://raw.githubusercontent.com/1aurabrown/ORStackView/split/web/split2.png" /></a>

```objc
- (void)loadView
{
  self.view = [[UIView alloc] init];
}

- (void)viewDidLoad
{
  ORSplitStackView *splitView = [[ORSplitStackView alloc] initWithLeftPredicate:@"155" rightPredicate:@"130"];
  [self.view addSubview:splitView];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:splitView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
  if ([self respondsToSelector:@selector(topLayoutGuide)]) {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:splitView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
  }

  splitView.backgroundColor = [UIColor purpleColor];
  ORColourView *left1 = [[ORColourView alloc] init];
  left1.text = @"Tap Me";
  left1.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 50};

  ORColourView *right1 = [[ORColourView alloc] init];
  right1.text = @"Tap Me";
  right1.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 60};

  UITapGestureRecognizer *leftGesture = [[UITapGestureRecognizer alloc]
    initWithTarget:self action:@selector(addView:)];
  [left1 addGestureRecognizer:leftGesture];
  UITapGestureRecognizer *rightGesture = [[UITapGestureRecognizer alloc]
    initWithTarget:self action:@selector(addView:)];
  [right1 addGestureRecognizer:rightGesture];

  ORColourView *left2 = [[ORColourView alloc] init];
  left2.text = @"ORSplitStackView is a view containing two stack views.";
  left2.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 90};

  ORColourView *left3 = [[ORColourView alloc] init];
  left3.text = @"ORSplitStackView adjusts its height to fit its content";
  left3.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 75};

  ORColourView *right2 = [[ORColourView alloc] init];
  right2.text = @"a view";
  right2.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 45};

  ORColourView *right3 = [[ORColourView alloc] init];
  right3.text = @"a view";
  right3.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 40};

  [splitView.leftStack addSubview:left1 withTopMargin:@"0" sideMargin:@"10"];
  [splitView.leftStack addSubview:left2 withTopMargin:@"10" sideMargin:@"5"];
  [splitView.leftStack addSubview:left3 withTopMargin:@"10" sideMargin:@"15"];
  [splitView.rightStack addSubview:right1 withTopMargin:@"0" sideMargin:@"15"];
  [splitView.rightStack addSubview:right2 withTopMargin:@"10" sideMargin:@"10"];
  [splitView.rightStack addSubview:right3 withTopMargin:@"10" sideMargin:@"5"];
}

- (void)addView:(UITapGestureRecognizer *)gesture
{
  ORColourView *view = [[ORColourView alloc] init];
  view.text = @"Tap to remove";
  view.fakeContentSize = (CGSize){ UIViewNoIntrinsicMetric , 24 };
  [(ORStackView *)gesture.view.superview addSubview:view withTopMargin:@"5" sideMargin:@"10"];
}
```

## Example Usage

`pod try ORStackView` or to run the example project; clone the repo, and run `pod install` from the Project directory.

## Installation

ORStackView is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

  pod "ORStackView"

## Author

Orta Therox, orta.therox@gmail.com

## License

ORStackView is available under the MIT license. See the LICENSE file for more info.

