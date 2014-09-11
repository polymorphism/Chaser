//
//  TwitterManager.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/19.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TwitterManager : NSObject

@property NSString *userName;

@property id twAccount;
@property (nonatomic) ACAccountStore *accountStore;

// Twitterアカウント情報にアクセスできるか
- (BOOL)HasAccessToTwitter;
// 【必ずリクエスト前に指定】指定したUserNameが登録されているか + グローバルにアカウントを固定
- (void)HasTwitterAccount:(void(^)(BOOL))successCallback;
// Twitterのホームタイムラインを取得
- (BOOL)GetHomeTimeLine:(void(^)(NSDictionary * ,int, NSError *))successCallback count:(int) count;
// Twitterのユーザタイムラインを取得
- (BOOL)GetUserTimeLine:(void(^)(NSDictionary * ,int, NSError *))successCallback count:(int) count;

@end
