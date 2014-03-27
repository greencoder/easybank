//
//  LoadingDataView.m
//  BankEasy
//
//  Created by Scott Newman on 3/26/14.
//  Copyright (c) 2014 Scott Newman. All rights reserved.
//

#import "LoadingDataView.h"

@implementation LoadingDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = YES;
        
        UIImageView *spinner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small_logo_colored.png"]];
        spinner.center = self.center;
        
        CGRect spinnerFrame = spinner.frame;
        spinnerFrame.origin.y = 60.0;
        spinner.frame = spinnerFrame;
        
        [self addSubview:spinner];
        
        [UIView animateWithDuration:1.0f
                              delay:0.0f
                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             spinner.transform = CGAffineTransformRotate(spinner.transform, M_PI / 2);
                         }
                         completion: nil];
        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        loadingLabel.text = @"Loading Transactions";
        loadingLabel.textColor = [UIColor lightGrayColor];
        loadingLabel.font = [UIFont fontWithName:@"GothamBook" size:16.0];
        [loadingLabel sizeToFit];
        loadingLabel.center = self.center;
        
        CGRect labelFrame = loadingLabel.frame;
        labelFrame.origin.y = 105.0;
        loadingLabel.frame = labelFrame;
        
        [self addSubview:loadingLabel];
    }
    return self;
}

@end
