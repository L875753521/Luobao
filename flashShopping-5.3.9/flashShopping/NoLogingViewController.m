//
//  NoLogingViewController.m
//  flashShopping
//
//  Created by SG on 14-4-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "NoLogingViewController.h"
#import "LandViewController.h"
//#import "BaseNavViewController.h"

typedef enum{
    kWait4shipmentLabel = 0,
    kWait4RefundLabel,
    kStockoutLabel,
    kWait4PaymentLabel
}kLabelTpye;


@interface NoLogingViewController ()

@end

@implementation NoLogingViewController{
    UITableView *testView;
    UIImageView *topImageView;
    UIImageView *processedImage;
    UIImageView *shopManagerView;
    
    NSMutableArray *showImgArr;
    NSInteger _curPage;
    NSMutableArray *allArr;
    NSMutableArray *currentDataArr;
    
    //所有管理UI布局
    UILabel *_titleLabel;
    UILabel *_digitalLabel;
    UIButton *_processedButton;
    
    //4个显示数量的label
    UILabel *wait4ShipmentLab;
    UILabel *wait4RefundLabel;
    UILabel *stockoutLabel;
    UILabel *wait4PaymentLabel;
    NSArray *labelArr;
    
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
    
    //修改状态栏的背景色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //实例化4个label显示
    wait4ShipmentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    wait4RefundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    stockoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    wait4PaymentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    //将4个label添加到数组中
    labelArr = @[wait4ShipmentLab,wait4RefundLabel,stockoutLabel,wait4PaymentLabel];
    
    
    //判断ios版本号通过版本号来布坐标
    testView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOS7?0:0, SCREENMAIN_WIDTH,iPhone5?568:480) style:UITableViewStylePlain];
    
    testView.backgroundColor = [UIColor blackColor];
    //    testView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    
    testView.delegate = self;
    testView.dataSource = self;
    testView.scrollEnabled = NO;//禁止滑动
    testView.separatorStyle = NO;//去除分割线
    [self.view addSubview:testView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
//顶部view
- (void)currentTopView
{
    topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT == 480?110:138)];
    topImageView.image = [UIImage imageNamed:@"topView_background"];
    UIImageView *septwolvesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREENMAIN_HEIGHT == 480? 13:25, 90, 90)];
    septwolvesImageView.image = [UIImage imageNamed:@"topView_01"];
    [topImageView addSubview:septwolvesImageView];
    
    topImageView.userInteractionEnabled = YES;//打开点出事件
    //    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(107, SCREENMAIN_HEIGHT == 480? 20:28, 160, 40)];
    UILabel *name = [[UILabel alloc] init];
    name.text = @"未登录";
    
    CGSize size = [COMPANYNAME sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(160, 80) lineBreakMode:NSLineBreakByCharWrapping];
    name.frame = CGRectMake(107, SCREENMAIN_HEIGHT == 480 ? 20:28, 160, size.height);
    name.numberOfLines = 0;
    name.textColor = [UIColor whiteColor];
    name.backgroundColor = [UIColor clearColor];
    //    name.font = [UIFont systemFontOfSize:20];
    [topImageView addSubview:name];
    
    UILabel *shopMvoingName = [[UILabel alloc] initWithFrame:CGRectMake(140, SCREENMAIN_HEIGHT == 480? 70:87.5f, 130, 23)];
    shopMvoingName.text = @"查看店铺首页";
    shopMvoingName.textColor = [UIColor colorWithRed:136/255.0 green:34/255.0 blue:48/255.0 alpha:1.0];//#882230
    shopMvoingName.font = [UIFont systemFontOfSize:18];
    shopMvoingName.backgroundColor = [UIColor clearColor];
    [topImageView addSubview:shopMvoingName];
    
    //店铺首页
    UIButton *storeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [storeViewBtn setFrame:CGRectMake(110, SCREENMAIN_HEIGHT == 480? 70:87.5f, 23, 23)];
    [storeViewBtn setBackgroundImage:[UIImage imageNamed:@"topView_02_2"] forState:UIControlStateNormal];
    storeViewBtn.showsTouchWhenHighlighted = YES ;
    storeViewBtn.tag = 101;
    [storeViewBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:storeViewBtn];
    
    //信息
    UIButton *lettersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lettersBtn.frame = CGRectMake(275, SCREENMAIN_HEIGHT == 480? 30:38.0f, 30, 20);
    [lettersBtn setBackgroundImage:[UIImage imageNamed:@"topView_03"] forState:UIControlStateNormal];
    [lettersBtn addTarget:self action:@selector(myTapClick) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:lettersBtn];
    
    //小红圈
    UIImageView *loopsView = [[UIImageView alloc] initWithFrame:CGRectMake(295, SCREENMAIN_HEIGHT == 480? 22:27.5f, 20, 20)];
    loopsView.image = [UIImage imageNamed:@"topView_13"];
    [topImageView addSubview:loopsView];
    
    //圈中的数字
    UILabel *loopsLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, SCREENMAIN_HEIGHT == 480? 1:1.25f, 17, 17)];
    loopsLabel.text = @"0";
    //因为系统6.0时，背景色默认为白色
    loopsLabel.backgroundColor = [UIColor clearColor];
    loopsLabel.font = [UIFont systemFontOfSize:14];
    loopsLabel.textColor = [UIColor whiteColor];
    [loopsView addSubview:loopsLabel];
    
    //    [topView addSubview:topImageView];
}
- (void)click:(UIButton *)b
{
    NSLog(@"===========店铺首页");
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"pull" object:b];
    
}
- (void)myTapClick
{
    NSLog(@"进入聊天页面");
}
//商品详情View
- (void)currentGoodsDetailsView
{
    processedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT == 480? 150:180)];
    
    processedImage.image = [UIImage imageNamed:@"HomePagebackground"];
    processedImage.userInteractionEnabled = YES;
    
    NSArray *imgArr = @[@"processedImage_1",@"processedImage_2",@"processedImage_3",@"processedImage_4"];
    NSArray *titleArr = @[@"待发货订单",@"待退款订单",@"缺货商品",@"待付款订单"];
    NSMutableArray *digitalArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    
    for (int i = 0; i < 4; i++) {
        
        _processedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_processedButton setBackgroundImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        
        _processedButton.tag = 510+i;
        
        if (i == 2) {
            
            //button3
            _processedButton.frame = CGRectMake(220, 10, 90, SCREENMAIN_HEIGHT == 480? 135:168);
            
            //标题3
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENMAIN_HEIGHT == 480? 95:110.0f, 90, 20)];
            
            //数字3
            UILabel *lab = (UILabel *)[labelArr objectAtIndex:i];
            lab.frame = CGRectMake(0-5, 0-7, 100, 60);
            lab.text = [digitalArr objectAtIndex:i];
            lab.textColor = [UIColor whiteColor];
            lab.backgroundColor = [UIColor clearColor];
            [_processedButton addSubview: lab];
            
        }else if (i == 3){
            //button4
            _processedButton.frame = CGRectMake(10, SCREENMAIN_HEIGHT == 480? 85:98.0f, 205, SCREENMAIN_HEIGHT == 480? 60:80.0f);
            
            //标题4
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, SCREENMAIN_HEIGHT == 480? 20:25.0f, 100, 20)];
            
            //数字4
            UILabel *label = (UILabel *)[labelArr objectAtIndex:i];
            label.frame = CGRectMake(105, SCREENMAIN_HEIGHT == 480? 0:5.0f, 100, 60);
            label.text = [digitalArr objectAtIndex:i];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [_processedButton addSubview:label];
            
            
        }else{
            //标题1、2
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i, SCREENMAIN_HEIGHT == 480? 45:55.0f, 100,20)];
            //数字1、2
            UILabel *lab =  (UILabel *)[labelArr objectAtIndex:i];
            lab.frame = CGRectMake(i, 0-7, 100, 60);
            lab.text = [digitalArr objectAtIndex:i];
            lab.textColor = [UIColor whiteColor];
            lab.backgroundColor = [UIColor clearColor];
            
            //按钮1、2
            [_processedButton setFrame:CGRectMake(10+105*i, 10, 100, SCREENMAIN_HEIGHT == 480? 70:82.0f)];
            [_processedButton addSubview:lab];
            
        }
        //共用部分
        _titleLabel.text = titleArr[i];
        _titleLabel.textColor = [UIColor whiteColor];//#FFFFFF
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        for (UILabel *l in labelArr) {
            l.font = [UIFont systemFontOfSize:30];
            l.backgroundColor = [UIColor clearColor];
            l.textAlignment = NSTextAlignmentCenter;
        }
        
        
        
        
        
        //为菜单添加事件
        [_processedButton addTarget:self action:@selector(processedOrderView:) forControlEvents:UIControlEventTouchUpInside];
        
        [_processedButton addSubview:_titleLabel];
        [processedImage addSubview:_processedButton];
    }
}
#pragma mark-----Action
- (void)processedOrderView:(UIButton* )button{
    NSLog(@"%d",button.tag );
    
    if (button.tag == 510) {
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
        
        
    }else if (button.tag == 511){
        
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
        
    }else if (button.tag == 512){
        
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
        
    }else if (button.tag == 513){
        
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
    }
}
//店铺管理菜单
- (void)creatShopManagerButton{
    shopManagerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT == 480? 150:180)];
    shopManagerView.userInteractionEnabled = YES;
    shopManagerView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    NSArray *imgNormalArr = @[@"function1-1",@"function2-1",@"function3-1",@"function4-1",@"function5-1",@"function6-1"];
    NSArray *imgSelectArr = @[@"function1-2",@"function2-2",@"function3-2",@"function4-2",@"function5-2",@"function6-2"];
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            int temp = j + i*3;
            UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [managerButton setFrame:CGRectMake(10+100*j, 10+(SCREENMAIN_HEIGHT == 480? 65:82)*i, 100, SCREENMAIN_HEIGHT == 480? 65:82)];
            
            [managerButton setBackgroundImage:[UIImage imageNamed:imgNormalArr[temp]] forState:UIControlStateNormal];
            [managerButton setBackgroundImage:[UIImage imageNamed:imgSelectArr[temp]] forState:UIControlStateSelected ];
            managerButton.tag = 120+temp;
            
            //为菜单添加事件
            [managerButton addTarget:self action:@selector(jumpMenuView:) forControlEvents:UIControlEventTouchUpInside];
            
            [shopManagerView addSubview:managerButton];
            
        }
    }
}

#pragma mark-----Action
- (void)jumpMenuView:(UIButton *)button{
    NSLog(@"%d",button.tag-120);
    
    if (button.tag == 120) {
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
    }
    else if (button.tag == 121) {
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];    }
    else if (button.tag == 122) {
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
    }
    else if (button.tag == 123) {
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];    }
    else if (button.tag == 124) {
        LandViewController *landViewCtl = [[LandViewController alloc]init];
        [self.navigationController pushViewController:landViewCtl animated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        
        [self currentTopView];
        [cell.contentView addSubview:topImageView];
        //取消的点中事件
        cell.selectionStyle = UITableViewScrollPositionNone;
        
    }else if (indexPath.row == 1){
        [self currentGoodsDetailsView];
        [cell.contentView addSubview:processedImage];
        cell.selectionStyle = UITableViewScrollPositionNone;
        
    }else if (indexPath.row == 2){
        [self creatShopManagerButton];
        [cell.contentView addSubview:shopManagerView];
        cell.selectionStyle = UITableViewScrollPositionNone;
    }
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return SCREENMAIN_HEIGHT == 480? 110:138;
    }else if (indexPath.row == 1){
        return SCREENMAIN_HEIGHT == 480? 150:180;
    }else if (indexPath.row == 2){
        return SCREENMAIN_HEIGHT == 480? 150:180;
    }else{
        return 0;
    }
}

@end
