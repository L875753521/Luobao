//
//  AttrsDataModel.h
//  flashShopping
//
//  Created by SG on 14-3-24.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "WXBaseModel.h"

@interface AttrsDataModel : WXBaseModel

/**********属性集合（attrs）集合对象**********************/
@property ( nonatomic , retain ) NSNumber
    *skuid ;                        //skuid
@property ( nonatomic , copy )   NSString
    *customValue ;                  //商品编号


@end
