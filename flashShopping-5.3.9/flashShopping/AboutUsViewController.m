//
//  AboutUsViewController.m
//  flashShopping
//
//  Created by sg on 14-3-4.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "AboutUsViewController.h"


#define HEIGHT  IOS7?160:80

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    
	self.titleLabel.text = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u10_normal"]];
    
    imgView.frame = CGRectMake(40, HEIGHT, 60, 100);
    
    [self.view addSubview:imgView];
    
    
    UILabel *companyNameLab = [[UILabel alloc] initWithFrame:CGRectMake(110, HEIGHT, 180, 40)];
    companyNameLab.textAlignment = NSTextAlignmentRight;
    companyNameLab.text = @"闪购";
    companyNameLab.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:companyNameLab];
    
    UILabel *purposeLab = [[UILabel alloc] init];
    purposeLab.bounds = companyNameLab.bounds;
    purposeLab.center = CGPointMake(companyNameLab.center.x, companyNameLab.center.y + 35);
    purposeLab.textAlignment = NSTextAlignmentRight;
    purposeLab.font = [UIFont systemFontOfSize:15];
    purposeLab.text = @"真品质  手机购物";
    [self.view addSubview:purposeLab];
    
    UILabel *companyNumberLab = [[UILabel alloc] init];
    companyNumberLab.bounds = companyNameLab.bounds;
    companyNumberLab.center = CGPointMake(companyNameLab.center.x, companyNameLab.center.y + 70);
    companyNumberLab.textAlignment = NSTextAlignmentRight;
    companyNumberLab.font = [UIFont systemFontOfSize:15];
    companyNumberLab.text = @"客服电话：400-638-1819";
    [self.view addSubview:companyNumberLab];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
