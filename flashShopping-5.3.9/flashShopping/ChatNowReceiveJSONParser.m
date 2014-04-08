//
//  ChatNowReceiveJSONParser.m
//  flashShopping
//
//  Created by sg on 14-3-21.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ChatNowReceiveJSONParser.h"
#import "NSString+NSString_getDictionary.h"
#import "LoginJudgeSingleton.h"

@implementation ChatNowReceiveJSONParser

- (void)parserWithMessage:(id)message isLogin:(receiveLoginData)loginBlock isMessage:(receiveMessageData)messageBlock isFile:(receiveFileData)fileBlock isMessageResult:(receiveMessageResultData)messageResult isReceiveNotic:(receiveMessageNoticData)messageNotic{
    
    if (message) {
        
        NSString *parserSource = (NSString *)message;
        
        if (parserSource) {
            
            NSDictionary *sourceDic = [parserSource getDictionary];
            
            if (sourceDic) {
                
                NSString *judgeKeyWords = [sourceDic objectForKey:@"back_type"];
                
                if (judgeKeyWords) {
                    
                    // 登陆返回信息的处理逻辑
                    
                    if ([judgeKeyWords isEqualToString:@"login"]) {
                        
                        ChatNowLoginModel *loginModel = [[ChatNowLoginModel alloc] init];
                        
                        loginModel.loginStatus = [sourceDic objectForKey:@"login_status"];
                        loginModel.sessionID = [sourceDic objectForKey:@"session_id"];
                        loginModel.time = [sourceDic objectForKey:@"time"];
                        loginModel.userName = [sourceDic objectForKey:@"username"];
                        
                        loginBlock(loginModel);
                        return;
                    }
                    
                    /*
                     @property (nonatomic, copy) NSString *getUser;
                     @property (nonatomic, copy) NSString *getUserType;
                     @property (nonatomic, copy) NSString *message;
                     @property (nonatomic, copy) NSString *sendUser;
                     @property (nonatomic, copy) NSString *sendUserType;
                     @property (nonatomic, copy) NSString *time;
                     @property (nonatomic, assign) BOOL isSendByMe;
                     
                     {
                     "back_type" = msg;
                     "get_user" = ceshi;
                     "get_user_type" = 2;
                     message = hello;
                     "send_user" = 18676720523;
                     "send_user_type" = 1;
                     time = "2014-03-45 16:54:45";
                     }
                     
                     
                     
                     */
                    //                    接收到消息业务逻辑
                    if ([judgeKeyWords isEqualToString:@"msg"]) {
                        
                        ChatMessageModel *messageModel = [[ChatMessageModel alloc] init];
                        
                        messageModel.getUser = [sourceDic objectForKey:@"get_user"];
                        messageModel.getUserType = [sourceDic objectForKey:@"get_user_type"];
                        messageModel.message = [sourceDic objectForKey:@"message"];
                        messageModel.sendUser = [sourceDic objectForKey:@"send_user"];
                        messageModel.sendUserType = [sourceDic objectForKey:@"send_user_type"];
                        messageModel.time = [sourceDic objectForKey:@"time"];
                        
                        
                        
                        //              初始化时间标签的超时时间
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                        
                        NSDate *timeOutDate = [dateFormatter dateFromString:messageModel.time];
                        timeOutDate = [NSDate dateWithTimeInterval:300 sinceDate:timeOutDate];
                        
                        NSString *timeOutStr = [dateFormatter stringFromDate:timeOutDate];
                        
                        messageModel.timeOut = timeOutStr;
                        
                        
                        messageModel.isSendByMe = NO;
                        
                        messageBlock(messageModel);
                        
                        return;
                    }
                    //                    发送消息的返回信息
                    if ([judgeKeyWords isEqualToString:@"send_result"]) {
                        
                        ChatNowResultModel *resultModel = [[ChatNowResultModel alloc] init];
                        
                        resultModel.messageID = [sourceDic objectForKey:@"msg_id"];
                        resultModel.time = [sourceDic objectForKey:@"time"];
                        
                        messageResult(resultModel);
                        
                        return;
                    }
                    /*{"back_type":"server_info","user":"server","time":"2014-03-31 16:40:41"}*/
                    if ([judgeKeyWords isEqual:@"server_info"]) {
                        NSString *serverName = [sourceDic objectForKey:@"user"];
                        if (serverName) {
                            [[NSUserDefaults standardUserDefaults] setObject:serverName forKey:@"ChatServerName"];
                            [[LoginJudgeSingleton shareLoginJudge] saveObject:serverName forKey:SERVERCHATIDSINGLETON];
                        }
                        
                        return;
                    }
                    
                    if ([judgeKeyWords isEqualToString:@""]) {
                        
                        
                        
                        return;
                    }
                    
                    if ([judgeKeyWords isEqualToString:@""]) {
                        
                        
                        
                        return;
                    }
                    
                    if ([judgeKeyWords isEqualToString:@""]) {
                        
                        
                        
                        return;
                    }
                    
                    
                }
                
                
            }
            
            
        }
    }
    
    
    
}
@end
