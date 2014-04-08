//
//  SGDataService.m
//  ASIService
//
//  Created by Width on 14-2-28.
//  Copyright (c) 2014年 mojingtao. All rights reserved.
//

#import "SGDataService.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#import "SBJsonWriter.h"
#import "LogisticModel.h"

@implementation SGDataService

+(ASIHTTPRequest*)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod completeBlock:(requestFinishBlock)block
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodedString]];
    __unsafe_unretained ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:httpMethod];
    //比较看是post还是get请求
    NSComparisonResult comparRet = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparRet == NSOrderedSame) {
        //把字典转化为json
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        NSString *jsonStr = [[jsonWriter stringWithObject:dictparams]URLEncodedString];
        //把％20替换成＋
        NSMutableString *mutableStr =[NSMutableString stringWithString:jsonStr];
        NSRange range = NSMakeRange(0, [mutableStr length]);
        [mutableStr replaceOccurrencesOfString:@"%20" withString:@"+" options:NSCaseInsensitiveSearch range:range];
        //添加请求头还有请求体
        [request addRequestHeader:@"content-type" value:@"application/json"];
        [request appendPostData:[mutableStr dataUsingEncoding:NSUTF8StringEncoding ]];
        
    }
    //请求完成的block
    [request setCompletionBlock:^{
        NSString *getStr = [[request responseString] URLDecodedString];
        //json解析（ios5以后NSJSONSerialization）
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[getStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        
        if (result) {
            
            NSString *content = [result objectForKey:@"content"];
            
            LogisticModel *logisticModel = [[LogisticModel alloc] initWithDataDic:result];
            
            if ([content  isEqual: @""]) {
                
                
                logisticModel.baseprice = @"0";
                

            }
        }
        

        if (block != nil) {
           
            block(result);
        }
        
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        block([error localizedDescription]);
    }];
    
    [request startAsynchronous];
    return nil ;
}


@end
