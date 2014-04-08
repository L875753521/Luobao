//
//  LogisticModel.h
//  flashShopping
//
//  Created by SG on 14-3-25.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "WXBaseModel.h"

@interface LogisticModel : WXBaseModel

/**********货品运费actionCode:443**********************/

@property ( nonatomic , copy )NSString
    *baseprice ;                   //运费(0为免运费)


@end
