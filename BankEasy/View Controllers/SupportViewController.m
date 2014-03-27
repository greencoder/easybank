//
//  SupportViewController.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()

@end

@implementation SupportViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tabBarItem.image = [[UIImage imageNamed:@"tab-bar-icon-support.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
        self.navigationItem.title = @"Support";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

}

@end
