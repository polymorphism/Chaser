//
//  TopController.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/19.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterManager.h"
#import "MessageManager.h"
#import "TweetViewController.h"
#import "ViewManager.h"
#import "CacheManager.h"
#import "AppDelegate.h"

@interface TopController : UIViewController {
    TwitterManager *tm;
    ViewManager *vm;
    NSUserDefaults *ud;
    BOOL isSave;
}
@property (weak, nonatomic) IBOutlet UISwitch *chkSave;
@property (weak, nonatomic) IBOutlet UILabel *lblErrorMessage;
@property (weak, nonatomic) IBOutlet UITextField *tbxUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)btnLogin_TouchDown:(id)sender;
- (IBAction)tbxUserName_editOnExit:(id)sender;
- (IBAction)chkSaveChanged:(id)sender;

@end
