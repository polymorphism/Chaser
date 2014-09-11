//
//  AnalyzeViewController.m
//  Chaser
//
//  Created by 菅付 俊佑 on 13/03/29.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "AnalyzeViewController.h"

@implementation AnalyzeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    // グローバル変数の初期化
    
    // AppDelegateからtwitterManagerを取得
    _tm = [APP_DELEGATE twitterManager];
    if(_tm == nil){
        return;
    }
    
}


@end
