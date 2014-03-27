//
//  SafeToSpendView.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeToSpendView : UIView

@property (nonatomic, strong) UILabel *balanceAmountLabel;
@property (nonatomic, strong) UILabel *scheduledAmountLabel;
@property (nonatomic, strong) UILabel *goalsAmountLabel;
@property (nonatomic, strong) UILabel *safeToSpendAmountLabel;

@end
