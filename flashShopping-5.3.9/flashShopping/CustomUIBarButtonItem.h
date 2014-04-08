//
//  CustomUIBarButtonItem.h
//  flashShopping
//
//  Created by 莫景涛 on 14-3-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol barButtonProtocol <NSObject>
//点击自定义导航按钮时启动
- (void)actions:(id)sender;

@end

@interface CustomUIBarButtonItem : UIView
{
    CGRect  _subFrame ;
    NSString  *_backgroundImageName ;
}
@property ( nonatomic , assign )id<barButtonProtocol>deles ;
- (id)initWithFrame:(CGRect)frame andSetdelegate:(id<barButtonProtocol>)dele andImageName:(NSString*)imageName ;
@end
