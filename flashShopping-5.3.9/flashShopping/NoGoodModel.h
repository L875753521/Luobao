//
//  NoGoodModel.h
//  flashShopping
//
//  Created by SG on 14-3-22.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//


/**********************************actionCode:445
 
 Id                  Long            缺货商品ID
 name                String          缺货商品名称
 viewUrl             String          缺货缩略图路径
 price               Double          缺货闪购价
 
 */

#import "WXBaseModel.h"

@interface NoGoodModel : WXBaseModel

@property ( nonatomic , retain)NSNumber            *noGoodsId ;                          //缺货商品ID
@property ( nonatomic , copy  )NSString
    *noGoodsName ;                        //缺货商品名称
@property ( nonatomic , copy  )NSString
    *noGoodsViewUrl ;                     //缺货缩略图路径
@property ( nonatomic , retain)NSNumber              *noGoodsPrice ;                       //缺货闪购价


@end
