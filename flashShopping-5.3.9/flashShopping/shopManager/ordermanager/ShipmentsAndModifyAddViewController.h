//
//  ShipmentsAndModifyAddViewController.h
//  flashShopping
//
//  Created by sg on 14-3-14.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"

@interface ShipmentsAndModifyAddViewController : BaseViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *_indicator;
    UIWebView *_webView;
    BOOL _isDisplay;
}
@property (nonatomic,copy)NSString *requestURLStr;
@property (nonatomic, copy)NSString *orderCode;
@property (nonatomic, assign)BOOL isShipMents;
@property (nonatomic, copy)NSString *showMessageContent;
- (id)initWithRequestURLStr:(NSString *)requestURLStr withOrderCode:(NSString *)aOrderCode WithOptinStyleIsShipments:(BOOL)isShipMents;

@end
