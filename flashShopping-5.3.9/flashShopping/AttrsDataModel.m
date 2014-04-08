//
//  AttrsDataModel.m
//  flashShopping
//
//  Created by SG on 14-3-24.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "AttrsDataModel.h"

@implementation AttrsDataModel

- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           
                           @"skuid"        : @"skuid"       ,
                           @"customValue"  : @"customValue" ,
                           
                           };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}


@end
