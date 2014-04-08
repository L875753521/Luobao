//
//  CustomNavigationBar.h
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIBarButtonItem.h"
#import "PullNenu.h"

@interface CustomNavigationBar : UIView
{
    UIButton *pullDwonButton ;
}

@property( nonatomic , copy )UIButton *titleButton ;
@property (nonatomic , retain )PullNenu *pullNenu ;
@property ( nonatomic , retain )NSArray *titleArr;
@property (nonatomic , assign)BOOL flag ;
@property ( nonatomic , assign )id<barButtonProtocol>barButtonDele ;
@property ( nonatomic , assign )id<pullNenuProtocol>pullDele ;
- (id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr andSetBarButtonDelegate:(id<barButtonProtocol>)barButtondelegate  andSetPullNenuDelegate:(id<pullNenuProtocol>)pullDelegate ;
- (void)pullDwonAction;
@end
