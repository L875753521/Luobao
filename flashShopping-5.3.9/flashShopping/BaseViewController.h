//
//  BaseViewController.h
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic , retain)UILabel *titleLabel;   //导航标题

@property (nonatomic , assign)BOOL isBack;  //是否自定义返回按钮
@property (nonatomic , assign)BOOL isAddRefreshButton; //是否自定义刷新按钮
@property (nonatomic , assign)BOOL isRightBarButtonChat; //是否自定义闪聊按钮
@property (nonatomic , assign)BOOL isMoreBackButton; //是否自定义返回按钮
@property (nonatomic , assign)BOOL isCompleteButton; //是否自定义完成按钮
@property (nonatomic , assign)BOOL isSetUPButton;//是否自定义设置按钮
@property (nonatomic , assign)BOOL isRemoveButton;//清除按钮

@end
