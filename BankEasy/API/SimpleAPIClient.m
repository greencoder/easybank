//
//  SimpleAPIClient.m
//  BankEasy
//
//  Created by Scott Newman on 3/26/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "SimpleAPIClient.h"

@implementation SimpleAPIClient

+ (SimpleAPIClient *)sharedClient
{
    static SimpleAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
#ifdef DEBUG_WEB
        NSURL *baseURL = [NSURL URLWithString:@"http://192.168.1.139:5000"];
#else
        NSURL *baseURL = [NSURL URLWithString:@"http://demos.greencoder.com"];
#endif
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"User-Agent": @"BankEasy iOS App"}];
        _sharedClient = [[SimpleAPIClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json",nil];
    });
    return _sharedClient;
}

- (NSURLSessionDataTask *)getTransactionsWithCompletion:(void(^)(NSDictionary *transactionDict, NSError *error))completion
{
    // Need to tell it text/plain is okay
    
    NSURLSessionDataTask *task = [self POST:@"/export/transactions"
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200)
                                       {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               NSDictionary *transactionDict = responseObject;
                                               completion(transactionDict, nil);
                                           });
                                       }
                                       else
                                       {
                                           // We didn't get a 200
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                       }
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error)
                                   {
                                      // The server request didn't work
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          completion(nil, error);
                                      });
                                   }];
    return task;
    
}

@end
