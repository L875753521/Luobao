//
//  MainViewController.h
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"
#import "ChatNowReceiveJSONParser.h"

@interface MainViewController : UITabBarController<UINavigationControllerDelegate,SRWebSocketDelegate>
{
    UIButton *_lastSelecteButton;
    NSTimer *_timer;
    SRWebSocket *_mainSocket;
    
    NSMutableDictionary *_loginDataDic;
    NSMutableDictionary *_sendMessageDic;
    NSMutableDictionary *_sendImageDic;
    ChatNowReceiveJSONParser *_parser;
    NSString *_isChatNowInvoke;
    int numberOfMessage;
    
    UINavigationController *_selfNavigation;
    
    
}
- (void)showBarItem:(BOOL)show;

@end
