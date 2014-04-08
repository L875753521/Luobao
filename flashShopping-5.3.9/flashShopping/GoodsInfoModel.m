//
//  GoodsInfoModel.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*******************************************************
 Id                  Long            商品ID
 name                String          商品名称
 viewUrl             String          缩略图路径
 price               Double          闪购价

 
 */
#import "GoodsInfoModel.h"

@implementation GoodsInfoModel
- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                
                           @"Id"           : @"id"          ,
                           @"name"         : @"name"        ,
                           @"viewUrl"      : @"viewUrl"     ,
                           @"price"        : @"price"       ,
        };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}
@end
