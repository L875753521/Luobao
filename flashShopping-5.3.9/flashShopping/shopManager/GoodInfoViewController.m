//
//  GoodInfoViewController.m
//  flashShopping
//
//  Created by Width on 14-2-25.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodInfoViewController.h"
#import "SGDataService.h"
#import "GoodsInfoModel.h"
#import "GoodsdetaiViewController.h"

@interface GoodInfoViewController ()
{
    UITableView *goodTableView ;
    NSMutableArray *dataArr;
    CustomNavigationBar *navigationBar ;
    int index ;
    NSInteger Cellheight ;
    NSMutableArray *copyDataArr ;
    NSMutableArray *searchArr ;
    MBProgressHUD *hud ;
    
    
    NSMutableArray *filteredNames;//过滤名字
    UISearchDisplayController *searchController;//搜索栏
}
@end

@implementation GoodInfoViewController

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
    self.view.backgroundColor = [UIColor blackColor];
   
    //自定义导航
    navigationBar = [[CustomNavigationBar alloc]initWithFrame:CGRectMake(0, 20, SCREENMAIN_WIDTH, 44) andTitleArr:[NSArray arrayWithObjects:@"所有商品",@"橱窗中商品",@"出售中商品",@"仓库中商品",@"已下架商品", nil] andSetBarButtonDelegate:self andSetPullNenuDelegate:self];
    
    
    [self.view addSubview:navigationBar];
        
    //加载goodTableView
    goodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - 44) style:UITableViewStylePlain];
    goodTableView.dataSource = self ;
    goodTableView.delegate = self ;
    [self.view addSubview:goodTableView];
    
    goodTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self.view bringSubviewToFront:navigationBar];
    
    
    //过滤名字
    filteredNames = [NSMutableArray array];
    UISearchBar *searchBar = [[UISearchBar alloc]
                              initWithFrame:CGRectMake(0, 0, 320, 44)];
    //设置搜索栏的初始颜色
    searchBar.tintColor=[UIColor whiteColor];
    searchBar.backgroundColor = [UIColor clearColor];
    //改变搜索框默认提示文字
    searchBar.placeholder = @"请输入商品名称或编号";
    
    goodTableView.tableHeaderView = searchBar;
    searchController = [[UISearchDisplayController alloc]
                        initWithSearchBar:searchBar
                        contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    
    //适配
    if (IOS_VERSION < 7.0) {
        navigationBar.top = 0 ;
        goodTableView.top = 44 ;
    }
    
    //加载网络数据
    [self loadNetData:YES];
    
    //通知（基本详情页点击刷新按钮时发送过来要求重新加载网络的通知）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshNote:) name:@"refreshData" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES ;
}

//加载网络数据
#pragma mark----加载网络数据
- (void)loadNetData:(BOOL)isReloadData
{
    //初始化
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate ;
    hud.labelText = @"加载中……" ;
    
    NSDictionary *dict = @{@"actionCode":@"441" , @"appType":@"json"};
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    //添加企业Id
    [mutableDict setObject:COMPANYID forKey:@"companyId"];
    
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        NSArray *jsonArr = result[@"content"];
//        NSLog(@"jsonArr==============%@",jsonArr);
        for (NSDictionary *dict in jsonArr) {
            //把数据装入数据模型
            GoodsInfoModel *goodsInfoModel =[[GoodsInfoModel alloc]initWithDataDic:dict];
            if (dataArr == nil) {
                dataArr = [NSMutableArray new];
            }
            
            [dataArr addObject:goodsInfoModel];
            
        }
         if (isReloadData) {
             
            [MBProgressHUD hideHUDForView:self.view animated:YES];
              goodTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
             //刷新UI
             [goodTableView reloadData];
            
        }else{
            //
             [[NSNotificationCenter defaultCenter]postNotificationName:@"toGoodsDetaiView" object:dataArr[index]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}
#pragma mark---UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return dataArr.count;
    
}
- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *goodCellID = @"goodCellID";
    GoodsCell *goodCell = [tableView dequeueReusableCellWithIdentifier:goodCellID];
    if (goodCell == nil) {
        goodCell = [[GoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodCellID ];
    }
    GoodsInfoModel *gInfoModel = dataArr[indexPath.row] ;
    goodCell.goodsModel = gInfoModel;
    [goodCell setIntroductionText:gInfoModel.name];
    
    return goodCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    GoodsdetaiViewController *goodsDetailViewCtl = [[GoodsdetaiViewController alloc]init];
    goodsDetailViewCtl.goodsInfoModel = dataArr[indexPath.row];
    goodsDetailViewCtl.index = indexPath.row ;
    [self.navigationController pushViewController:goodsDetailViewCtl animated:YES];
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
    index = [[note object] intValue];
    [dataArr removeAllObjects];
    [self loadNetData:NO];
  
   
}
//#pragma mark-----UITextFieldDelegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES ;
//}
#pragma mark-----MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark---ChangeHeightProtocol
//选中下拉行的标题
- (void)changeTitles:(NSString *)title
{
    [navigationBar.titleButton setTitle:title forState:UIControlStateNormal];
    navigationBar.pullNenu.hidden = YES , navigationBar.flag = !navigationBar.flag ;
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

    for (GoodsInfoModel *goodsModel in dataArr) {
        NSLog(@"ssssssss");
//        NSRange range = [searchString rangeOfString:searchString];
//        NSRange range = [goodsModel.name rangeOfString:searchString options:NSCaseInsensitiveSearch];
        if ([goodsModel.name hasPrefix:searchString] || [[NSString stringWithFormat:@"%@",goodsModel.Id] hasPrefix:searchString ]) {
            
            [filteredNames addObject:goodsModel];
            
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
