//
//  LoadLogoViewController.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-17.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LoadLogoViewController.h"
#import "LandViewController.h"
#import "NoLogingViewController.h"
#import "MainViewController.h"

@interface LoadLogoViewController ()

@end

@implementation LoadLogoViewController{
    
    NSTimer *timer ;
}
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
    UIImageView *startImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT)];
    startImage.contentMode = UIViewContentModeScaleToFill;
    startImage.image = [UIImage imageNamed:@"startPage.jpg"];
    [self.view addSubview:startImage];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startMainView:) userInfo:startImage repeats:NO];
}
- (void)startMainView:(NSTimer*)temp{
    
    UIImageView *imageView = [temp userInfo];
    [UIView animateWithDuration:1.0 animations:^{
        
        imageView.alpha = 0;
        
    }completion:^(BOOL finish){
//        NoLogingViewController *nologingViewCtl = [[NoLogingViewController alloc] init];
        MainViewController *mainViewCtl = [[MainViewController alloc] init];
//        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self presentViewController:mainViewCtl animated:YES completion:nil];
        //加载完根视图后删除启动画面同时销掉计时器
        [imageView removeFromSuperview];
        [timer invalidate];
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
