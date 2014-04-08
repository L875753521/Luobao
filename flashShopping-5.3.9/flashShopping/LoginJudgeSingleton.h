//
//  LoginJudgeSingleton.h
//  flashShopping
//
//  Created by sg on 14-4-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginJudgeSingleton : NSObject

{
    NSMutableDictionary *_saveDataDic;
}
+ (LoginJudgeSingleton *)shareLoginJudge;
- (void)setLogin:(BOOL)isLogin;
- (BOOL)isLogin;
//保存字符串
- (void)saveObject:(NSString *)aObjectStr forKey:(NSString *)aKey;
//根据key取出对应的字符串
- (NSString *)objectForKey:(NSString *)aKey;
@end
