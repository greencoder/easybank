//
//  SafeToSpendHeader.h
//  BankEasy
//
//  Created by Scott Newman on 3/26/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeToSpendHeader : UIButton

@property (nonatomic, strong) UILabel *cashLabel;

- (id)initWithCash:(NSString *)cash;

@end
