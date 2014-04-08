//
//  FeedbackViewController.m
//  flashShopping
//
//  Created by sg on 14-3-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "FeedbackViewController.h"


@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize opinion = _opinion;

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
    self.titleLabel.text = @"意见反馈";
    
    self.view.backgroundColor = [UIColor whiteColor];

	
    
    [self createCommitBtn];
    [self loadMainView];
    
    
}
- (void)createCommitBtn{
    
    
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 40, 25) andSetdelegate:self andImageName:@"Submit"];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
    
    self.navigationItem.rightBarButtonItem = barButtonItem ;

}

- (void)actions:(id)sender
{
    NSLog(@"保存");
    
    [self showIndicator];
    
    [self performSelector:@selector(requestFinish:) withObject:nil afterDelay:2];
    
}
- (void)showIndicator{
    
    _indicator = nil;
    _indicator = (UIActivityIndicatorView *)[self.view viewWithTag:103];
    
    if (_indicator == nil) {
        
        //初始化:
        _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 120.0f)];
        
        _indicator.tag = 103;
        
        //设置显示样式,见UIActivityIndicatorViewStyle的定义
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        
        
        //设置背景色
        _indicator.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc] init];
        //                lab.frame = CGRectMake(20, 70, 100, 30);
        lab.bounds = CGRectMake(0.0f, 0.0f, 150.0f, 30.0f);
        lab.center = CGPointMake(_indicator.center.x, _indicator.center.y + 35);
        lab.textAlignment = UITextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.text = @"正在提交中...";
        lab.textColor = [UIColor blackColor];
        lab.backgroundColor = [UIColor clearColor];
        [_indicator addSubview:lab];
        //设置背景透明
        _indicator.alpha = 0.9;
        
        //设置背景为圆角矩形
        _indicator.layer.cornerRadius = 6;
        _indicator.layer.masksToBounds = YES;
        //设置显示位置
        [_indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
        _indicator.color = [UIColor blackColor];
        //开始显示Loading动画
        [_indicator startAnimating];
        
        [self.view addSubview:_indicator];
        
    }
    
    //开始显示Loading动画
    [_indicator startAnimating];
    
}
- (void)requestFinish:(id)sender{
    
    [_indicator stopAnimating];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示:" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];

    
}

- (void)loadMainView{
    
//    UIImageView *opinionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, IOS7?75.0f:15.0f, SCREENMAIN_WIDTH - 20.0f, self.view.bounds.size.height - IOS7?150.0f:410.0f)];
//    
//    opinionImgView.image = [UIImage imageNamed:@"textFieldView"];
//    opinionImgView.userInteractionEnabled = YES;
//    [self.view addSubview:opinionImgView];
    
    _opinion = [[UITextView alloc] init];
//    _opinion.frame = CGRectMake(0.0f, 0.0f, SCREENMAIN_WIDTH - 20.0f, self.view.bounds.size.height - IOS7?150.0f:410.0f);
    _opinion.frame = CGRectMake(10.0f, IOS7?74.0f:14.0f, SCREENMAIN_WIDTH - 20.0f, self.view.bounds.size.height - IOS7?149.0f:409.0f);
    _opinion.delegate = self;
    
    //    _opinion.backgroundColor = [UIColor redColor];
    _opinion.textAlignment = NSTextAlignmentLeft;
    _opinion.layer.cornerRadius = 6;
    _opinion.layer.masksToBounds = YES;
    _opinion.layer.borderWidth = 1;
    _opinion.layer.borderColor = [[UIColor grayColor] CGColor];
    _opinion.font = [UIFont systemFontOfSize:16];
    [_opinion becomeFirstResponder];
//    _opinion.placeholder = @"闪购客服电话：400-638-1819，欢迎来电！也可以在此留言！";
    _opinion.text = @"闪购客服电话：400-638-1819，欢迎来电！也可以在此留言！";
    [self.view addSubview:_opinion];
    
    
    _contact = [[UITextField alloc] initWithFrame:CGRectMake(10.0f,IOS7?230.0f:180.0f, SCREENMAIN_WIDTH - 20.0f, 30.0f)];
    _contact.placeholder = @"  亲们可以在此留下联系方式";
    _contact.textAlignment = NSTextAlignmentLeft;
    _contact.layer.borderColor = [[UIColor grayColor] CGColor];
    _contact.layer.cornerRadius = 6;
    _contact.layer.masksToBounds = YES;
    _contact.layer.borderWidth = 1;
    _contact.delegate = self;
    
    //边框样式
    _contact.borderStyle = UITextBorderStyleNone ;
    //清晰的按钮模式
    _contact.clearButtonMode = UITextBorderStyleNone ;
    //内容垂直对齐
    _contact.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    //自动大写输入
    _contact.autocapitalizationType = UITextAutocapitalizationTypeNone ;
    //键盘类型
    _contact.keyboardType = UIKeyboardTypeASCIICapable;
    //回车键类型
    _contact.returnKeyType = UIReturnKeyNext;

    _contact.font = [UIFont systemFontOfSize:14];
//    _contact.backgroundColor = [UIColor redColor];
    [self.view addSubview:_contact];

}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSRange range;
    range.location = 0;
    range.length  = 0;
    textView.selectedRange = range;
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
 
}
//Enter做键盘的响应键
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
