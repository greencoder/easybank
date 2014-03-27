//
//  Transaction.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXAmount.h"

@class TXGeo;
@class TXTime;

@interface Transaction : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *recordType;
@property (nonatomic, strong) NSString *transactionType;
@property (nonatomic, strong) NSString *bookkeepingType;
@property (nonatomic, assign) BOOL isHold;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) NSNumber *runningBalance;
@property (nonatomic, strong) NSString *rawDescription;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *primaryCategory;
@property (nonatomic, strong) TXGeo *geo;
@property (nonatomic, strong) TXTime *times;
@property (nonatomic, strong) TXAmount *amounts;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSNumber *calculatedBalance;
@property (nonatomic, strong) NSNumber *sortTime;
@property (nonatomic, strong) NSString *formattedDay;

@end
