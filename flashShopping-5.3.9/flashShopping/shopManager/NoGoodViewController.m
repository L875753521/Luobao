//
//  NoGoodViewController.m
//  flashShopping
//
//  Created by Width on 14-2-27.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "NoGoodViewController.h"
#import "NoGoodsCell.h"
#import "NoGoodModel.h"


@interface NoGoodViewController ()


@end

@implementation NoGoodViewController
{
    UITableView *noGoodTableView;
    MBProgressHUD *hud ;
    NSMutableArray *dataArr;
    int index ;
    
    NSMutableArray *filteredNames;//过滤名字
    UISearchDisplayController *searchController;//搜索栏
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
    self.titleLabel.text = @"缺货商品" ;
    //refresh按钮
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 25, 25) andSetdelegate:self andImageName:@"refresh"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
    
    
    //加载goodTableView
    noGoodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT) style:UITableViewStylePlain];
    noGoodTableView.dataSource = self ;
    noGoodTableView.delegate = self ;
//    [noGoodTableView setTableHeaderView:_searchBox];//加载搜索框
    noGoodTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self.view addSubview:noGoodTableView];
    
    
    //过滤名字
    filteredNames = [NSMutableArray array];
    UISearchBar *searchBar = [[UISearchBar alloc]
                              initWithFrame:CGRectMake(0, 0, 320, 44)];
    //设置搜索栏的初始颜色
    searchBar.tintColor=[UIColor whiteColor];
    searchBar.backgroundColor = [UIColor clearColor];
    //改变搜索框默认提示文字
    searchBar.placeholder = @"请输入商品名称或编号";
    
    noGoodTableView.tableHeaderView = searchBar;
    searchController = [[UISearchDisplayController alloc]
                        initWithSearchBar:searchBar
                        contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    
    //适配
//    if (IOS_VERSION < 7.0) {
//        
//        noGoodTableView.top = 64 ;
//    }
    
    //加载网络数据
    [self loadNetData:YES];
    
    //通知（基本详情页点击刷新按钮时发送过来要求重新加载网络的通知）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshNote:) name:@"refreshData" object:nil];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
//加载网络数据
#pragma mark----加载网络数据
- (void)loadNetData:(BOOL)isReloadData
{
    //初始化
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中……" ;
    
    NSDictionary *dict = @{@"actionCode":@"445" , @"appType":@"json"};
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
//    NSLog(@"COMPANYID==============%@",COMPANYID);
    //添加企业Id
    [mutableDict setObject:COMPANYID forKey:@"companyId"];
    
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        NSArray *jsonArr = result[@"content"];
//        NSLog(@"NoGoodViewController==============%@",jsonArr);
        
        if (dataArr == nil) {
            dataArr = [NSMutableArray new];
        }
        
        if (jsonArr.count == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示:" message:@"暂时没有缺货商品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 200, 200, 40)];
            label.text = @"暂时没有缺货商品";
            label.font = [UIFont systemFontOfSize:20];
            [self.view addSubview:label];
            self.view.backgroundColor = [UIColor whiteColor];
            
        }else{
            for (NSDictionary *dict in jsonArr) {
                
                //把数据装入数据模型
                NoGoodModel *model =[[NoGoodModel alloc] init];
                model.noGoodsId      = [dict objectForKey:@"id"];
                model.noGoodsName    = [dict objectForKey:@"name"];
                model.noGoodsPrice   = [dict objectForKey:@"price"];
                model.noGoodsViewUrl = [dict objectForKey:@"viewUrl"];
                
                [dataArr addObject:model];
                
            }
            
        }
        
    }];
    //重新加载
    if (isReloadData) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        noGoodTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //刷新UI
        [noGoodTableView reloadData];
        
    }else{
        //
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toGoodsDetaiView" object:dataArr[index]];
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    
}
#pragma mark---UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *goodCellID = @"goodCellID";
    NoGoodsCell *noGoodCell = [tableView dequeueReusableCellWithIdentifier:goodCellID];
    if (noGoodCell == nil) {
        noGoodCell = [[NoGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodCellID ];
    }
    NoGoodModel *model = dataArr[indexPath.row] ;
    noGoodCell.noGoodsModel = model;
    [noGoodCell setIntroductionText:model.noGoodsName];
    
    return noGoodCell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    GoodsdetaiViewController *goodsDetailViewCtl = [[GoodsdetaiViewController alloc]init];
//    goodsDetailViewCtl.goodsDataModel = dataArr[indexPath.row];
//    goodsDetailViewCtl.index = indexPath.row ;
//    [self.navigationController pushViewController:goodsDetailViewCtl animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
    
}
#pragma mark-----NSNotification
#pragma mark-----通知（基本详情页点击刷新按钮时发送过来要求重新加载网络的通知）
- (void)refreshNote:(NSNotification*)note
{
    index = [[note object]intValue];
    [dataArr removeAllObjects];
    [self loadNetData:NO];
    
    
}

#pragma  mark-----memoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

#pragma mark----barButtonProtocol
//点击自定义导航按钮时启动（刷新按钮）
- (void)actions:(id)sender{
    
    UIButton *b = (UIButton*)sender ;
    if (b.tag == 10) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"刷新…………"  );
        [dataArr removeAllObjects];
        [self loadNetData:YES];
    }
    
}
#pragma mark -
#pragma mark Search Display Delegate Methods
- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 100;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [filteredNames removeAllObjects];
    
    for (NoGoodModel *noGoodsModel in dataArr) {
        NSLog(@"ssssssss");
        //        NSRange range = [searchString rangeOfString:searchString];
        //        NSRange range = [goodsModel.name rangeOfString:searchString options:NSCaseInsensitiveSearch];
        if ([noGoodsModel.noGoodsName hasPrefix:searchString] || [[NSString stringWithFormat:@"%@",noGoodsModel.noGoodsId] hasPrefix:searchString ]) {
            
            [filteredNames addObject:noGoodsModel];
            
        }
        //        NSLog(@"search result is %d",range.length);
        //        if (range.length > 0) {
        //            NSLog(@"yyyyyyyyyyyyyyyyy");
        //            [filteredNames addObject:goodsModel];
        //        }
    }
    NSLog(@"the num of search result is %d",filteredNames.count);
    if (filteredNames.count == 0) {
        UILabel *label = [searchController valueForKey:@"noResultsLabel"];
        label.text = @"没有找到";
    }
    
    
    return YES;
}
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton* btn = [searchBar valueForKey:@"cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}

@end
