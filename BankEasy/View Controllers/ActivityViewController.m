//
//  TransactionsViewController.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "ActivityViewController.h"
#import "SafeToSpendHeader.h"
#import "SafeToSpendView.h"
#import "ActivityCell.h"
#import "TransactionManager.h"
#import "Transaction.h"
#import "SimpleAPIClient.h"
#import "LoadingDataView.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationController.navigationBar.translucent = NO;
        
        // This has to be added in init so the tab bar controller can pick it up
        self.tabBarItem.image = [[UIImage imageNamed:@"tab-bar-icon-activity.png"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        // This will move down the tab bar images
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);

        // Add button to top bar
        SafeToSpendHeader *button = [[SafeToSpendHeader alloc] initWithCash:@"$0000000.00"];
        [button addTarget:self action:@selector(toggleSafeToSpend:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = button;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationController.title = @"Safe to Spend";
    
    // Add the safe to spend view below the table view
    _safeToSpendView = [[SafeToSpendView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140.0)];
    [self.view addSubview:_safeToSpendView];

    // If they tap the safe to spend view, it will close the drawer
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSafeToSpend:)];
    [_safeToSpendView addGestureRecognizer:tapGestureRecognizer];

    // Add the table view
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.98 alpha:1];
    [self.view addSubview:_tableView];
    
    // Register the @"Cell" with the table view
    [_tableView registerClass:[ActivityCell class] forCellReuseIdentifier:@"Cell"];

    // Add a refresh control to the table
    _refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    // Add a loading view and hide it until we start loading data
    _loadingView = [[LoadingDataView alloc] initWithFrame:self.view.frame];
    _loadingView.hidden = YES;
    [self.view insertSubview:_loadingView aboveSubview:self.tableView];
    
    // Load the transactions from the API
    self.loadingView.hidden = NO;
    self.navigationItem.titleView.hidden = YES;
    
    [self loadData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Adjust the table view frame before the view appears but after load so
    // that it takes into account the nav and tab bars
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.view.frame.size.height;
    self.tableView.frame = tableFrame;

    CGRect loadingFrame = self.loadingView.frame;
    loadingFrame.size.height = self.view.frame.size.height;
    self.loadingView.frame = loadingFrame;
}

#pragma mark table view data source protocol

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 26)];
    view.backgroundColor = [UIColor colorWithRed:0.98 green:0.99 blue:1 alpha:1];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
    topLine.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.98 alpha:1];
    [view addSubview:topLine];

    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, tableView.frame.size.width, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.98 alpha:1];
    [view addSubview:bottomLine];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, tableView.frame.size.width, 18)];
    label.font = [UIFont fontWithName:@"GothamBook" size:13.0];
    label.textColor = [UIColor darkGrayColor];
    
    Transaction *transaction = [self.transactions[section] firstObject];
    label.text = transaction.formattedDay;
                                            
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 26.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Transaction *transaction = self.transactions[indexPath.section][indexPath.row];
    return [ActivityCell heightForCellWithPayee:transaction.description memo:transaction.memo];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.transactions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)self.transactions[section] count];
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Transaction *transaction = self.transactions[indexPath.section][indexPath.row];
    
    cell.payeeLabel.text = transaction.description;
    cell.amountLabel.text = transaction.amounts.formattedAmount;
    cell.memoLabel.text = transaction.memo;
    cell.categoryLabel.text = transaction.primaryCategory;
    
    return cell;
}

#pragma mark User interaction methods

- (void)toggleSafeToSpend:(id)sender
{
    CGRect tableFrame = self.tableView.frame;
    
    if (tableFrame.origin.y == 0)
    {
        tableFrame.origin.y += 140.0;
        tableFrame.size.height -= 140.0;
    }
    else
    {
        tableFrame.origin.y = 0;
        tableFrame.size.height += 140.0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.frame = tableFrame;
    }];
    
}

- (void)updateSafeToSpend:(Transaction *)transaction
{
    SafeToSpendHeader *safeHeader = (SafeToSpendHeader *)self.navigationItem.titleView;
    safeHeader.cashLabel.text = [NSString stringWithFormat:@"$%@", transaction.calculatedBalance];
    [safeHeader setNeedsLayout];
    [safeHeader setNeedsDisplay];
    
    _safeToSpendView.balanceAmountLabel.text = [NSString stringWithFormat:@"$%@", transaction.runningBalance];
    _safeToSpendView.goalsAmountLabel.text = @"$0.00";
    _safeToSpendView.scheduledAmountLabel.text = @"$0.00";
    _safeToSpendView.safeToSpendAmountLabel.text = [NSString stringWithFormat:@"$%@", transaction.calculatedBalance];
    [_safeToSpendView setNeedsLayout];
}

- (void)loadData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[SimpleAPIClient sharedClient] getTransactionsWithCompletion:^(NSDictionary *transactionsJSON, NSError *error)
     {
         if (error)
             NSLog(@"Error: %@", error);

         if (!self.loadingView.hidden)
         {
             [UIView animateWithDuration:0.5 animations:^{
                 self.loadingView.alpha = 0.0;
             } completion:^(BOOL finished) {
                 self.loadingView.hidden = YES;
                 self.loadingView.alpha = 1.0;
             }];
         }

         // Set all the UI back on
         [self.refreshControl endRefreshing];
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

         _transactions = [TransactionManager loadTransactionsFromJSON:transactionsJSON];
         [self updateSafeToSpend:_transactions.firstObject[0]];
         self.navigationItem.titleView.hidden = NO;
         
         [self.tableView reloadData];
     }];
}

@end
