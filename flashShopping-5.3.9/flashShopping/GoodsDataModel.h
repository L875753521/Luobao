//
//  GoodsDataModel.h
//  flashShopping
//
//  Created by SG on 14-3-22.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/********************************************actionCode:444
 Id                  Long            商品ID
 name                String          商品名称
 viewUrl             String          缩略图路径
 price               Double          闪购价
 auditingDate        String          审核时间
 isUp                String          是否上架(0未上架；1已上架)
 goods               List            货品明细
 

 获取货品运费*************actionCode:443
 
 baseprice           Integer         运费
*/

#import "WXBaseModel.h"

@interface GoodsDataModel : WXBaseModel

@property ( nonatomic , retain )NSNumber            *Id ;                          //商品ID
@property ( nonatomic , copy )NSString                  *name ;                        //商品名称
@property ( nonatomic , copy )NSString                  *viewUrl ;                     //缩略图路径
@property ( nonatomic , retain)NSNumber              *price ;                       //闪购价
@property ( nonatomic , copy  )NSString
    *auditingDate ;                //审核时间
@property ( nonatomic , copy  )NSString                  *isUp ;                        //是否上架、0 未上架、1 已上架
@property ( nonatomic , retain  )NSMutableArray
    *goods;                        //货品明细


//@property (nonatomic , copy) NSArray *goodsArr1;
//@property (nonatomic , copy) NSArray *goodsArr2;
//
///**********货品明细(goods) 集合对象**********************/
//@property ( nonatomic , retain) NSNumber            *goodsId ;                      //货品ID
//@property ( nonatomic , retain) NSNumber             *goodsNum ;                     //库存 如果为0则为缺货商品
//@property ( nonatomic , retain) NSNumber              *goodsPrice ;                   //价格
//@property ( nonatomic , copy  ) NSSet
//    *attrs;                         //属性
//
//@property (nonatomic , copy) NSDictionary *attrsDic1;
//@property (nonatomic , copy) NSDictionary *attrsDic2;
//@property (nonatomic , copy) NSDictionary *attrsDic3;
//@property (nonatomic , copy) NSDictionary *attrsDic4;
//
///**********属性集合（attrs）集合对象**********************/
//@property ( nonatomic , retain )NSNumber
//    *skuid ;                        //skuid
//@property ( nonatomic , copy )  NSString                  *customValue ;                  //商品编号


@end
