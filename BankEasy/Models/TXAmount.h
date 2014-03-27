//
//  TXAmount.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXAmount : NSObject

@property (nonatomic, strong) NSString *formattedAmount;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *cleared;
@property (nonatomic, strong) NSNumber *fees;
@property (nonatomic, strong) NSNumber *cashback;
@property (nonatomic, strong) NSNumber *base;

@end
