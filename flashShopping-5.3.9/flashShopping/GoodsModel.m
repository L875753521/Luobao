//
//  GoodsModel.m
//  flashShopping
//
//  Created by SG on 14-3-24.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel


- (id)init{
    
    self = [super init];
    if (self) {
        
        self.attrs = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
    
}
//- (NSDictionary*)attributeMapDictionary
//{
//    NSDictionary *dict = @{
//                           
//                           @"id"           : @"id"          ,
//                           @"goodsCode"    : @"goodsCode"   ,
//                           @"num"          : @"num"         ,
//                           @"attrs"        : @"attrs"       ,
//                           @"price"        : @"price"       ,
//                           
//                           };
//    return dict ;
//}
//- (void)setAttributes:(NSDictionary *)dataDic
//{
//    [super setAttributes:dataDic];
//}

@end
