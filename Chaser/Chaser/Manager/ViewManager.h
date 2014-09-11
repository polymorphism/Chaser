//
//  ViewManager.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/24.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewManager : NSObject{
    UIActivityIndicatorView *_indicator;
    UIView *_loadingLabel;
    UIView *_loadingMask;
    UIViewController *_controller;
}

- (void) init : (UIViewController *) controller;

- (void) StartIndicatorAnimate;

- (void) StopIndicatorAnimate;

@end
