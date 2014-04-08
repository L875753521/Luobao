//
//  OrderManagementViewController.h
//  flashShopping
//
//  Created by Width on 14-1-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomNavigationBar.h"
@interface OrderManagementViewController : BaseViewController<UIWebViewDelegate,pullNenuProtocol,barButtonProtocol>
{
    NSURLRequest *_request;
    UIWebView *_webView;
    NSMutableDictionary *controlJSActionInfoDic;
    NSString *orderNumber;
    NSString *forwordURL;
    CustomNavigationBar *navigationBar ;
    NSArray *titleArr;
    NSString *_userID;
    NSString *_companyID;
    
}
@property (unsafe_unretained, nonatomic) IBOutlet UIView *bobyView;
@property (nonatomic,copy)NSString *queryType;
- (id)initWithQueryType:(NSString *)queryType;


@end
