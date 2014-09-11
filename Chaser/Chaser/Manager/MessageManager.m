//
//  MessageManager.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/20.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "MessageManager.h"

@implementation MessageManager
    
-(NSString *)GetMessage : (NSString *)messageId :(MessageType) messageType{

    NSString *message = @"";
    if(_messageListPath == NULL){
        _messageListPath = [[NSBundle mainBundle] pathForResource:@"MessageList_JP" ofType:@"plist"];
        _messageList = [NSDictionary dictionaryWithContentsOfFile:_messageListPath];
    }

    NSDictionary *mes;
    
    switch (messageType) {
        case INFO:
            if(_infoMessageList == NULL){
                _infoMessageList = [_messageList objectForKey:@"Info"];
            }
            mes = _infoMessageList;
            break;
        case WARN:
            
            if(_warnMessageList == NULL){
                _warnMessageList = [_messageList objectForKey:@"Warn"];
            }
            mes = _warnMessageList;
            break;
        case ERROR:
            if(_errorMessageList == NULL){
                _errorMessageList = [_messageList objectForKey:@"Error"];
            }
            mes = _errorMessageList;
            break;
        default:
            mes = NULL;
            break;
    }
    
    if(mes != NULL){
        message = [mes objectForKey:messageId];
    }
    

    return message;
}

@end
