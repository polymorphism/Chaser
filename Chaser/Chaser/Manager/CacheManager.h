//
//  CacheManager.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/31.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 Webから取得したデータのキャッシュなどに利用
 
 Data構造
 
 cache {
    key {
        subkey : obj,
        subkey : obj
         ....
        },
    key {
        ....
    }
  }
 */
@interface CacheManager : NSObject{
    NSMutableDictionary *cache;
}

-(BOOL)HasKey : (NSString *) key : (NSString *) subKey;
-(NSMutableDictionary *)GetCacheData : (NSString *) key;
-(id)GetCacheData : (NSString *) key : (NSString *) subKey;
-(void)AddCacheData : (NSString *) key : (NSString *) subKey :(id)object;

@end
