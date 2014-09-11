//
//  MessageManager.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/20.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageManager : NSObject{
    NSString *_messageListPath;
    NSDictionary *_messageList;
    NSDictionary *_infoMessageList;
    NSDictionary *_errorMessageList;
    NSDictionary *_warnMessageList;
}

typedef enum MessageType : NSUInteger {
    INFO,
    WARN,
    ERROR
} MessageType;


-(NSString *)GetMessage : (NSString *)messageId :(MessageType) messageType;
@end
