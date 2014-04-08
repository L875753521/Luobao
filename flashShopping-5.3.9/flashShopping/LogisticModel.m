//
//  LogisticModel.m
//  flashShopping
//
//  Created by SG on 14-3-25.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LogisticModel.h"

@implementation LogisticModel

- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           
                           @"baseprice"    :@"baseprice"    ,
                           
                           
                           };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}


@end
