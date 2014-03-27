//
//  TransactionManager.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "TransactionManager.h"
#import "Transaction.h"
#import "TXCategory.h"
#import "TXGeo.h"
#import "TXTime.h"
#import "TXAmount.h"

@implementation TransactionManager

+ (NSArray *)loadTransactionsFromJSON:(NSDictionary *)transactionsJSON
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    NSString *jsonFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
//    NSString *originalFilePath = [[NSBundle mainBundle] pathForResource:@"transactions" ofType:@"json"];
//    
//    // If we don't have a transactions.json file in the documents directory, copy one over
//    if (![[NSFileManager defaultManager] fileExistsAtPath:jsonFilePath])
//    {
//        [[NSFileManager defaultManager] copyItemAtPath:originalFilePath toPath:jsonFilePath error:nil];
//    }
//    
//    NSData *JSONData = [NSData dataWithContentsOfFile:jsonFilePath
//                                              options:NSDataReadingMappedIfSafe
//                                                error:nil];
//    
//    NSDictionary *txData = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                           options:NSJSONReadingMutableContainers
//                                                             error:nil];
    
    NSMutableArray *transactions = [[NSMutableArray alloc] initWithCapacity:100];
    
//    for (NSDictionary *txDict in txData[@"transactions"])
    for (NSDictionary *txDict in transactionsJSON[@"transactions"])
    {
        Transaction *transaction = [Transaction new];

        transaction.uuid = txDict[@"uuid"];
        transaction.userID = txDict[@"user_id"];
        transaction.recordType = txDict[@"record_type"];
        transaction.transactionType = txDict[@"transaction_type"];
        transaction.bookkeepingType = txDict[@"bookkeeping_type"];
        transaction.isHold = [txDict[@"is_hold"] boolValue];
        transaction.isActive = [txDict[@"is_active"] boolValue];
        transaction.rawDescription = txDict[@"raw_description"];
        transaction.description = txDict[@"description"];
        
        // The two balances must be formatted
        NSNumber *calcBal = txDict[@"calculated_balance"];
        transaction.calculatedBalance = (calcBal.floatValue > 0) ? @(calcBal.floatValue/10000.0) : @0.00;

        NSNumber *runBal = txDict[@"running_balance"];
        transaction.runningBalance = (runBal.floatValue > 0) ? @(runBal.floatValue/10000.0) : @0.00;
        
        // Get the memo
        transaction.memo = ([txDict objectForKey:@"memo"]) ? txDict[@"memo"] : @"no memo";
        
        // Get the transaction categories
        NSMutableArray *categories = [[NSMutableArray alloc] initWithCapacity:5];
        for (NSDictionary *categoryDict in (NSArray *)txDict[@"categories"])
        {
            TXCategory *txCategory = [TXCategory new];
            txCategory.uuid = categoryDict[@"uuid"];
            txCategory.name = categoryDict[@"name"];
            txCategory.folder = categoryDict[@"folder"];
            [categories addObject:txCategory];
        }
        
        transaction.categories = [NSArray arrayWithArray:categories];
        transaction.primaryCategory = [(TXCategory *)transaction.categories[0] name];

        // Get the transaction geo values
        NSDictionary *geoDict = (NSDictionary *)txDict[@"geo"];

        TXGeo *geo = [TXGeo new];
        geo.sourceID = geoDict[@"source_id"];
        geo.street = geoDict[@"street"];
        geo.city = geoDict[@"city"];
        geo.state = geoDict[@"state"];
        geo.zipCode = geoDict[@"zip"];
        geo.latitude = geoDict[@"lat"];
        geo.longitude = geoDict[@"lon"];
        geo.timeZone = geoDict[@"timezone"];
        
        transaction.geo = geo;

        // Get the transaction times
        NSDictionary *timeDict = (NSDictionary *)txDict[@"times"];
        
        TXTime *time = [TXTime new];
        time.whenRecorded = timeDict[@"when_recorded"];
        time.whenRecordedLocal = timeDict[@"when_recorded_local"];
        time.whenReceived = timeDict[@"when_received"];
        time.lastModified = timeDict[@"last_modified"];
        time.lastTXVia = timeDict[@"last_txvia"];

        // Fix the times
        time.whenRecorded = (time.whenRecorded.floatValue > 0) ? @(time.whenRecorded.floatValue/1000) : @0;
        time.whenRecordedLocal = (time.whenRecordedLocal.floatValue > 0) ? @(time.whenRecordedLocal.floatValue/1000) : @0;
        time.whenReceived = (time.whenReceived.floatValue > 0) ? @(time.whenReceived.floatValue/1000) : @0;
        time.lastModified = (time.lastModified.floatValue > 0) ? @(time.lastModified.floatValue/1000) : @0;
        time.lastTXVia = (time.lastTXVia.floatValue > 0) ? @(time.lastTXVia.floatValue/1000) : @0;

        // Add a formatted day name
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.whenRecorded.integerValue];
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                                                  fromDate:date];
        NSDate *day = [[NSCalendar currentCalendar] dateFromComponents:comps];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterFullStyle;
        
        transaction.times = time;
        transaction.sortTime = time.whenRecorded;
        transaction.formattedDay = [formatter stringFromDate:day];
        
        // Get the transaction amounts
        NSDictionary *amountDict = (NSDictionary *)txDict[@"amounts"];
        
        TXAmount *amount = [TXAmount new];
        amount.amount = amountDict[@"amount"];
        amount.cleared = amountDict[@"cleared"];
        amount.fees = amountDict[@"fees"];
        amount.cashback = amountDict[@"cashback"];
        amount.base = amountDict[@"base"];
        
        // Fix the amounts
        amount.amount = (amount.amount.floatValue > 0) ? @(amount.amount.floatValue/10000.0) : @0.00;
        amount.cleared = (amount.cleared.floatValue > 0) ? @(amount.cleared.floatValue/10000.0) : @0.00;
        amount.fees = (amount.fees.floatValue > 0) ? @(amount.fees.floatValue/10000.0) : @0.00;
        amount.cashback = (amount.cashback.floatValue > 0) ? @(amount.cashback.floatValue/10000.0) : @0.00;
        amount.base = (amount.base.floatValue > 0) ? @(amount.base.floatValue/10000.0) : @0.00;

        // Create a formatted amount by adding a "+" in front of credits and using 2 decimal places
        if ([transaction.bookkeepingType isEqualToString:@"credit"])
            amount.formattedAmount = [NSString stringWithFormat:@"+%.2f", amount.amount.doubleValue];
        else
            amount.formattedAmount = [NSString stringWithFormat:@"%.2f", amount.amount.doubleValue];
        
        transaction.amounts = amount;
        
        [transactions addObject:transaction];
    }
    
    // Sort the issue sections
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"sortTime" ascending:NO];
    [transactions sortUsingDescriptors:@[sort]];
    
    // Now that we have sorted transactions, go through them one by one and group them into
    // individual arrays by date
    NSMutableArray *groupedTransactions = [[NSMutableArray alloc] init];
    NSString *lastDay = nil;
    
    for (int index=0; index<transactions.count; index++)
    {
        Transaction *transaction = (Transaction *)transactions[index];
        if (![transaction.formattedDay isEqualToString:lastDay])
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"formattedDay == %@", transaction.formattedDay];
            NSArray *transactionsForDay = [transactions filteredArrayUsingPredicate:predicate];
            [groupedTransactions addObject:transactionsForDay];
            lastDay = transaction.formattedDay;
        }
    }
    
    return [NSArray arrayWithArray:groupedTransactions];
}


@end
