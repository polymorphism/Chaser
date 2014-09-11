//
//  CacheManager.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/31.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager




-(BOOL)HasKey : (NSString *) key : (NSString *) subKey{
    
    if([[cache allKeys] containsObject:key]){
        if([[(NSMutableDictionary *)[cache objectForKey:key] allKeys] containsObject:subKey]){
            return YES;
        }
    }
    
    return NO;
    
}

-(NSMutableDictionary *)GetCacheData : (NSString *) key{

    if(cache != nil){
        return (NSMutableDictionary *)[cache objectForKey:key];
    }
    return nil;
    
}


-(id)GetCacheData : (NSString *) key : (NSString *) subKey{
    
    if(cache != nil){
        NSMutableDictionary *data = (NSMutableDictionary *)[cache objectForKey:key];
        if(data != nil){
            return [data objectForKey:subKey];
        }
    }
    return nil;
}


-(void)AddCacheData : (NSString *) key : (NSString *) subKey :(id)object{
    
    if(cache == nil){
        cache = [[NSMutableDictionary alloc] init];
    }
    
    
    NSMutableDictionary *data = (NSMutableDictionary *)[cache objectForKey:key];
    
    if(data == nil){
        data = [[NSMutableDictionary alloc] init];
        [cache setObject:data forKey:key];
    }

    // 格納
    [data setObject:object forKey:subKey];

}

@end
