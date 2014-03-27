//
//  ActivityCell.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "ActivityCell.h"

#define kCellFontPayee [UIFont fontWithName:@"GothamMedium2000" size:16.0f]
#define kCellFontMemo [UIFont fontWithName:@"SentinelLight" size:14.0f]
#define kCellFontAmount [UIFont fontWithName:@"GothamMedium2000" size:16.0f]
#define kCellFontCategory [UIFont fontWithName:@"GothamBook" size:10.0f]

#define kCellWidth 320.0
#define kCellPaddingLeft 15.0
#define kCellPaddingRight 15.0
#define kCellPaddingTop 12.0
#define kCellPaddingBottom 12.0
#define kMemoLabelTopPadding 8.0
#define kAmountLabelTopPadding 8.0

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _payeeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _payeeLabel.font = kCellFontPayee;
        _payeeLabel.textColor = [UIColor colorWithRed:0.18 green:0.45 blue:0.55 alpha:1];
        
        _memoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _memoLabel.font = kCellFontMemo;
        _memoLabel.textColor = [UIColor darkGrayColor];
        
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLabel.font = kCellFontAmount;
        _amountLabel.textColor = [UIColor colorWithRed:0.42 green:0.74 blue:0.35 alpha:1];

        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _categoryLabel.font = kCellFontCategory;
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        _categoryLabel.textColor = [UIColor colorWithRed:0.4 green:0.49 blue:0.53 alpha:1];
        
        [[self contentView] addSubview:_payeeLabel];
        [[self contentView] addSubview:_memoLabel];
        [[self contentView] addSubview:_amountLabel];
        [[self contentView] addSubview:_categoryLabel];

        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self setSelectedBackgroundView:backgroundView];
        
    }
    return self;
}

+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font constraint:(CGSize)constraintSize
{
    CGRect rect = [text boundingRectWithSize:constraintSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size;
}

+ (CGFloat)heightForCellWithPayee:(NSString *)payee memo:(NSString *)memo;
{
    CGSize payeeConstraintSize = CGSizeMake(225.0, 30.0);
    CGSize memoConstraintSize = CGSizeMake(225.0, 30.0);
    
    CGSize payeeSize = [self.class sizeForText:payee withFont:kCellFontPayee constraint:payeeConstraintSize];
    CGSize memoSize = [self.class sizeForText:memo withFont:kCellFontMemo constraint:memoConstraintSize];
    
    return kCellPaddingTop + payeeSize.height + kMemoLabelTopPadding + memoSize.height + kCellPaddingBottom;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize constraintSize = CGSizeMake(kCellWidth - (kCellPaddingLeft + kCellPaddingRight), 2000.0f);
    CGSize payeeConstraintSize = CGSizeMake(225.0, 30.0);
    CGSize memoConstraintSize = CGSizeMake(225.0, 30.0);
    
    CGSize payeeSize = [self.class sizeForText:_payeeLabel.text withFont:kCellFontPayee constraint:payeeConstraintSize];
    CGSize memoSize = [self.class sizeForText:_memoLabel.text withFont:kCellFontMemo constraint:memoConstraintSize];
    CGSize amountSize = [self.class sizeForText:_amountLabel.text withFont:kCellFontAmount constraint:constraintSize];
    CGSize categorySize = [self.class sizeForText:_categoryLabel.text withFont:kCellFontCategory constraint:constraintSize];
    
    CGRect payeeFrame = _payeeLabel.frame;
    payeeFrame.size.height = payeeSize.height;
    payeeFrame.size.width = payeeSize.width;
    payeeFrame.origin.x = kCellPaddingLeft;
    payeeFrame.origin.y = kCellPaddingTop;
    _payeeLabel.frame = payeeFrame;
    
    CGRect memoFrame = _memoLabel.frame;
    memoFrame.size.height = memoSize.height;
    memoFrame.size.width = memoSize.width;
    memoFrame.origin.x = kCellPaddingLeft;
    memoFrame.origin.y = payeeFrame.origin.y + payeeFrame.size.height + kMemoLabelTopPadding;
    _memoLabel.frame = memoFrame;
    
    CGRect amountFrame = _amountLabel.frame;
    amountFrame.size.height = amountSize.height;
    amountFrame.size.width = amountSize.width;
    amountFrame.origin.x = kCellWidth - amountSize.width - kCellPaddingRight;
    amountFrame.origin.y = kCellPaddingTop;
    _amountLabel.frame = amountFrame;

    // Add a rounded border around the category label
    _categoryLabel.layer.borderColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:0.8].CGColor;
    _categoryLabel.layer.borderWidth = 1.0;
    _categoryLabel.layer.cornerRadius = 7.0;
    
    CGRect categoryFrame = _categoryLabel.frame;
    categoryFrame.size.height = categorySize.height + 5;
    categoryFrame.size.width = categorySize.width + 12;
    categoryFrame.origin.x = kCellWidth - categorySize.width - 10.0 - kCellPaddingRight;
    categoryFrame.origin.y = amountFrame.origin.y + amountFrame.size.height + kAmountLabelTopPadding + 1.0;
    _categoryLabel.frame = categoryFrame;

    
    // If the memo is "no memo", show it in light gray
    if ([_memoLabel.text isEqualToString:@"no memo"])
        _memoLabel.textColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1];
    else
        _memoLabel.textColor = [UIColor darkGrayColor];
    
    // Color the amount red or green depending on type
    if ([_amountLabel.text hasPrefix:@"+"])
        // Credits are green
        _amountLabel.textColor = [UIColor colorWithRed:0.35 green:0.65 blue:0.33 alpha:1];
    else
        // Debits are red
        _amountLabel.textColor = [UIColor colorWithRed:0.95 green:0.34 blue:0.35 alpha:1];
    
}


@end
