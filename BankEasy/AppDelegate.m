//
//  AppDelegate.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "AppDelegate.h"
#import "ActivityViewController.h"
#import "PaymentsViewController.h"
#import "GoalsViewController.h"
#import "SupportViewController.h"
#import "AccountViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    ActivityViewController *activityVC = [[ActivityViewController alloc] init];
    UINavigationController *activityNav = [[UINavigationController alloc] initWithRootViewController:activityVC];
    
    PaymentsViewController *paymentsVC = [[PaymentsViewController alloc] init];
    UINavigationController *paymentsNav = [[UINavigationController alloc] initWithRootViewController:paymentsVC];
    
    GoalsViewController *goalsVC = [[GoalsViewController alloc] init];
    UINavigationController *goalsNav = [[UINavigationController alloc] initWithRootViewController:goalsVC];
    
    SupportViewController *supportVC = [[SupportViewController alloc] init];
    UINavigationController *supportNav = [[UINavigationController alloc] initWithRootViewController:supportVC];
    
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    UINavigationController *accountNav = [[UINavigationController alloc] initWithRootViewController:accountVC];
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[activityNav, paymentsNav, goalsNav, supportNav, accountNav];
    
    tabController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg.png"];
    tabController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"selectedTabBG.png"];
    
    self.window.rootViewController = tabController;
    self.window.backgroundColor = [UIColor whiteColor];

    [self customizeAppearance];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)customizeAppearance
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.2 green:0.42 blue:0.51 alpha:1]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];

    [[UINavigationBar appearance] setTitleTextAttributes: @{
        NSFontAttributeName: [UIFont fontWithName:@"GothamBold" size:18.0],
    }];
    
}

@end
