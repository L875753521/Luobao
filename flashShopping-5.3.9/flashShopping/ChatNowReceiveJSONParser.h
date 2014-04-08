//
//  ChatNowReceiveJSONParser.h
//  flashShopping
//
//  Created by sg on 14-3-21.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatMessageModel.h"
#import "ChatNowLoginModel.h"
#import "ChatNowFileModel.h"
#import "ChatNowResultModel.h"
#import "ChatNowReceiveNoticModel.h"

typedef void(^receiveLoginData)(ChatNowLoginModel *login);
typedef void(^receiveMessageData)(ChatMessageModel *message);
typedef void(^receiveFileData)(ChatNowFileModel *file);
typedef void(^receiveMessageResultData)(ChatNowResultModel *messageResult);
typedef void(^receiveMessageNoticData)(ChatNowReceiveNoticModel *receiveNotic);

@interface ChatNowReceiveJSONParser : NSObject
- (void)parserWithMessage:(id)message isLogin:(receiveLoginData)loginBlock isMessage:(receiveMessageData)messageBlock isFile:(receiveFileData)fileBlock isMessageResult:(receiveMessageResultData)messageResult isReceiveNotic:(receiveMessageNoticData)messageNotic;


@end
