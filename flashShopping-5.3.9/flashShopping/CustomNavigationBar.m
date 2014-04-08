//
//  CustomNavigationBar.m
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr andSetBarButtonDelegate:(id<barButtonProtocol>)barButtondelegate  andSetPullNenuDelegate:(id<pullNenuProtocol>)pullDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titleArr = [NSArray new];
        _titleArr = [ titleArr copy];
        _barButtonDele = barButtondelegate ,
        _pullDele = pullDelegate ;
        [self _initView];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
}
- (void)_initView
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideBgView) name:@"hideBg" object:nil];
    
    //自定义导航栏
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"navigationbarBackground"]];
    
    [imageView setFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, 44)];
    imageView.userInteractionEnabled = YES ;
    [self addSubview:imageView];
    
    // 导航栏左边按钮
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(10, 10, 20, 20) andSetdelegate:_barButtonDele andImageName:@"return"];
    barButton.tag = 10 ;
    [self addSubview:barButton];
    
     //导航栏标题
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleButton setFrame:CGRectMake( (SCREENMAIN_WIDTH - 100 ) / 2, 5, 100, 34)];
    _titleButton.tag = 100 ;
    [_titleButton setTitle:_titleArr[0] forState:UIControlStateNormal];
    _titleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_titleButton addTarget:self action:@selector(pullDwonAction) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:_titleButton];
    
     //导航栏下拉菜单
    pullDwonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pullDwonButton setFrame:CGRectMake(_titleButton.left + _titleButton.width, 15, 15, 14)];
    pullDwonButton .showsTouchWhenHighlighted = YES ;
    [pullDwonButton setBackgroundImage:[UIImage imageNamed:@"pullDownButton"] forState:UIControlStateNormal];
    [pullDwonButton addTarget:self action:@selector(pullDwonAction) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:pullDwonButton];
    
    _pullNenu = [[PullNenu alloc]initWithFrame:CGRectMake(100, 25, 150, _titleArr.count*33) setDelegate:_pullDele AndTitleArr:_titleArr];
    _pullNenu.backgroundColor = [UIColor clearColor];
    _pullNenu.hidden = YES ;
    [self addSubview:_pullNenu];

     //导航栏右边刷新按钮
    CustomUIBarButtonItem *barButtonrefresh = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(SCREENMAIN_WIDTH - 30, 10, 20, 20) andSetdelegate:_barButtonDele andImageName:@"refresh"];
   barButtonrefresh.tag = 11 ;
    [self addSubview:barButtonrefresh];
    
}
#pragma mark---customAction
- (void)pullDwonAction
{
    NSLog(@"%d",_flag);
    if (!_flag) {
        _pullNenu.hidden = NO ;
        self.height = _pullNenu.height + 44;
    }else{
        _pullNenu.hidden = YES;
        self.height = 44;
    }
    _flag = !_flag ;
     //旋转90°
        [UIView animateWithDuration:0.5 animations:^{
         CGAffineTransform   oldTrans = pullDwonButton.transform ;
        CGAffineTransform   newTrans = CGAffineTransformRotate(oldTrans, 180 * M_PI / 180);
        pullDwonButton.transform = newTrans ;
    }];

}
- (void)hideBgView
{
    self.height = 44 ;
}
@end
