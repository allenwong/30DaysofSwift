//
//  ViewController.m
//  ActionSheetDemo
//
//  Created by Arthur Knopper on 30/10/12.
//  Copyright (c) 2012 iOSCreator. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UILabel *rateLabel;

- (IBAction)displayActionSheet:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayActionSheet:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Title"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Rate 1 Star", @"Rate 2 Stars",
                                  @"Rate 3 Starts", @"Rate 4 Stars", @"Rate 5 Stars", nil];

    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];

}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.rateLabel.text = @"You've rated 1 star.";
            break;
        case 1:
            self.rateLabel.text = @"You've rated 2 stars.";
            break;
        case 2:
            self.rateLabel.text = @"You've rated 3 stars.";
            break;
        case 3:
            self.rateLabel.text = @"You've rated 4 stars.";
            break;
        case 4:
            self.rateLabel.text = @"You've rated 5 stars.";
            break;
        case 5:
            self.rateLabel.text = @"You haven't rate this app yet.";
            break;
    }

}

@end
