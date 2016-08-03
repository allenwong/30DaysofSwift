//
//  ORStackViewController.m
//  Pods
//
//  Created by Dzianis Lebedzeu on 5/5/15.
//
//

#import "ORStackViewController.h"

@implementation ORStackViewController

- (void)loadView {
    self.view = [[ORStackScrollView alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0);
}

- (ORStackScrollView *)scrollView {
    return (ORStackScrollView *)self.view;
}

- (ORStackView *)stackView {
    return self.scrollView.stackView;
}

@end
