//
//  PullNenu.m
//  flashShopping
//
//  Created by Width on 14-2-11.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "PullNenu.h"

@implementation PullNenu
{
    NSArray *titleArrs ;
    CGRect  subFrame ;
    UITableView *pulltableView ;
}
- (id)initWithFrame:(CGRect)frame setDelegate:(id<pullNenuProtocol>)deles AndTitleArr:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        titleArrs = [titleArr mutableCopy];
        subFrame = frame ;
        self.dele = deles;
        [self initPullView];
    }
    return self;
}

- (void)initPullView
{
    //背景图片的拉伸
    UIImageView *pullDwonVIewbg = [[UIImageView alloc]initWithFrame:subFrame];
    pullDwonVIewbg.image = [UIImage imageNamed:@"pullViewbackground"];
    UIImage *newImg = [pullDwonVIewbg .image stretchableImageWithLeftCapWidth:10 topCapHeight:40];
    pullDwonVIewbg.image = newImg ;
    pullDwonVIewbg.userInteractionEnabled = YES ;
    pullDwonVIewbg.clipsToBounds = NO ;
    [pullDwonVIewbg setCenter:CGPointMake( subFrame.size.width / 2, subFrame.size.height / 2 )];
    [self addSubview:pullDwonVIewbg];
    
    //tableView用于显示数据
    pulltableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 18, subFrame.size.width-10, subFrame.size.height - 18) style:UITableViewStylePlain];
    pulltableView.dataSource = self ;
    pulltableView.delegate = self ;
    pulltableView.rowHeight = 30 ;
    pulltableView.showsHorizontalScrollIndicator = NO;
    pulltableView.showsVerticalScrollIndicator = NO ;
    [self addSubview:pulltableView];

}
#pragma mark---UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return titleArrs.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel  *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pulltableView.width, 40)];
        customLabel.tag = 100 ;
        customLabel.textAlignment = NSTextAlignmentCenter ;
        [cell.contentView addSubview:customLabel];
    }
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:100];
    label.text = titleArrs[indexPath.row];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dele && [ _dele respondsToSelector:@selector(changeTitles:)]) {
        [_dele changeTitles:titleArrs[indexPath.row]];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hideBg" object:nil];
   
}
@end
