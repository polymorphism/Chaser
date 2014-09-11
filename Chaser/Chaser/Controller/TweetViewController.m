//
//  TweetViewController.m
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/23.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import "TweetViewController.h"


@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)_setHeaderViewHidden:(BOOL)hidden animated:(BOOL)animated
{
    CGFloat topOffset = 0.0;
    if (hidden) {
        topOffset = -self.tblHeader.frame.size.height;
    }
    if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
                         }];
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // グローバル変数の初期化
    count = 0;
    
    // AppDelegateからtwitterManagerを取得
    _tm = [APP_DELEGATE twitterManager];
    _cm = [APP_DELEGATE cacheManager];
    _df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    _idf = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_idf setLocale:locale];
    [_idf setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    
    // ViewTableの初期化
    //_tblTweetView.dataSource = self;
    //_tblTweetView.delegate = self;
    
    // 色定義
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _vm = [ViewManager alloc];
    [_vm init:self];
    
    _isFirst = YES;
    
    
    self.tableView.tableHeaderView = self.tblHeader;
    [self _setHeaderViewHidden:YES animated:NO];

}

- (void)viewDidAppear:(BOOL)animated{
    if(_isFirst){
        [self performSelector: @selector(refreshTable:) withObject:[NSNumber numberWithBool:YES] afterDelay: 0.1f];
        _isFirst = NO;
    }
}

- (void)refreshTable : (NSNumber *)isLoadingAnimate{
    
    if(_tm != nil){
        if([isLoadingAnimate boolValue]){
            [_vm StartIndicatorAnimate];
        }
        [_tm GetHomeTimeLine:^(NSDictionary *data,int statusCode, NSError *error){
            // 取得したユーザ画像のキャッシュ
            for (NSDictionary *tweet in data){
                NSDictionary *user = [tweet objectForKey:@"user"];
                NSString *screenName = [user objectForKey:@"screen_name"];
                if(![_cm HasKey:AUTHOR_CACHE_KEY : screenName]){
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[user objectForKey:@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"normal" withString:@"bigger"]]]];
                    // キャッシュする
                    [_cm AddCacheData:AUTHOR_CACHE_KEY :screenName :image];
                }
            }
            
            outData = [data copy];
            count = outData.count;
            if([isLoadingAnimate boolValue]){
                [_vm StopIndicatorAnimate];
            }
            [self _taskFinished];
            [self.tableView reloadData];
        } count:50];
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TweetCell"];
    }
    NSLog(@"rowIndex: %d", indexPath.row);
    
    // セル内のViewControl
    UIView* cellView = (UIView *)[cell.contentView viewWithTag:-1];
    UILabel* lblTimeStamp = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel* lblUserName = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel* lblAuthorName = (UILabel *)[cell.contentView viewWithTag:3];
    //UILabel* lblTweetText = (UILabel *)[cell.contentView viewWithTag:4];
    VerticallyAlignedLabel* lblTweetText = (VerticallyAlignedLabel *)[cell.contentView viewWithTag:998];
    UIImageView* imgAuthor = (UIImageView *)[cell.contentView viewWithTag:999];
    
    // 奇数・偶数で色を変える。
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [[UIColor blackColor]
                                    colorWithAlphaComponent:0.5f];
    }
    else {
        cell.backgroundColor = [[UIColor viewFlipsideBackgroundColor]
                                    colorWithAlphaComponent:0.5f];
    }
    
    
    if(outData){
        
        int index = indexPath.row;
        if (outData.count > index){
            //cell.textLabel.text = [outData[index] objectForKey:@"text"];
            NSDictionary* tweetUser = [outData[index] objectForKey:@"user"];
            NSString *name = [tweetUser objectForKey:@"name"];
            NSString *screenName = [tweetUser objectForKey:@"screen_name"];
            
            if([cell.contentView viewWithTag:999] == nil){;
                imgAuthor = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 48, 48)];
                [imgAuthor setTag:999];
                //imgAuthor.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
                imgAuthor.image = (UIImage *)[_cm GetCacheData:AUTHOR_CACHE_KEY :screenName];
                [cell.contentView addSubview:imgAuthor];
            }else{
                imgAuthor.image = (UIImage *)[_cm GetCacheData:AUTHOR_CACHE_KEY :screenName];                
            }
            
            lblTimeStamp.text =[_df stringFromDate:
                                [_idf dateFromString:[outData[index] objectForKey:@"created_at"]]];
            lblUserName.text = name;
            lblAuthorName.text = [NSString stringWithFormat:@"@%@" ,[tweetUser objectForKey:@"screen_name"]];
            
            if([cell.contentView viewWithTag:998] == nil){
                lblTweetText = [[VerticallyAlignedLabel alloc] init];
                lblTweetText.frame = CGRectMake(20, 70, 260, 80);
                lblTweetText.backgroundColor = [UIColor clearColor];
                lblTweetText.font =  [UIFont fontWithName:@"HiraKakuProN-W6"size:12];
                lblTweetText.lineBreakMode = NSLineBreakByTruncatingTail;
                lblTweetText.numberOfLines = 4;
                [lblTweetText setTag:998];
                lblTweetText.verticalAlignment = VerticalAlignmentTop;
                lblTweetText.textColor = [UIColor whiteColor];
                lblTweetText.text = [outData[index] objectForKey:@"text"];
                [cell.contentView addSubview:lblTweetText];
            }else{
                lblTweetText.text =[outData[index] objectForKey:@"text"];
            }
    
            
        }else{
            cell.textLabel.text = @"null data";
        }
    }else{
        
        lblTimeStamp.text = @"";
        lblUserName.text = @"";
        lblAuthorName.text = @"";
        lblTweetText.text = @"";
    }

    [cell setNeedsLayout];
    
    return cell;
}



#define PULLDOWN_MARGIN -15.0f

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tblHeader.state == HeaderViewStateStopping) {
        return;
    }
    
    CGFloat threshold = self.tblHeader.frame.size.height;
    
    if (PULLDOWN_MARGIN <= scrollView.contentOffset.y &&
        scrollView.contentOffset.y < threshold) {
        self.tblHeader.state = HeaderViewStatePullingDown;
        
    } else if (scrollView.contentOffset.y < PULLDOWN_MARGIN) {
        self.tblHeader.state = HeaderViewStateOveredThreshold;
        
    } else {
        self.tblHeader.state = HeaderViewStateHidden;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    if (self.tableView.contentOffset.y < PULLDOWN_MARGIN) {
    if (self.tblHeader.state == HeaderViewStateOveredThreshold) {
        self.tblHeader.state = HeaderViewStateStopping;
        [self _setHeaderViewHidden:NO animated:YES];
        
        [self refreshTable:[NSNumber numberWithBool:NO]];
    }
}

- (void)_taskFinished
{
    self.tblHeader.state = HeaderViewStateHidden;
//    [self.tblHeader setUpdatedDate:[NSDate date]];
    [self _setHeaderViewHidden:YES animated:YES];
}





@end
