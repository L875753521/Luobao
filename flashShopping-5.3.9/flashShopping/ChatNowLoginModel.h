//
//  ChatNowLoginModel.h
//  flashShopping
//
//  Created by sg on 14-3-21.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatNowLoginModel : NSObject
/*
 
 {"back_type":"login","login_status":true,"session_id":"c2ce292ffd99e4823c6088a8ee2066fe","time":"2014-03-44 15:07:44","username":"18676720523"}
 */
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *loginStatus;
@property (nonatomic, copy) NSString *sessionID;
@property (nonatomic, copy) NSString *time;

@end
