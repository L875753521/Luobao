//
//  ChatViewController.h
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "SRWebSocket.h"


@interface ChatViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

{
    
    UITableView *_dataSourceTableView;
    UIImageView *_subscriptImageView;
    NSMutableArray *_sellerDataArr;
    NSMutableArray *_shanGouDataArr;
    NSMutableArray *_dataArr;
    NSTimer *_timer;
    
    NSString *_currentConversitionObj;
    NSMutableDictionary *_loginDataDic;
    
    NSMutableArray *_badgeValueArr;
    int numberOfMessage;
    int numberOfServerMessage;
    
    UIImageView *_sellerConversationBadge;
    UIImageView *_shanGouConversationBadge;
    NSMutableArray *_setSellerBadgeValueArr;
    BOOL _isChatWithServer;
    
    //    NSDate *_timeOutDate;
    
}
@end
