//
//  OrderManagerDetailViewController.h
//  flashShopping
//
//  Created by sg on 14-3-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderManagerDetailViewController : BaseViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *_indicator;
    UIWebView *_webView;
}
@property (nonatomic,copy)NSString *requestURLStr;

- (id)initWithRequestURLStr:(NSString *)requestURLStr;
@end
