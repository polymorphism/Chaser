//
//  TweetViewController.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/23.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterManager.h"
#import "ViewManager.h"
#import "HeaderView.h"
#import "CacheManager.h"
#import "VerticallyAlignedLabel.h"

@interface TweetViewController : UITableViewController{
    TwitterManager *_tm;
    CacheManager *_cm;
    ViewManager *_vm;
    NSArray *outData;
    NSDateFormatter *_df;
    NSDateFormatter *_idf;
    int count;
    BOOL _isFirst;
}

#define AUTHOR_CACHE_KEY @"AuthorCache"

@property (nonatomic, retain) IBOutlet HeaderView* tblHeader;


@end
