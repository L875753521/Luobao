//
//  ViewController.m
//  flashShopping
//
//  Created by Width on 14-1-10.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LandViewController.h"
#import "MainViewController.h"
#import "SGDataService.h"
#import "Reachability.h"
#import "LoginJudgeSingleton.h"

@interface LandViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *scrollView ;
    UIImageView *imageViewBg ;
    UIView *langView ;
    UITextField *userName ;
    UITextField *userPossWord ;
    UIButton *StatusButton ;
    BOOL flay;
    
    
//    NSUserDefaults *userDefaults ;
    
}
- (void)loadLandView ;

@end

@implementation LandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //初始化登陆界面并存数据
    [self loadLandView];
    
    //存完再取
    [self loadUserDefaultsData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        [langView setFrame:CGRectMake(10,imageViewBg.bottom + 20 , SCREENMAIN_WIDTH-20, 170)];
    }];
    
}
#pragma mark----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
#pragma mark-------
- (void)loadLandView
{
    
    //总体是个UIScrollView
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT + 60);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.userInteractionEnabled = YES ;
    [self.view addSubview:scrollView];
    
    //最上面得logo
    imageViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, 145)];
    imageViewBg.userInteractionEnabled = YES ;
    imageViewBg.image = [UIImage imageNamed:@"landLogo.jpg"];
    [scrollView addSubview:imageViewBg];
    
    
    //用户名／密码／是否记住／登陆的父视图
    langView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREENMAIN_HEIGHT, SCREENMAIN_WIDTH - 20, 170)];
    langView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:langView];
    
    
    //用户名／密码的背景图
    UIImageView *landViewBg = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, langView.width, 89)];
    landViewBg.userInteractionEnabled = YES ;
    landViewBg.image = [UIImage imageNamed:@"langImgbg"] ;
    landViewBg.backgroundColor = [UIColor clearColor];
    [langView addSubview:landViewBg];
    
    
    //用户名textField
    userName = [[UITextField alloc]initWithFrame:CGRectMake(10, IOS7?3:13, landViewBg.width - 5, 45)];
    userName.delegate = self ;
    //边框样式
    userName.borderStyle = UITextBorderStyleNone ;
    userName.placeholder = @"请输入用户名" ;
    //清晰的按钮模式
    userName.clearButtonMode = UITextBorderStyleNone ;
    //内容垂直对齐
    userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    //自动大写输入
    userName.autocapitalizationType = UITextAutocapitalizationTypeNone ;
    //键盘类型
    userName.keyboardType = UIKeyboardTypeASCIICapable;
    //回车键类型
    userName.returnKeyType = UIReturnKeyNext;
    
    [landViewBg addSubview:userName];
    
    
    //密码textField
    userPossWord = [[UITextField alloc]initWithFrame:CGRectMake(10, IOS7?45:43, landViewBg.width - 5, 45)];
    userPossWord.delegate = self ;
    userPossWord.borderStyle = UITextBorderStyleNone ;
    userPossWord.returnKeyType = UIReturnKeyGo;
    userPossWord.placeholder = @"请输入密码" ;
    //安全的文本输入
    userPossWord.secureTextEntry = YES ;
    userPossWord.clearButtonMode = UITextFieldViewModeAlways;
    userPossWord.keyboardType = UIKeyboardTypeASCIICapable;
    userPossWord.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userPossWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [landViewBg addSubview:userPossWord];
    
    
    //是否记住用户名和密码
    StatusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [StatusButton setFrame:CGRectMake(15, userPossWord.bottom + 10, 20, 20)];
    [StatusButton setBackgroundImage:[UIImage imageNamed:@"remember"] forState:UIControlStateNormal];
     [StatusButton setBackgroundImage:[UIImage imageNamed:@"remember_bg"] forState:UIControlStateSelected];
    
    
    [StatusButton addTarget:self action:@selector(isRememberUserName:) forControlEvents:UIControlEventTouchUpInside];
    
    [langView addSubview:StatusButton];
    
    
    //记住用户名label
    UILabel *isRememberLabel = [[UILabel alloc]initWithFrame:CGRectMake(StatusButton.right + 20, userPossWord.bottom + 10, 20, 20)];
    isRememberLabel.text = @"记住用户名" ;
    
    isRememberLabel.backgroundColor = [UIColor clearColor];
    [isRememberLabel sizeToFit];
    [langView addSubview:isRememberLabel];
    
    
    //登陆按钮
    UIButton *landButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [landButton setFrame:CGRectMake(0, langView.height - 40, langView.width, 40)];
    [landButton setBackgroundImage:[UIImage imageNamed:@"landButton"] forState:UIControlStateNormal];
    [landButton addTarget:self action:@selector(landButton:) forControlEvents:UIControlEventTouchUpInside];
    [langView addSubview:landButton];
}


- (void)isRememberUserName:(UIButton*)button
{
    
    NSString *valueBtn = @"ON";
    
    NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
    
    
    if (flay) {
        
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"remember@x2"] forState:UIControlStateNormal];
        
        valueBtn = @"OFF";
        [userPreferences setObject:valueBtn forKey:@"stateOfButton"];
        
        //没选中时就把数据删掉
        [userPreferences removeObjectForKey:@"userName"];
        [userPreferences removeObjectForKey:@"userPossWord"];
        
        NSLog(@"删除");

        flay = NO;
        
    }else{
        
        NSLog(@"保存");
        button.Selected = YES;
        
        [button setImage:[UIImage imageNamed:@"Remember_bg@x2"] forState:UIControlStateSelected];
        
        valueBtn = @"ON";
        [userPreferences setObject:valueBtn forKey:@"stateOfButton"];
        
        //保存用户名、密码
        [userPreferences setObject:userName.text forKey:@"userName"];
        [userPreferences setObject:userPossWord.text forKey:@"userPossWord"];

        flay = YES;
        
    }
    

    //同步数据
    [userPreferences synchronize];
    
}

- (void)loadUserDefaultsData
{
    
    //从NSUserDefaults里读取数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    userName.text = [userDefaults objectForKey:@"userName"];
    userPossWord.text = [userDefaults objectForKey:@"userPossWord"];
    
    
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"stateOfButton"];
    
    if (value == nil) {
        
        StatusButton.selected = NO;
        flay = NO;
    }
    else if([value compare:@"ON"] == NSOrderedSame)
    {
        StatusButton.selected = YES;
        flay = YES;
        
    }else{
        
        StatusButton.selected = NO;
        flay = NO;
    }

}

#pragma mark------登陆
- (void)landButton:(UIButton*)button
{
    //检查网络
    BOOL reachable = [[Reachability reachabilityForInternetConnection] isReachable];
    
    if (!reachable) {
        UIAlertView *alertViews = [[UIAlertView alloc] initWithTitle:@"该功能需要连接网络才能使用，请检查您的网络连接状态" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
        [alertViews show];
        return;
    }
    //访问接口
    NSDictionary *dict = @{@"actionCode":@"21" ,  @"appType":@"json" };
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [mutableDict setObject:userName.text forKey:@"username"] ;
    [mutableDict setObject:userPossWord.text forKey:@"password"] ;
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        if ([result[@"content"] isKindOfClass:[NSDictionary class]]){
            
            //取数据
            NSString *companyId     = result[@"content"][@"entId"] ;
            NSString *companyName   = result[@"content"][@"name"] ;
            NSString *companyUserId = result[@"content"][@"userId"] ;
            
            //将entId和userId保存到userDefaults中
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:companyId forKey:@"entId"] ;
            [userDefaults setObject:companyName forKey:@"name"];
            [userDefaults setObject:companyUserId forKey:@"userId"];
            
//            将数据保存到单例类中
            [[LoginJudgeSingleton shareLoginJudge] saveObject:companyId forKey:COMPANYIDSINGLETON];
            [[LoginJudgeSingleton shareLoginJudge] saveObject:companyName forKey:COMPANYNAMESINGLETON];
            [[LoginJudgeSingleton shareLoginJudge] saveObject:companyUserId forKey:COMPANYUSERIDSINGLETON];
            
            
//            //保存用户名、密码
//            [userDefaults setObject:userName.text forKey:@"userName"];
//            [userDefaults setObject:userPossWord.text forKey:@"userPossWord"];
//            [userDefaults synchronize];
            
//            MainViewController *mainViewCtl = [[MainViewController alloc]init];
//            mainViewCtl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//            
//            [self presentModalViewController:mainViewCtl animated:YES];
            
            [[LoginJudgeSingleton shareLoginJudge] setLogin:YES];
        
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessNotification" object:nil];
            
            [self dismissModalViewControllerAnimated:YES];
            
        }else{
            
            NSLog(@"登录失败");
            UIAlertView *alertView =[ [UIAlertView alloc]initWithTitle:@"友情提示" message:result[@"content"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"返回", nil];
            [alertView show] ;
        }
    }];
    
}
#pragma mark -
#pragma mark UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (1 == buttonIndex) {
        
        [self dismissModalViewControllerAnimated:YES];
        
    }
    
}

#pragma mark------MemoryManagement
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
