//
//  ActivityCell.h
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property (nonatomic, strong) UILabel *payeeLabel;
@property (nonatomic, strong) UILabel *memoLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *categoryLabel;

+ (CGFloat)heightForCellWithPayee:(NSString *)payee memo:(NSString *)memo;
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font constraint:(CGSize)constraintSize;

@end