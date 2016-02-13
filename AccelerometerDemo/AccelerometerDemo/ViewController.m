//
//  ViewController.m
//  AccelerometerDemo
//
//  Created by Arthur Knopper on 1/29/13.
//  Copyright (c) 2013 Arthur Knopper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) IBOutlet UILabel *xAxis;
@property (nonatomic, strong) IBOutlet UILabel *yAxis;
@property (nonatomic, strong) IBOutlet UILabel *zAxis;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.xAxis.text = @"bla";
	
    self.motionManager = [[CMMotionManager alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = 1;
    
    if ([self.motionManager isAccelerometerAvailable])// & [self.motionManager isAccelerometerActive])
    {
        NSLog(@"Accelerometer is active and available");
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        
        {
            NSLog(@"X = %0.4f, Y = %.04f, Z = %.04f",
                  accelerometerData.acceleration.x,
                  accelerometerData.acceleration.y,
                  accelerometerData.acceleration.z);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.xAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.x];
                self.yAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.y];
                self.zAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.z];
            });
        }];
    }
    else
        NSLog(@"not active");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
