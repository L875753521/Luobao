//
//  NoGoodsCell.h
//  flashShopping
//
//  Created by SG on 14-3-27.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//


/**********************************actionCode:445
 
 Id                  Long            缺货商品ID
 name                String          缺货商品名称
 viewUrl             String          缺货缩略图路径
 price               Double          缺货闪购价
 
 */

#import <UIKit/UIKit.h>
#import "NoGoodModel.h"

@interface NoGoodsCell : UITableViewCell

@property ( nonatomic , retain )UIImageView         *noGoodsViewUrl;                    //缩略图路径
@property ( nonatomic , retain )UILabel
    *noGoodsNameLabel;                  //商品名称
@property ( nonatomic , retain )UILabel
    *noGoodsIdLabel;                    //商品ID
@property ( nonatomic , retain )UILabel
    *noGoodsPriceLabel;                 //价格（字体）
@property ( nonatomic , retain )UILabel
    *noGoodsPriceMoneyLabel;            //闪购价


@property (nonatomic  , retain )NoGoodModel        *noGoodsModel ;                      //数据模型

-(void)setIntroductionText:(NSString*)text ;

@end
