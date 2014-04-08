//
//  BaseTableView.h
//  flashShopping
//
//  Created by Width on 14-1-8.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

//////////////////////////////////////////////代理/////////////////////////////////
@class BaseTableView ;
//@protocol EGORefreshProtocol <NSObject>
//
//- (void)pullDown:( BaseTableView * )tableView ;
//
//@end
//////////////////////////////////////////////////////////////////////////////////////

@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    // 下拉刷新
    EGORefreshTableHeaderView *_refreshView;
    BOOL _isRefresh;
    BOOL _shouldLoading;
    BOOL _isLoading;
    
//    id<EGORefreshProtocol>RefreshDelegate ;
}
@property (nonatomic , assign)BOOL   isAddRefresh; //是否需要下啦刷新
@property (nonatomic , retain)NSMutableArray *dataArr;    //为tableView提供数据
//@property (nonatomic , assign)id<EGORefreshProtocol>RefreshDelegate ;

@end
