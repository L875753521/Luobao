//
//  MoreViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "MoreViewController.h"
#import "SelectRowViewController.h"
#import "FeedbackViewController.h"
#import "TKAlertCenter.h"
#import "AboutUsViewController.h"
#import "LandViewController.h"

typedef enum {
    kAboutUsOperation = 0,
    kNewbiesOperation,
    kVersionsCheckOperation,
    kFeedbackOperation,
    kEncourageOperation,
    kClearCacheOperation
}kOperationTpye;

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *moreTableView;
    NSArray *titleArr;
}

@end

@implementation MoreViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomePagebackground"]];
    
    self.titleLabel.text = @"更多";
    
    moreTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREENMAIN_WIDTH, self.view.bounds.size.height - 20.0f) style:UITableViewStyleGrouped];
    moreTableView.dataSource = self;
    moreTableView.delegate = self;
    moreTableView.layer.cornerRadius = 6;
    moreTableView.layer.masksToBounds = YES;
    
    //    moreTableView.bounces = YES;
    //    moreTableView.layer.borderWidth = 1;
    //    moreTableView.layer.borderColor = [[UIColor blackColor] CGColor];
    //    moreTableView.separatorColor = [UIColor blackColor];
    
    //    moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //     UITableViewCellSeparatorStyleSingleLine  UITableViewCellSeparatorStyleSingleLineEtched
    [self.view addSubview:moreTableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:postNoteName object:nil];
    titleArr=[NSArray arrayWithObjects:@"关于我们",@"新手入门",@"版本检测",@"意见反馈",@"打分鼓励一下",@"清除本地缓存", nil];
}
- (void)getData:(NSNotification*)note
{
    NSLog(@">>>>>>%@",[note object]);
}


#pragma mark----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return titleArr.count;
    }else{
        return 1;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = titleArr[indexPath.row];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"闪购客服电话：400-638-1819";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else {
        cell.textLabel.text = @"退出应用";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 25;
    }return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                //关于我们
            case kAboutUsOperation:
                
            {
                AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
                [self.navigationController pushViewController:aboutUsVC animated:YES];
                
            }
                break;
                
                //            新手入门
            case kNewbiesOperation:
            {
                
            }
                break;
                //            版本检测
            case kVersionsCheckOperation:
            {
                [self showIndicator];
                
                [self performSelector:@selector(requestFinish:) withObject:nil afterDelay:2];
                
            }
                break;
                //            意见反馈
            case kFeedbackOperation:
            {
                FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] init];
                //                feedbackVC.title = @"意见反馈";
                [self.navigationController pushViewController:feedbackVC animated:YES];
                
            }
                break;
                //            打分鼓励一下
            case kEncourageOperation:
            {
                
                
            }
                break;
                //            清楚缓存
            case kClearCacheOperation:
            {
                [[TKAlertCenter defaultCenter ] postAlertWithMessage:@"缓存已清除!" image:[UIImage imageNamed:@"chatButton"]];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
    //
    //    if (indexPath.section==0) {
    //        if (indexPath.row == 0) {
    //            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
    //            [self.navigationController pushViewController:aboutUsVC animated:YES];
    //            return;
    //        }
    //        if (indexPath.row==2) {
    //
    //
    //            [self showIndicator];
    //
    //            [self performSelector:@selector(requestFinish:) withObject:nil afterDelay:2];
    //
    //
    //            return;
    //        }
    //        if (indexPath.row == 3) {
    //            FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] init];
    ////            feedbackVC.title = @"意见反馈";
    //            [self.navigationController pushViewController:feedbackVC animated:YES];
    //
    //            return;
    //        }
    ////        清除本地缓存
    //        if (indexPath.row == 5) {
    //            [[TKAlertCenter defaultCenter ] postAlertWithMessage:@"缓存已清除!" image:[UIImage imageNamed:@"chatButton"]];
    //            return;
    //
    //        }
    //        SelectRowViewController *selectRowView=[[SelectRowViewController alloc]init];
    //        selectRowView.navgationTitle=titleArr[indexPath.row];
    //        [self.navigationController pushViewController:selectRowView animated:YES];
    //    }
    if(indexPath.section == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006381819"]];
    }
    if (indexPath.section == 2) {
        
//        [UIView beginAnimations:@"exitApplication" context:nil];
//        [UIView setAnimationDuration:0.5];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view cache:NO];
//        [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
//        self.view.bounds = CGRectMake(0, 0, 0, 0);
//        [UIView commitAnimations];
        
        LandViewController *landViewClt = [[LandViewController alloc] init];
        landViewClt.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
        [self presentModalViewController:landViewClt animated:YES];
    }
    
}
//- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
//    
//    if ([animationID compare:@"exitApplication"] == 0) {
//        
//        exit(0);
//        
//    }
//    
//}

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
        _indicator.backgroundColor = [UIColor blackColor];
        
        UILabel *lab = [[UILabel alloc] init];
        //                lab.frame = CGRectMake(20, 70, 100, 30);
        lab.bounds = CGRectMake(0.0f, 0.0f, 150.0f, 30.0f);
        lab.center = CGPointMake(_indicator.center.x, _indicator.center.y + 35);
        lab.textAlignment = UITextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.text = @"版本检测中...";
        lab.textColor = [UIColor whiteColor];
        lab.backgroundColor = [UIColor clearColor];
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
    
}
- (void)requestFinish:(id)sender{
    
    [_indicator stopAnimating];
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂无更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}

#pragma mark----Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
