//
//  PaymentsViewController.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "PaymentsViewController.h"
#import "SafeToSpendButton.h"

@interface PaymentsViewController ()

@end

@implementation PaymentsViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tabBarItem.image = [[UIImage imageNamed:@"tab-bar-icon-payments.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
        self.navigationItem.title = @"Payments";
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;

}

@end
