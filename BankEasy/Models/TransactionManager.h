//
//  TransactionManager.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionManager : NSObject

+ (NSArray *)loadTransactionsFromJSON:(NSDictionary *)transactionsJSON;

@end
