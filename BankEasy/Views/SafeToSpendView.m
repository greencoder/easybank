//
//  SafeToSpendView.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "SafeToSpendView.h"

@interface SafeToSpendView ()

@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UILabel *scheduledLabel;
@property (nonatomic, strong) UILabel *goalsLabel;
@property (nonatomic, strong) UILabel *safeToSpendLabel;

@end

#define kPaddingLeft 15.0
#define kPaddingRight 15.0
#define kLabelPaddingTop 8.0
#define kLabelFont [UIFont fontWithName:@"GothamMedium2000" size:15.0]
#define kAmountFont [UIFont fontWithName:@"GothamMedium2000" size:16.0f]

@implementation SafeToSpendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Add the tan apper background
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"safe-to-spend-bg.png"]];
        self.backgroundColor = background;
        
        // Add a shadow to the bottom of the view so it looks like it's underneath the table view
        UIImageView *bgShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"safe-to-spend-bg-shadow.png"]];
        bgShadow.frame = CGRectMake(0, self.frame.size.height-4, self.frame.size.width, 4);
        [self addSubview:bgShadow];
        
        // Add the balance label and the balance amount label
        CGRect balanceFrame = CGRectMake(kPaddingLeft, 15, 200, 20);
        _balanceLabel = [[UILabel alloc] initWithFrame:balanceFrame];
        _balanceLabel.font = kLabelFont;
        _balanceLabel.textColor = [UIColor colorWithRed:0.45 green:0.4 blue:0.34 alpha:1];
        _balanceLabel.text = @"Available Balance";
        
        _balanceAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _balanceAmountLabel.font = kAmountFont;
        _balanceAmountLabel.textColor = [UIColor whiteColor];
        _balanceAmountLabel.textAlignment = NSTextAlignmentRight;
        _balanceAmountLabel.text = @"$0000000.00";
        _balanceAmountLabel.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _balanceAmountLabel.layer.shadowOffset = CGSizeMake(0.75,0.75);
        _balanceAmountLabel.layer.shadowRadius = 1.0;
        _balanceAmountLabel.layer.shadowOpacity = 0.6;
        
        // Add the scheduled label and the scheduled amount label
        CGRect scheduledFrame = CGRectMake(kPaddingLeft, balanceFrame.origin.y + balanceFrame.size.height + kLabelPaddingTop, 200, 20);
        _scheduledLabel = [[UILabel alloc] initWithFrame:scheduledFrame];
        _scheduledLabel.font = kLabelFont;
        _scheduledLabel.textColor = [UIColor colorWithRed:0.45 green:0.4 blue:0.34 alpha:1];
        _scheduledLabel.text = @"Scheduled";
        
        _scheduledAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _scheduledAmountLabel.font = kAmountFont;
        _scheduledAmountLabel.textColor = [UIColor whiteColor];
        _scheduledAmountLabel.textAlignment = NSTextAlignmentRight;
        _scheduledAmountLabel.text = @"$0000000.00";
        _scheduledAmountLabel.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _scheduledAmountLabel.layer.shadowOffset = CGSizeMake(0.75,0.75);
        _scheduledAmountLabel.layer.shadowRadius = 1.0;
        _scheduledAmountLabel.layer.shadowOpacity = 0.6;
        
        // Add the goals label and goals amount
        CGRect goalsFrame = CGRectMake(kPaddingLeft, scheduledFrame.origin.y + scheduledFrame.size.height + kLabelPaddingTop, 200, 20);
        _goalsLabel = [[UILabel alloc] initWithFrame:goalsFrame];
        _goalsLabel.font = kLabelFont;
        _goalsLabel.textColor = [UIColor colorWithRed:0.45 green:0.4 blue:0.34 alpha:1];
        _goalsLabel.text = @"Goals";

        _goalsAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _goalsAmountLabel.font = kAmountFont;
        _goalsAmountLabel.textColor = [UIColor whiteColor];
        _goalsAmountLabel.textAlignment = NSTextAlignmentRight;
        _goalsAmountLabel.text = @"$0000000.00";
        _goalsAmountLabel.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _goalsAmountLabel.layer.shadowOffset = CGSizeMake(0.75,0.75);
        _goalsAmountLabel.layer.shadowRadius = 1.0;
        _goalsAmountLabel.layer.shadowOpacity = 0.6;
        
        // Add a view that is just a line to separate
        CGRect lineFrame = CGRectMake(kPaddingLeft, goalsFrame.origin.y + goalsFrame.size.height + kLabelPaddingTop,
                                      self.frame.size.width - (kPaddingLeft * 2), 1);
        UIView *lineView = [[UIView alloc] initWithFrame:lineFrame];
        lineView.backgroundColor = [UIColor colorWithRed:0.45 green:0.4 blue:0.34 alpha:0.3];
        
        // Add the safe to spend label and amount
        CGRect safeSpendFrame = CGRectMake(kPaddingLeft, goalsFrame.origin.y + goalsFrame.size.height + (kLabelPaddingTop*2), 200, 20);
        _safeToSpendLabel = [[UILabel alloc] initWithFrame:safeSpendFrame];
        _safeToSpendLabel.font = kLabelFont;
        _safeToSpendLabel.textColor = [UIColor colorWithRed:0.45 green:0.4 blue:0.34 alpha:1];
        _safeToSpendLabel.text = @"Safe-to-Spend";

        _safeToSpendAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _safeToSpendAmountLabel.font = kAmountFont;
        _safeToSpendAmountLabel.textColor = [UIColor whiteColor];
        _safeToSpendAmountLabel.textAlignment = NSTextAlignmentRight;
        _safeToSpendAmountLabel.text = @"$0000000.00";
        _safeToSpendAmountLabel.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _safeToSpendAmountLabel.layer.shadowOffset = CGSizeMake(0.75,0.75);
        _safeToSpendAmountLabel.layer.shadowRadius = 1.0;
        _safeToSpendAmountLabel.layer.shadowOpacity = 0.6;
        
        // Add all the views as subviews
        [self addSubview:_balanceLabel];
        [self addSubview:_balanceAmountLabel];
        [self addSubview:_scheduledLabel];
        [self addSubview:_scheduledAmountLabel];
        [self addSubview:_goalsLabel];
        [self addSubview:_goalsAmountLabel];
        [self addSubview:lineView];
        [self addSubview:_safeToSpendLabel];
        [self addSubview:_safeToSpendAmountLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The amounts may change after initializing, so resize them
    [_balanceAmountLabel sizeToFit];
    [_scheduledAmountLabel sizeToFit];
    [_goalsAmountLabel sizeToFit];
    [_safeToSpendAmountLabel sizeToFit];
    
    CGRect balanceAmountFrame = _balanceAmountLabel.frame;
    balanceAmountFrame.origin.x = 320.0 - balanceAmountFrame.size.width - kPaddingRight;
    balanceAmountFrame.origin.y = 15.0;
    _balanceAmountLabel.frame = balanceAmountFrame;
    
    CGRect scheduledAmountFrame = _scheduledAmountLabel.frame;
    scheduledAmountFrame.origin.x = 320.0 - scheduledAmountFrame.size.width - kPaddingRight;
    scheduledAmountFrame.origin.y = balanceAmountFrame.origin.y + balanceAmountFrame.size.height + kLabelPaddingTop;
    _scheduledAmountLabel.frame = scheduledAmountFrame;
    
    CGRect goalsAmountFrame = _goalsAmountLabel.frame;
    goalsAmountFrame.origin.x = 320.0 - scheduledAmountFrame.size.width - kPaddingRight;
    goalsAmountFrame.origin.y = scheduledAmountFrame.origin.y + scheduledAmountFrame.size.height + kLabelPaddingTop;
    _goalsAmountLabel.frame = goalsAmountFrame;

    CGRect spendAmountFrame = _safeToSpendAmountLabel.frame;
    spendAmountFrame.origin.x = 320.0 - spendAmountFrame.size.width - kPaddingRight;
    spendAmountFrame.origin.y = goalsAmountFrame.origin.y + goalsAmountFrame.size.height + (kLabelPaddingTop * 2);
    _safeToSpendAmountLabel.frame = spendAmountFrame;
    
}

@end
