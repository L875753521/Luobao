//
//  NSString+NSString_getDictionary.m
//  flashShopping
//
//  Created by sg on 14-3-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "NSString+NSString_getDictionary.h"

@implementation NSString (NSString_getDictionary)
- (NSDictionary *)getDictionary{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    return dic;
}
@end
