//
//  BaseViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
//#import "FlashChatSettingsPageViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //自定义导航标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 125, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = _titleLabel;

    
       if (self.navigationController.viewControllers.count > 1) {
        //自定义ButtonItem
        UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonItem setFrame:CGRectMake(0, 0, 20, 27)];
        [buttonItem setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonItemClickAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonItem];
        self.navigationItem.leftBarButtonItem = barButtonItem ;
    }
    
}

#pragma mark------Action_click
//进入闪聊页面
- (void)intoChat
{
    NSLog(@"进入闪聊界面");
}
//点击了刷新按钮
- (void)refreshView
{
    NSLog(@"刷新页面");
}
//返回上一个视图
- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)Complete{
    NSLog(@"Complete");
}
- (void)intoSetUP
{
    NSLog(@"进入闪聊设置页面");
//    FlashChatSettingsPageViewController *FlashChatSettingsPageViewCtl = [[FlashChatSettingsPageViewController alloc] init];
//    [self.navigationController pushViewController:FlashChatSettingsPageViewCtl animated:YES];
    
}
- (void)isRemoveButtonClick
{
    NSLog(@"清除");
}

#pragma mark------Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark------RewriteSetmethod
//leftBarButtonItem 店铺管理页面的返回按钮
- (void)setIsBack:(BOOL)isBack
{
    _isBack = isBack;
    //统一创返回新按钮
    if (self.isBack) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 12, 15, 20)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}
//rightBarButtonItem的刷新按钮
- (void)setIsAddRefreshButton:(BOOL)isAddRefreshButton
{
    _isAddRefreshButton = isAddRefreshButton ;
    //统一创建刷新按钮
    if (self.isAddRefreshButton) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 12, 18, 20)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(refreshView) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.rightBarButtonItem = backItem;
    }
    
    
}
//rightBarButtonItem的闪聊按钮
- (void)setIsRightBarButtonChat:(BOOL)isRightBarButtonChat
{
    _isRightBarButtonChat = isRightBarButtonChat;
    //统一创建闪聊按钮
    if (self.isRightBarButtonChat) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 25, 24)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"rightBarButtonChat"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(intoChat) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.rightBarButtonItem = backItem;
    }
    
}
//leftBarButtonItem 更多页面的返回按钮
- (void)setIsMoreBackButton:(BOOL)isMoreBackButton
{
    _isMoreBackButton = isMoreBackButton;
    //统一创返回新按钮
    if (self.isMoreBackButton) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 40, 40)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"moreBack.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
}
//自定义完成按钮
- (void)setIsCompleteButton:(BOOL)isCompleteButton
{
    _isCompleteButton = isCompleteButton;
    //统一创完成新按钮
    if (self.isCompleteButton) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 40, 24)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"complete"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(Complete) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.rightBarButtonItem = backItem;
    }
    
}

//rightBarButtonItem的设置按钮
- (void)setIsSetUPButton:(BOOL)isSetUPButton
{
    _isSetUPButton = isSetUPButton;
    //统一创建闪聊按钮
    if (self.isSetUPButton) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 25, 24)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"u33_normal.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(intoSetUP) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.rightBarButtonItem = backItem;
    }
}
- (void)setIsRemoveButton:(BOOL)isRemoveButton
{
    _isRemoveButton = isRemoveButton;
    //统一创建闪聊按钮
    if (self.isRemoveButton) {
        //自定义ButtonItem
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 30, 20)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"u65_normal.png"] forState:UIControlStateNormal];
        [backButton setTitle:@"清除" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(isRemoveButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.rightBarButtonItem = backItem;
    }
    
}

#pragma mark------customMethod
- (void)buttonItemClickAction
{
        [self.navigationController popViewControllerAnimated:YES];
        
}
@end
