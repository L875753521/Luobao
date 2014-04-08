//
//  ModifyOrderPriceViewController.h
//  flashShopping
//
//  Created by sg on 14-3-13.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyOrderPriceViewController : BaseViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *_indicator;
    UIWebView *_webView;
}
@property (nonatomic,copy)NSString *requestURLStr;
@property (nonatomic, copy)NSString *orderCode;

- (id)initWithRequestURLStr:(NSString *)requestURLStr withOrderCode:(NSString *)aOrderCode;
@end
