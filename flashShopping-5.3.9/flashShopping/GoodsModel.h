//
//  GoodsModel.h
//  flashShopping
//
//  Created by SG on 14-3-24.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "WXBaseModel.h"

@interface GoodsModel : WXBaseModel

/**********货品明细(goods) 集合对象**********************/
@property ( nonatomic , retain )NSNumber            *ID ;                          //货品ID
@property ( nonatomic , retain)NSNumber             *num ;                         //库存 如果为0则为缺货商品
@property ( nonatomic , retain)NSNumber              *price ;                       //价格
@property ( nonatomic , retain)NSMutableArray
    *attrs;                        //属性

@end
