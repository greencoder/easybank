//
//  SafeToSpendHeader.m
//  BankEasy
//
//  Created by Scott Newman on 3/26/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "SafeToSpendHeader.h"
#import <QuartzCore/QuartzCore.h>

@interface SafeToSpendHeader ()

@property (nonatomic, strong) UILabel *safeLabel;
@property (nonatomic, strong) UIView *roundedView;

@end

@implementation SafeToSpendHeader

- (id)initWithCash:(NSString *)cash
{
    return [self initWithFrame:CGRectZero cash:(NSString *)cash];
}

- (id)initWithFrame:(CGRect)frame cash:(NSString *)cash
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Start with a default size of 320 x 35
        self.frame = CGRectMake(0, 0, 320, 30);
        
        // First, add a label for the cash amount
        _cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
        _cashLabel.textColor = [UIColor whiteColor];
        _cashLabel.font = [UIFont fontWithName:@"GothamBold" size:18.0];
        _cashLabel.textAlignment = NSTextAlignmentCenter;
        _cashLabel.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _cashLabel.layer.shadowOffset = CGSizeMake(0.5,0.5);
        _cashLabel.layer.shadowRadius = 1.0;
        _cashLabel.layer.shadowOpacity = 0.3;
        _cashLabel.text = cash;
        [self addSubview:_cashLabel];
        
        // Next, add a label for the Safe-to-Spend text
        _safeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _safeLabel.font = [UIFont fontWithName:@"GothamLight" size:15.0];
        _safeLabel.textColor = [UIColor whiteColor];
        _safeLabel.text = @"Safe-to-Spend™";
        [self addSubview:_safeLabel];
        
        // Next, put a rounded rect under the cash
        _roundedView = [[UIView alloc] initWithFrame:CGRectZero];
        _roundedView.backgroundColor = [UIColor colorWithRed:0.33 green:0.51 blue:0.59 alpha:1];
        _roundedView.layer.cornerRadius = 5.0;
        _roundedView.userInteractionEnabled = NO;
        [self insertSubview:_roundedView belowSubview:_cashLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // The text may have changed, so we need to check size
    [_cashLabel sizeToFit];
    [_safeLabel sizeToFit];

    // Make sure the rounded frame is relative to the cash label
    CGRect roundedFrame = _cashLabel.frame;
    roundedFrame.size.width += 20.0;
    roundedFrame.size.height += 5.0;
    roundedFrame.origin.y = 0.0;
    roundedFrame.origin.x = 0.0;
    _roundedView.frame = roundedFrame;
    
    // Move the cash label to the center of the rounded rect
    _cashLabel.center = _roundedView.center;
    
    // Move the Safe-to-Spend label to the right of the cash label
    CGRect safeFrame = _safeLabel.frame;
    safeFrame.origin.x = roundedFrame.origin.x + roundedFrame.size.width + 10.0;
    safeFrame.origin.y = 5.0;
    _safeLabel.frame = safeFrame;
    
    // Finally, fix the frame
    CGRect newFrame = self.frame;
    newFrame.size.width = _roundedView.frame.size.width + 10.0 + _safeLabel.frame.size.width;
    newFrame.size.height = _roundedView.frame.size.height;
    self.frame = newFrame;
}

@end
