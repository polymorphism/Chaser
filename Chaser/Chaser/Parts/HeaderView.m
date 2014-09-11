//
//  HeaderView.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/25.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "HeaderView.h"


@implementation HeaderView
@synthesize textLabel_EN, textLabel_JP, imageView, activityIndicatorView;
@synthesize state = state_;
@synthesize hoge = _hoge;

- (void)awakeFromNib
{
    self.state = HeaderViewStateHidden;
//    [self setUpdatedDate:nil];
}

#pragma mark -
#pragma mark Properties

//
// arrow_up.png
// http://www.iconfinder.com/icondetails/22742/48/arrow_up_icon
//
// author: Kyo Tux
// url   :http://kyo-tux.deviantart.com/
//

- (void)_animateImageForHeadingUp:(BOOL)headingUp
{
    CGFloat startAngle = headingUp ? 0 : M_PI + 0.00001;
    CGFloat endAngle = headingUp ? M_PI + 0.00001 : 0;
    
    self.imageView.transform = CGAffineTransformMakeRotation(startAngle);
    
    // (A) no blocks
    /*
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationDuration:0.2];
     self.imageView.transform =
     CGAffineTransformMakeRotation(endAngle);
     NSLog(@"%s|%@", __PRETTY_FUNCTION__, [NSThread callStackSymbols]);
     [UIView commitAnimations];
     
     // (B) blocks
     [UIView animateWithDuration:0.2
     animations:^{
     NSLog(@"%s|%@", __PRETTY_FUNCTION__, [NSThread callStackSymbols]);
     self.imageView.transform =
     CGAffineTransformMakeRotation(endAngle);
     }];
     */
    // (B') blocks with UIViewAnimationOptionAllowUserInteraction
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.imageView.transform =
                         CGAffineTransformMakeRotation(endAngle);
                         
                     }
                     completion:NULL
     ];
}

- (void)setState:(HeaderViewState)state
{
    switch (state) {
        case HeaderViewStateHidden:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = YES;
            self.activityIndicatorView.hidden = YES;
            break;
            
        case HeaderViewStatePullingDown:
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.hidden = YES;
            self.imageView.hidden = NO;
            self.textLabel_EN.text = @"PullDown...";
            self.textLabel_JP.text = @"引き下げて...";
            if (state_ != HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:NO];
            }
            break;
            
        case HeaderViewStateOveredThreshold:
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.hidden = YES;
            self.imageView.hidden = NO;
            self.textLabel_EN.text = @"release";
            self.textLabel_JP.text = @"指をはなして更新";
            if (state_ == HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:YES];
            }
            break;
            
        case HeaderViewStateStopping:
            [self.activityIndicatorView startAnimating];
            self.activityIndicatorView.hidden = NO;
            self.textLabel_EN.text = @"Now Loading...";
            self.textLabel_JP.text = @"更新中...";
            self.imageView.hidden = YES;
            break;
    }
    
    state_ = state;
}

@end
