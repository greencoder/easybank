//
//  SimpleAPIClient.h
//  BankEasy
//
//  Created by Scott Newman on 3/26/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SimpleAPIClient : AFHTTPSessionManager

+ (SimpleAPIClient *)sharedClient;
- (NSURLSessionDataTask *)getTransactionsWithCompletion:(void(^)(NSDictionary *transactionDict, NSError *error))completion;

@end
