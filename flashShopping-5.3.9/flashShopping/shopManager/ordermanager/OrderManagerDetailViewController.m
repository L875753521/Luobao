//
//  OrderManagerDetailViewController.m
//  flashShopping
//
//  Created by sg on 14-3-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "OrderManagerDetailViewController.h"
//#import "MMProgressHUD.h"
#import "NSString+URLEncoding.h"
#import "ModifyOrderPriceViewController.h"
#import "ShipmentsAndModifyAddViewController.h"

@interface OrderManagerDetailViewController ()

@end

@implementation OrderManagerDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRequestURLStr:(NSString *)requestURLStr{
    
    
    self = [super init];
    if (self) {
        self.requestURLStr = requestURLStr;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.isBack = YES;
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT + 49)];
    NSLog(@"===========%@",NSStringFromCGRect(_webView.frame));
    _webView.delegate = self;
    _webView.userInteractionEnabled = YES;
    [self.view addSubview:_webView];
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestURLStr]]];
    
    //自定义导航标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 34)];
    titleLabel.text = @"订单详情" ;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.userInteractionEnabled = YES;
    
    self.navigationItem.titleView = titleLabel;
    
    UIButton *chatNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [chatNow setBackgroundImage:[UIImage imageNamed:@"chatButton"] forState:UIControlStateNormal];
    [chatNow setFrame:CGRectMake(10, 7, 40, 30)];
    [chatNow addTarget:self action:@selector(chatNow:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [vie addSubview:chatNow];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vie];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)chatNow:(UIButton *)sender{
    
    NSLog(@"%s",__FUNCTION__);
    
}

#pragma mark -
#pragma mark UIWebViewDelegate Method

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString *urlString = [[request URL] absoluteString];
    
    NSLog(@"urlString is %@",urlString);
    //    http://192.168.1.16:8080/Assistant/show
    
    //    调用电话
    if ([urlString hasPrefix:@"tel"]) {
        
        NSArray *telTempArr = [urlString componentsSeparatedByString:@":"];
        if (telTempArr.count == 2) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[telTempArr lastObject]]]];
            NSLog(@"%@",[NSString stringWithFormat:@"tel://%@",[telTempArr lastObject]]);
        }
        
        
        return NO;
    }
    
    //    调用信息
    if ([urlString hasPrefix:@"sms"]) {
        
        NSArray *telTempArr = [urlString componentsSeparatedByString:@":"];
        if (telTempArr.count == 2) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",[telTempArr lastObject]]]];
        }
        
        return NO;
    }
    //    调用提示页面
    if ([urlString hasSuffix:@"show"]) {
        
        _indicator = nil;
        _indicator = (UIActivityIndicatorView *)[self.view viewWithTag:103];
        
        if (_indicator == nil) {
            
            //初始化:
            _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 120.0f)];
            
            _indicator.tag = 103;
            
            //设置显示样式,见UIActivityIndicatorViewStyle的定义
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            
            
            //设置背景色
            _indicator.backgroundColor = [UIColor blackColor];
            
            UILabel *lab = [[UILabel alloc] init];
            //                lab.frame = CGRectMake(20, 70, 100, 30);
            lab.bounds = CGRectMake(0.0f, 0.0f, 150.0f, 30.0f);
            lab.center = CGPointMake(_indicator.center.x, _indicator.center.y + 35);
            lab.textAlignment = UITextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:13];
            lab.text = @"提交中...";
            lab.textColor = [UIColor whiteColor];
            [_indicator addSubview:lab];
            //设置背景透明
            _indicator.alpha = 0.9;
            
            //设置背景为圆角矩形
            _indicator.layer.cornerRadius = 6;
            _indicator.layer.masksToBounds = YES;
            //设置显示位置
            [_indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
            
            //开始显示Loading动画
            [_indicator startAnimating];
            
            [self.view addSubview:_indicator];
            
        }
        
        //开始显示Loading动画
        [_indicator startAnimating];
        //        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
        //        [MMProgressHUD showWithTitle:@"请稍等" status:@"正在关闭..."];
        return NO;
        
    }
    
    
    /*
     http://192.168.1.16:8080/Assistant/dialog%7C%E5%85%B3%E9%97%AD%E8%AE%A2%E5%8D%95%E6%88%90%E5%8A%9F
     
     http://192.168.1.16:8080/Assistant/20140304144502453701%7Chttp://192.168.1.16:8080/Assistant/appWeb/orderChangePrice.jsp
     
     http://192.168.1.16:8080/Assistant/20140304144502453701%7Chttp://192.168.1.16:8080/Assistant/appWeb/orderFashouDetail.jsp
     
     
     */
    NSArray *tempArr = [urlString componentsSeparatedByString:@"%7C"];
    
    if (tempArr.count > 1) {
        NSString *tempStr = [tempArr firstObject];
        
        //        取消提示页面
        if ([tempStr hasSuffix:@"dialog"]){
            
            [_indicator stopAnimating];
            //            NSString *showStr = [tempArr lastObject];
            //            showStr = [showStr URLDecodedString];
            //            [MMProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"%@",showStr]];
            
            return NO;
            
        }else{
            tempStr = [tempArr firstObject];
            NSArray *orderCodeArr = [tempStr componentsSeparatedByString:@"/"];
            NSString *orderCodeStr = [orderCodeArr lastObject];
            NSString *forwordURL = [tempArr lastObject];
            
#warning companyId
            
            NSString *companyId = [[NSUserDefaults standardUserDefaults] objectForKey:@"entId"];
            NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
            NSString *finalForwordURL = [NSString stringWithFormat:@"%@?orderCode=%@&companyId=%@&userId=%@",forwordURL,orderCodeStr,companyId,userId];
            
            
            //               切开请求字符串  分开访问类别   发货   修改订单
            
            NSArray *forwordStyleArr = [forwordURL componentsSeparatedByString:@"/"];
            
            NSString *forwordStyleStr = [forwordStyleArr lastObject];
            //            修改价钱
            if ([forwordStyleStr isEqualToString:@"orderChangePrice.jsp"]) {
                
                ModifyOrderPriceViewController *modifyOrderPriceVC = [[ModifyOrderPriceViewController alloc] initWithRequestURLStr:finalForwordURL withOrderCode:orderCodeStr];
                [self.navigationController pushViewController:modifyOrderPriceVC animated:YES];
                
            }
            //               发货
            if ([forwordStyleStr isEqualToString:@"orderFashouDetail.jsp"]) {
                
                ShipmentsAndModifyAddViewController *shipmentsAndModifyAddVC = [[ShipmentsAndModifyAddViewController alloc] initWithRequestURLStr:finalForwordURL withOrderCode:orderCodeStr WithOptinStyleIsShipments:YES];
                [self.navigationController pushViewController:shipmentsAndModifyAddVC animated:YES];
                
            }
            if ([forwordStyleStr isEqualToString:@"orderChangeAddress.jsp"]) {
                ShipmentsAndModifyAddViewController *shipmentsAndModifyAddVC = [[ShipmentsAndModifyAddViewController alloc] initWithRequestURLStr:finalForwordURL withOrderCode:orderCodeStr WithOptinStyleIsShipments:NO];
                [self.navigationController pushViewController:shipmentsAndModifyAddVC animated:YES];
            }
            
            
            
            return NO;
            
        }
        
    }
    return YES;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
