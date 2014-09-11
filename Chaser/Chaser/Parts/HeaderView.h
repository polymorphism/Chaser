//
//  HeaderView.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/25.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HeaderViewStateHidden = 0,
    HeaderViewStatePullingDown,
    HeaderViewStateOveredThreshold,
    HeaderViewStateStopping
} HeaderViewState;

@interface HeaderView : UIView {
    
}

@property (nonatomic, retain) IBOutlet UILabel* textLabel_EN;
@property (nonatomic, retain) IBOutlet UILabel* textLabel_JP;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicatorView;

@property (nonatomic, assign) HeaderViewState state;

@property NSString *hoge;

@end
