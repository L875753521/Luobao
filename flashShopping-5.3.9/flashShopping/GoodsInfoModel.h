//
//  GoodsInfoModel.h
//  flashShopping
//

//
/********************************************actionCode:441
 Id                  Long            商品ID
 name                String          商品名称
 viewUrl             String          缩略图路径
 price               Double          闪购价
 
 */

#import "WXBaseModel.h"

@interface GoodsInfoModel : WXBaseModel

@property ( nonatomic , retain)NSNumber            *Id ;                          //商品ID
@property ( nonatomic , copy )NSString                  *name ;                        //商品名称
@property ( nonatomic , copy )NSString                  *viewUrl ;                     //缩略图路径
@property ( nonatomic , retain)NSNumber              *price ;                       //闪购价




//@property ( nonatomic , retain )NSNumber            *goodsId ;                     //货品ID
//@property ( nonatomic , copy )NSString                  *goodsCode ;                   //商品编号
//@property ( nonatomic , retain)NSNumber             *num ;                         //库存 如果为0则为缺货商品
//@property ( nonatomic , copy  )NSString                  *isUp ;                        //是否上架、0 未上架、1 已上架
//


@end
