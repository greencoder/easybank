//
//  SafeToSpendButton.m
//  BankEasy
//
//  Created by Scott Newman on 3/25/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "SafeToSpendButton.h"
#import <QuartzCore/QuartzCore.h>

@interface SafeToSpendButton ()

@property (nonatomic, strong) UILabel *cashLabel;
@property (nonatomic, strong) UILabel *safeToSpendLabel;

@end

@implementation SafeToSpendButton

- (id)initWithCash:(NSString *)cash
{
    return [self initWithFrame:CGRectZero cash:(NSString *)cash];
}

- (id)initWithFrame:(CGRect)frame cash:(NSString *)cash
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Start with a default size of 100 x 35
        self.frame = CGRectMake(0, 0, 100, 35);
        
        self.backgroundColor = [UIColor colorWithRed:0.33 green:0.51 blue:0.59 alpha:1];
        self.layer.cornerRadius = 6.0;
        
        _cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, self.frame.size.width, 20)];
        _cashLabel.textColor = [UIColor whiteColor];
        _cashLabel.font = [UIFont fontWithName:@"GothamBold" size:14.0];
        _cashLabel.textAlignment = NSTextAlignmentCenter;
        _cashLabel.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _cashLabel.layer.shadowOffset = CGSizeMake(0.5,0.5);
        _cashLabel.layer.shadowRadius = 1.0;
        _cashLabel.layer.shadowOpacity = 0.3;
        
        _cashLabel.text = cash;
        [_cashLabel sizeToFit];
        [self addSubview:_cashLabel];
        
        _safeToSpendLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, self.frame.size.width, 20)];
        _safeToSpendLabel.text = @"Safe-to-Spend";
        _safeToSpendLabel.textAlignment = NSTextAlignmentCenter;
        _safeToSpendLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _safeToSpendLabel.font = [UIFont fontWithName:@"GothamBook" size:9.0];
        
        [_safeToSpendLabel sizeToFit];
        [self addSubview:_safeToSpendLabel];
        
        CGRect newFrame = self.frame;
        if (_cashLabel.frame.size.width + 50.0 > self.frame.size.width) {
            newFrame.size.width = _cashLabel.frame.size.width + 50.0;
            self.frame = newFrame;
        }
        
        _cashLabel.center = CGPointMake(self.frame.size.width/2, _cashLabel.center.y);
        _safeToSpendLabel.center = CGPointMake(self.frame.size.width/2, _safeToSpendLabel.center.y);
        
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
        self.backgroundColor = [UIColor colorWithRed:0.33 green:0.51 blue:0.59 alpha:0.5];
    else
        self.backgroundColor = [UIColor colorWithRed:0.33 green:0.51 blue:0.59 alpha:1];
}

@end
