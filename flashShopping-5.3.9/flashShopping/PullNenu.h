//
//  PullNenu.h
//  flashShopping
//
//  Created by Width on 14-2-11.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pullNenuProtocol <NSObject>
//选中行的标题
- (void)changeTitles:(NSString*)title ;

@end

@interface PullNenu : UIView<UITableViewDataSource ,UITableViewDelegate>
@property(nonatomic , assign)id<pullNenuProtocol>dele ;

- (id)initWithFrame:(CGRect)frame  setDelegate:(id<pullNenuProtocol>)deles AndTitleArr:(NSArray*)titleArr ;

@end
