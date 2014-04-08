//
//  CustomUIBarButtonItem.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "CustomUIBarButtonItem.h"

@implementation CustomUIBarButtonItem

- (id)initWithFrame:(CGRect)frame andSetdelegate:(id<barButtonProtocol>)dele andImageName:(NSString*)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        _subFrame = frame  ;
        _deles = dele ;
        _backgroundImageName = imageName ;
        [self _initBarButton];
    }
    return self;
}
- (void)_initBarButton
{
    NSLog(@"%@,%f",_backgroundImageName,_subFrame.size.height);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, _subFrame.size.width, _subFrame.size.height)];
    [button setBackgroundImage:[UIImage imageNamed:_backgroundImageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction) forControlEvents: UIControlEventTouchUpInside ];
    [self addSubview:button];
}
- (void)clickAction
{
    if(_deles && [_deles respondsToSelector:@selector(actions:)]){
        [_deles actions:self];
    }
}
@end
