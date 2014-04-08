//
//  ChatMessageModel.h
//  flashShopping
//
//  Created by sg on 14-3-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessageModel : NSObject

@property (nonatomic, copy) NSString *getUser;
@property (nonatomic, copy) NSString *getUserType;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sendUser;
@property (nonatomic, copy) NSString *sendUserType;
@property (nonatomic, copy) NSString *time;
//自定义属性，时间标签的超时时间和发送放是否为自己。
@property (nonatomic, copy) NSString *timeOut;
@property (nonatomic, assign) BOOL isSendByMe;
@end
