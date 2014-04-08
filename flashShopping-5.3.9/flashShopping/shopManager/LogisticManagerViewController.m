//
//  LogisticManagerViewController.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-4.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LogisticManagerViewController.h"
#import "SGDataService.h"

@interface LogisticManagerViewController ()

@end

@implementation LogisticManagerViewController{

    NSMutableArray *dataArr;

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
    self.titleLabel.text = @"物流管理" ;
    //刷新按钮
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 25, 25) andSetdelegate:self andImageName:@"refresh"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
    
    [self startLoadNet];
}
- (void)startLoadNet
{
    NSDictionary *dict = @{@"actionCode":@"421" , @"appType":@"json" ,  @"billNo":@"" , @"orderCode":@""};
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    NSString *companyId = [[NSUserDefaults standardUserDefaults]objectForKey:@"entId"];
    [mutableDict setObject:companyId forKey:@"companyId"];
    
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        NSLog(@"物流管理＝＝＝＝＝＝%@",result[@"content"]);
//        NSArray *jsonArr = result[@"content"];
//        if (dataArr == nil) {
//            dataArr = [NSMutableArray new];
//        }
//        
//        if (jsonArr.count == 0) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示:" message:@"暂时没有缺货商品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 200, 100, 40)];
//            label.text = @"暂时没有缺货商品";
//            [self.view addSubview:label];
//            self.view.backgroundColor = [UIColor whiteColor];
//            
//        }else{
//            for (NSDictionary *dict in jsonArr) {
//                
//                //把数据装入数据模型
//                NoGoodModel *model =[[NoGoodModel alloc] init];
//                model.noGoodsId      = [dict objectForKey:@"id"];
//                model.noGoodsName    = [dict objectForKey:@"name"];
//                model.noGoodsPrice   = [dict objectForKey:@"price"];
//                model.noGoodsViewUrl = [dict objectForKey:@"viewUrl"];
//                
//                [dataArr addObject:model];
            
//            }
//            if (isReloadData) {
//                
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                noGoodTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//                //刷新UI
//                [noGoodTableView reloadData];
        
//            }else{
//                //
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"toGoodsDetaiView" object:dataArr[index]];
//            }
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        }
        
   

        
    }];
        
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark----barButtonProtocol
- (void)actions:(id)sender
{
    NSLog(@"刷新………………");
}
#pragma mark----MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
