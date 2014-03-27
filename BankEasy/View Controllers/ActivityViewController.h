//
//  TransactionsViewController.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadingDataView;
@class SafeToSpendView;

@interface ActivityViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *transactions;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) LoadingDataView *loadingView;
@property (nonatomic, strong) SafeToSpendView *safeToSpendView;

@end
