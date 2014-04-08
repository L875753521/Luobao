//
//  ModifyOrderPriceViewController.m
//  flashShopping
//
//  Created by sg on 14-3-13.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ModifyOrderPriceViewController.h"
#import "NSString+URLEncoding.h"


@interface ModifyOrderPriceViewController ()

@end

@implementation ModifyOrderPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRequestURLStr:(NSString *)requestURLStr withOrderCode:(NSString *)aOrderCode{
    
    
    self = [super init];
    if (self) {
        self.requestURLStr = requestURLStr;
        self.orderCode = aOrderCode;
    }
    return self;
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
    titleLabel.text = @"修改价格" ;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.userInteractionEnabled = YES;
    
    self.navigationItem.titleView = titleLabel;
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"complete.png"] forState:UIControlStateNormal];
    [commitBtn setFrame:CGRectMake(10, 7, 50, 30)];
    [commitBtn addTarget:self action:@selector(commitNewPrice:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [vie addSubview:commitBtn];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vie];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    
}

#pragma mark -
#pragma mark UIWebViewDelegate Method

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString *urlString = [[request URL] absoluteString];
    
    NSLog(@"urlString is %@",urlString);
    //    http://192.168.1.16:8080/Assistant/show
    
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
        
        //
        //        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
        //        [MMProgressHUD showWithTitle:@"请稍等" status:@"正在提交..."];
        return NO;
        
    }
    
    /*
     http://192.168.1.16:8080/Assistant/dialog%7C%E5%85%B3%E9%97%AD%E8%AE%A2%E5%8D%95%E6%88%90%E5%8A%9F
     
     http://192.168.1.16:8080/Assistant/20140304144502453701%7Chttp://192.168.1.16:8080/Assistant/appWeb/orderChangePrice.jsp
     
     */
    NSArray *tempArr = [urlString componentsSeparatedByString:@"%7C"];
    if (tempArr.count > 1) {
        NSString *tempStr = [tempArr firstObject];
        if ([tempStr hasSuffix:@"dialog"]){
            NSString *showStr = [tempArr lastObject];
            showStr = [showStr URLDecodedString];
            
            [_indicator stopAnimating];
            //            [MMProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"%@",showStr]];
            [_webView endEditing:YES];
            return NO;
            
        }
        
    }
    return YES;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}



- (void)commitNewPrice:(UIButton *)sender{
    if (self.orderCode) {
        
        [self performSelectorOnMainThread:@selector(JSAciotn4Commnit) withObject:nil waitUntilDone:NO];
    }
}

- (void)JSAciotn4Commnit{
    
    self.orderCode = [self.orderCode stringByReplacingOccurrencesOfString:@"\n" withString:@"\\\\n"];
    NSString *JSAction4CommitNewPrice = [NSString stringWithFormat:@"success(\"%@\")",self.orderCode];
    NSLog(@"jsAction is %@   AND is main Thread %i",JSAction4CommitNewPrice,[NSThread isMainThread]);
    
    [_webView stringByEvaluatingJavaScriptFromString:JSAction4CommitNewPrice];
    
    //    NSLog(@"%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
