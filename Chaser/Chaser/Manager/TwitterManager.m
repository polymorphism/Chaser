//
//  TwitterManager.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/19.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "TwitterManager.h"

@implementation TwitterManager




// ユーザ名
@synthesize userName = _userName;

// 初期化
- (id) init {
    
    self = [super init];
    if(self){
        _accountStore = [[ACAccountStore alloc]init];
    }
    
    return self;
}

- (void)HasTwitterAccount:(void (^)(BOOL))successCallback{
    
    self.twAccount = NULL;
    
    // accountStoreからTwitterのアカウント情報を取得する。
    ACAccountType *twAcType = [self.accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
    NSArray *twAccounts = [self.accountStore accountsWithAccountType:twAcType];
    if([self HasAccessToTwitter]){
        
        // accountStoreからTwitterのアカウント情報を取得する。
        ACAccountType *twAcType = [self.accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
        
        
        [self.accountStore
         requestAccessToAccountsWithType:twAcType
         options:NULL
         completion:^(BOOL granted, NSError *error){
             BOOL isFound = false;
             // 認証コールバック
             if(granted){
                 for (id account in twAccounts){
                     if([self.userName isEqualToString:[account username]]){
                         self.twAccount  = account;
                         isFound = true;
                         break;
                     }
                 }
             }
             // 結果を応答
             successCallback(isFound);
         }
         ];
    }
    
}


// Twitterアカウントへのアクセス権を持っているか
- (BOOL)HasAccessToTwitter{
    
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
    
}

- (BOOL)TwitterRequestWithAuth : (NSURL *)url params:(NSDictionary *)params
                successCallback:(void(^)(NSDictionary * ,int, NSError *))successCallback {
    
    // リクエスタの生成（ソーシャルフレームワークから要求）
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL: url
                                               parameters:params];

    // アカウントの設定
    [request setAccount: self.twAccount];

    // リクエスト
    [request performRequestWithHandler:^(NSData *responseData,
                                      NSHTTPURLResponse *urlResponse,
                                      NSError *error){
     
     // 応答コールバック
     if(responseData){
         
         if(urlResponse.statusCode >= 200 && urlResponse.statusCode < 300){
             // HTTPステータスコード200番台であれば正常応答
             NSError *errorJSONData;
             NSDictionary *data = [NSJSONSerialization
                                   JSONObjectWithData:responseData
                                   options:NSJSONReadingAllowFragments
                                   error : &errorJSONData];
             
             // 応答データ
             if (data){
                 // 共通応答処理
                 NSLog(@"Timeline Response: %@¥n", data);
                 
                 // コールバックに委譲
                 successCallback(data,urlResponse.statusCode,errorJSONData);
                 
             }else{
                 NSLog(@"JSON Error: %@¥n", [errorJSONData localizedDescription]);
             }
             
         }
         else{
             NSLog(@"HTTP CONNECTION ERROR (STATUS_CODE:%d]", urlResponse.statusCode);
         }
         
     }
     else{
         // 何らかのエラー
         NSLog(@"UNKNOWN ERROR : %@" , [error localizedDescription]);
     }
     
    }];    
    
    return YES;
}


// HOME タイムラインの取得
- (BOOL)GetHomeTimeLine:(void (^)(NSDictionary *, int, NSError *))successCallback count:(int)count{
    
    // URL
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    // パラメータ
    NSDictionary *params = @{@"screen_name" : self.userName,
                             @"count"       : [NSString stringWithFormat: @"%d", count],
                             @"include_rts" : @"0",
                             @"trim_user"   : @"0",};
    
    
    
    [self TwitterRequestWithAuth:url params:params successCallback:^(NSDictionary *data,int statusCode, NSError *error) {
        
        NSLog(@"Home Timeline Response: %@¥n", data);
        
        successCallback(data,statusCode,error);
        
    }];
    
    
    return YES;
    
    
    
}

// USER タイムラインの取得
- (BOOL) GetUserTimeLine:(void (^)(NSDictionary *, int, NSError *))successCallback count:(int)count{
    
    // URL
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
    // パラメータ
    NSDictionary *params = @{@"screen_name" : self.userName,
                             @"count"       : [NSString stringWithFormat: @"%d", count],
                             @"include_rts" : @"0",
                             @"trim_user"   : @"1",
                             @"count"       : @"1"};
    
    
    
    [self TwitterRequestWithAuth:url params:params successCallback:^(NSDictionary *data,int statusCode, NSError *error) {
        
        NSLog(@"User Timeline Response: %@¥n", data);
        
        successCallback(data,statusCode,error);
        
    }];
    
    
    return YES;
}



@end
