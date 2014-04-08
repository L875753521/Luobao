//
//  GoodsDataModel.m
//  flashShopping
//
//  Created by SG on 14-3-22.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*******************************************************
 Id                  Long            商品ID
 name                String          商品名称
 viewUrl             String          缩略图路径
 price               Double          闪购价
 auditingDate        String          审核时间
 isUp                String          是否上架(0未上架；1已上架)
 goods               List            货品明细
 
*/

#import "GoodsDataModel.h"

@implementation GoodsDataModel

- (id)init{
    
    self = [super init];
    if (self) {
        
        self.goods = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
    
}
//@synthesize goodsArr1 = _goodsArr1;
//@synthesize goodsArr2 = _goodsArr2;
//
//@synthesize attrsDic1 = _attrsDic1;
//@synthesize attrsDic2 = _attrsDic2;
//@synthesize attrsDic3 = _attrsDic3;
//@synthesize attrsDic4 = _attrsDic4;

- (NSDictionary *)attributeMapDictionary
{
//    _goodsArr1 = @[@"goodsId",@"goodsNum",@"goodsPrice",@"attrs"];
//    _goodsArr2 = @[@"goodsId",@"goodsNum",@"goodsPrice",@"attrs"];
//    
//    _attrsDic1 = @{
//                                
//                                @"skuid"       : @"skuid"        ,
//                                @"customValue" : @"customValue"  ,
//                  };
//    
//    _attrsDic2 = @{
//                                
//                                @"skuid"       : @"skuid"        ,
//                                @"customValue" : @"customValue"  ,
//                  };
//    
//    _attrsDic3 = @{
//                                
//                                @"skuid"       : @"skuid"        ,
//                                @"customValue" : @"customValue"  ,
//                  };
//    
//    _attrsDic4 = @{
//                                
//                                @"skuid"       : @"skuid"        ,
//                                @"customValue" : @"customValue"  ,
//                  };
    

    NSDictionary *dict = @{
                           
                           @"id"           : @"id"          ,
                           @"name"         : @"name"        ,
                           @"viewUrl"      : @"viewUrl"     ,
                           @"price"        : @"price"       ,
                           @"auditingDate" : @"auditingDate",
                           @"isUp"         : @"isUp"        ,
                           @"goods"        : @"goods"       ,
                           
//                           @"_goodsArr1"    :@"_goodsArr1"  ,
//                           @"_goodsArr2"    :@"_goodsArr2"  ,
//                           
//                           @"_attrsDic1"    :@"_attrsDic1"  ,
//                           @"_attrsDic2"    :@"_attrsDic2"  ,
//                           @"_attrsDic3"    :@"_attrsDic3"  ,
//                           @"_attrsDic4"    :@"_attrsDic4"  ,
                           
                           };
    
    
    
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}

@end
