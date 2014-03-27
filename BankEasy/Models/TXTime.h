//
//  TXTime.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXTime : NSObject

@property (nonatomic, strong) NSNumber *whenRecorded;
@property (nonatomic, strong) NSNumber *whenRecordedLocal;
@property (nonatomic, strong) NSNumber *whenReceived;
@property (nonatomic, strong) NSNumber *lastModified;
@property (nonatomic, strong) NSNumber *lastTXVia;

@end
