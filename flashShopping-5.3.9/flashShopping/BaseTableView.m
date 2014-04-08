//
//  BaseTableView.m
//  flashShopping
//
//  Created by Width on 14-1-8.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.isAddRefresh = YES ;
        [self _initView];
    }
    return self;
}
#pragma mark------customMethod
- (void)_initView
{
    self.dataSource = self;
    self.delegate = self;
       
    // 加入refreshView;
    CGRect refreshRect = CGRectMake(0.0f,
                                    0.0f-self.bounds.size.height,
                                    self.bounds.size.width,
                                    self.bounds.size.height);
    _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:refreshRect];
//    _refreshView.delegate = self;
    
    /* 刷新一次数据 */
    [_refreshView refreshLastUpdatedDate];

}

- (void)setIsAddRefresh:(BOOL)isAddRefresh
{
    _isAddRefresh = isAddRefresh ;
    if (_isAddRefresh) {
        [self addSubview:_refreshView];
    }else if([_refreshView subviews]){
        [_refreshView removeFromSuperview];
    }
}
#pragma mark------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];;
    
    return cell;
}

#pragma mark------有关下拉刷新的方法
//加载完成时调用
- (void) finishDownload:(id)arg
{
    _isLoading = NO;
    
    // 上拉刷新
    _isRefresh = NO;
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}
- (void) startBackgroundJob:(id)arg
{
    // 另外线程中启动加载各类任务
    sleep(3);
    
    [self performSelectorOnMainThread:@selector(finishDownload:) withObject:nil waitUntilDone:NO];
}

- (void) loadDataFromNetwork
{
    if (_isLoading)
        return;
    _isLoading = YES;
    
    [NSThread detachNewThreadSelector:
     @selector(startBackgroundJob:)
                             toTarget:self
                           withObject:nil];
}
#pragma mark------UIScrollViewdelegeta
//滑动停止时调用
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_shouldLoading) {
        [self loadDataFromNetwork];
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //下拉、当到一定距离时调用
    CGFloat aHeight = scrollView.frame.size.height;
    if (scrollView.contentOffset.y+aHeight
        > scrollView.contentSize.height) {
        _shouldLoading = YES;
    } else {
        _shouldLoading = NO;
    }
    
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}
//任何偏移的变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /* 通知一下refreshView */
    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
    /* 调用refreshView中的scrollViewDidScroll方法 */
}

#pragma mark------EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    /* 开始更新代码放在这里 */
    _isRefresh = NO;
    /* 实现更新代码 */
    
    [self loadDataFromNetwork];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    /* 返给refreshView是否正在更新 */
    
    return _isRefresh;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    /* refresh更新完成会调用该方法 设置更新时间 */
    return [NSDate date];
}


@end
