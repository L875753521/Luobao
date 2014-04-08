//
//  GoodsManamentModel.h
//  flashShopping
//
//  Created by Width on 14-1-17.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*key	type	directions
 Id	Long	商品ID
 goodsId	Long	货品ID
 name	String	商品名称
 goodsCode	String	商品编号
 viewUrl	String	缩略图路径
 price	Double	闪购价
 num	Integer	库存
 */
#import <Foundation/Foundation.h>

@interface GoodsManamentModel : NSObject

@property (nonatomic , copy)NSString
    *directions ;               //商品描述
@property (nonatomic , assign)NSInteger       Id ;                        //商品ID
@property (nonatomic , assign)NSInteger
    goodsId ;                  //货品ID
@property (nonatomic , copy)NSString            *name ;                   //商品名称
@property (nonatomic , copy)NSString
    *goodsCode ;              //商品编号
@property (nonatomic , copy)NSString            *viewUrl ;                //缩略图路径
@property (nonatomic , assign)CGFloat           price ;                   //闪购价
@property (nonatomic , assign)NSInteger
    num ;                     //库存

@end
