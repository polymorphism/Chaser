//
//  ViewManager.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/24.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "ViewManager.h"

@implementation ViewManager


-(void) init : (UIViewController *) controller{
    
    _loadingMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, controller.view.frame.size.width, controller.view.frame.size.height)];
    
    _loadingLabel.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
    
    _loadingLabel = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 120, 120)];
    
    _loadingLabel.layer.cornerRadius = 15;
    _loadingLabel.opaque = NO;
    _loadingLabel.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    
    UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 81, 22)];
    
    loadLabel.text = @"Loading";
    loadLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    loadLabel.textAlignment = NSTextAlignmentCenter;
    loadLabel.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    loadLabel.backgroundColor = [UIColor clearColor];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    
    
    _loadingLabel.frame = CGRectMake(controller.view.frame.size.width / 2 - _loadingLabel.frame.size.width / 2,
                                     controller.view.frame.size.height / 2 - _loadingLabel.frame.size.height / 2,
                                     _loadingLabel.frame.size.width,
                                     _loadingLabel.frame.size.height);
    
    _indicator.frame = CGRectMake(_loadingLabel.frame.size.width / 2 - _indicator.frame.size.width / 2,
                                  _loadingLabel.frame.size.height / 2 - _indicator.frame.size.height / 2 + 10,
                                  _indicator.frame.size.width,
                                  _indicator.frame.size.height);
    
    
    [_loadingLabel addSubview:loadLabel];
    [_loadingLabel addSubview:_indicator];
    
    // サブビューに追加する
    _loadingLabel.hidden = true;
    _loadingMask.hidden = true;
    [controller.view addSubview:_loadingLabel];
    [controller.view addSubview:_loadingMask];
    
    
}


-(void) StartIndicatorAnimate {
    
    // くるくるを表示
    _loadingLabel.hidden = false;
    _loadingMask.hidden = false;
    [_indicator startAnimating];
}

-(void)StopIndicatorAnimate {
    
    if (_indicator.isAnimating) { // yes
        // くるくるを止める
        _loadingLabel.hidden = true;
        _loadingMask.hidden = true;
        [_indicator stopAnimating];
        _indicator.hidesWhenStopped = YES;
        
    }
}

@end
