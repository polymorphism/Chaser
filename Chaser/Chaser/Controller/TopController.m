//
//  TopController.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/19.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "TopController.h"

@implementation TopController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    vm = [ViewManager alloc];
    [vm init:self];
    
    isSave = false;
    ud = [NSUserDefaults standardUserDefaults];
    if([ud objectForKey:@"userName"] != nil){
        // 保存データあり
        _tbxUserName.text = [ud stringForKey:@"userName"];
        // 保存データがある場合は常にON
        [_chkSave setOn:YES];
        isSave = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnLogin_TouchDown:(id)sender {
    
    _lblErrorMessage.hidden = true;
    _lblErrorMessage.text = @"";
    
    NSLog (@"%@",_tbxUserName.text);
    
    tm = [[TwitterManager alloc] init];
    
    tm.userName = _tbxUserName.text;
    
    // AppDelegateにTMを追加
    AppDelegate *ap = APP_DELEGATE;
    ap.twitterManager = tm;
    // cahceManagerもついでに
    CacheManager *cm = [[CacheManager alloc] init];
    ap.cacheManager = cm;
    
    // くるくる開始
    [vm StartIndicatorAnimate];
    
    [tm HasTwitterAccount:^(BOOL isFound) {
        
        // くるくる解除
        [vm StopIndicatorAnimate];
        
        if(!isFound){
            MessageManager *mm = [[MessageManager alloc] init];
            _lblErrorMessage.hidden = false;
            _lblErrorMessage.text = [NSString stringWithFormat: [mm GetMessage:@"INPUT_NOTFOUND" :INFO] , @"TwitterのユーザID"];
        }else{
            // 成功
            NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
            if(isSave){
                [defaults setObject:@"" forKey:@"userName"];
                [ud registerDefaults:defaults];
                [ud setObject:_tbxUserName.text forKey:@"userName"];
            }else{
                // 保存せず削除
                [ud removeObjectForKey:@"userName"];
            }
            [ud synchronize];
            
            
            [self performSegueWithIdentifier:@"TweetView" sender:self];
        }
    }];
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

- (IBAction)tbxUserName_editOnExit:(id)sender {
}

- (IBAction)chkSaveChanged:(id)sender {
    if([_chkSave isOn]){
        isSave = true;
    }else{
        isSave = false;
    }
}
@end
