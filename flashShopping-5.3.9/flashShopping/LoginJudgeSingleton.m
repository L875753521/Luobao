//
//  LoginJudgeSingleton.m
//  flashShopping
//
//  Created by sg on 14-4-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LoginJudgeSingleton.h"

@implementation LoginJudgeSingleton
static LoginJudgeSingleton *_singleton = nil;
bool _isLogin;
+ (LoginJudgeSingleton *)shareLoginJudge{
    if (nil == _singleton) {
        
        _singleton = [[self alloc] init];
        
    }
    
    return _singleton;
}

- (BOOL)isLogin{
    
    return _isLogin;
    
}

- (void)setLogin:(BOOL)isLogin{
    
    _isLogin = isLogin;
}

- (void)saveObject:(NSString *)aObjectStr forKey:(NSString *)aKey{
    
    @synchronized(self){
        
        if (_saveDataDic == nil) {
            _saveDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        }
            
        [_saveDataDic setObject:aObjectStr forKey:aKey];
        
    }
    
}

- (NSString *)objectForKey:(NSString *)aKey{
    
    NSString *obj = nil;
    
    @synchronized(self){
        
        if (_saveDataDic) {
            if (aKey) {
                obj = [_saveDataDic objectForKey:aKey];
            }
            
        }
        return obj;
    }
    
}

+(id)alloc {
    
    @synchronized (self) {
        
        if (nil == _singleton) {
            _singleton = [super alloc];
        }
    }
    return _singleton;
}


@end
