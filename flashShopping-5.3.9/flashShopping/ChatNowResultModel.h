//
//  ChatNowResultModel.h
//  flashShopping
//
//  Created by sg on 14-3-21.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatNowResultModel : NSObject
/*
 {"back_type":"send_result","msg_id":"2555741D-68AC-4FAF-9D56-6D1EE80B8AEB","time":"2014-03-05 16:53:05"}
 
 */

@property (nonatomic, copy) NSString *messageID;
@property (nonatomic, copy) NSString *time;
@end
