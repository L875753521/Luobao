#import "ChatViewController.h"
#import "ChatNowDetialViewController.h"
#import "ChatMessageModel.h"
#define IPADDRESS @"192.168.1.201"
#define PORT 4000


@interface ChatViewController ()
@end

typedef enum{
    kSellerConversation = 1,
    kShanGouConversation
}kTabType;
@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        //        买家聊天信息数组
        _sellerDataArr = [[NSMutableArray alloc] initWithCapacity:1];
        //        记录各个元素在数组中得位置以便能添加红帽的数组
        _setSellerBadgeValueArr = [[NSMutableArray alloc] initWithCapacity:1];
        //        闪购客服聊天数组
        _shanGouDataArr = [[NSMutableArray alloc] initWithCapacity:1];
        
        NSMutableArray *shanGouChatDetailArr = [[NSMutableArray alloc] initWithCapacity:1];
        
        [_shanGouDataArr addObject:shanGouChatDetailArr];
        
        _dataArr = _sellerDataArr;
        _isChatWithServer = NO;
        [self loadMainView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMessage:) name:@"receiveMessageNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCurrentConversition:) name:@"currentConversitionChangeNotification" object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage:) name:@"sendMessage" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage2Server:) name:@"sendMessage2ServerNSNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMessageFromServer:) name:@"receiveMessageFromServerNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(CurrentChatWithServer:) name:@"ChatWithServeringNotification" object:nil];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (_dataSourceTableView) {
        [_dataSourceTableView reloadData];
    }
    //    每次即将显示聊天列表时都要设置消息总数量的红帽
    if (_badgeValueArr) {
        if (numberOfMessage > 0) {
            
            
            int numberOfTotalBadge = 0;
            
            for (int i = 0; i < _setSellerBadgeValueArr.count; i++) {
                NSString *numberOfBadge = [_setSellerBadgeValueArr objectAtIndex:i];
                
                if (![numberOfBadge isEqualToString:@"0"]) {
                    numberOfTotalBadge ++;
                    
                }
            }
            
            if (numberOfTotalBadge < _badgeValueArr.count) {
                _sellerConversationBadge.image = [UIImage imageNamed:[_badgeValueArr objectAtIndex:numberOfMessage - 1]];
            }else{
                _sellerConversationBadge.image = [UIImage imageNamed:[_badgeValueArr lastObject]];
            }
            
        }else{
            
            _sellerConversationBadge.image = nil;
            
        }
//        设置与客服聊天页面的红帽
        if (numberOfServerMessage > 0) {

            _shanGouConversationBadge.image = [UIImage imageNamed:[_badgeValueArr firstObject]];

        }
        
        
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chatNowInvokeStateNotification" object:@"YES"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chatNowInvokeStateNotification" object:@"NO"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentConversitionObj = @"NO";
    //    ChatNowDetial     ChatNowListTable
    //    self.navigationController.tabBarItem.badgeValue = @"5";
    
    //    给红帽名称数组赋值
    _badgeValueArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 1; i < 10; i++) {
        
        [_badgeValueArr addObject:[NSString stringWithFormat:@"%i.png",i]];
        
    }
    self.titleLabel.text = @"闪聊";
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"ChatNowListSet"] forState:UIControlStateNormal];
    [commitBtn setFrame:CGRectMake(0, 0, 35, 35)];
    [commitBtn addTarget:self action:@selector(chatNowListSetting:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [vie addSubview:commitBtn];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vie];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    numberOfServerMessage = 0;
}

- (void)chatNowListSetting:(UIButton *)sender{
    
    NSLog(@"%s, chatNowListSetting",__FUNCTION__);
    
}
- (void)changeCurrentConversition:(NSNotification *)sender{
    
    _currentConversitionObj = [sender object];
    
    
}

- (void)sendMessage:(NSNotification *)sender{
    
    ChatMessageModel *selfSendMessage = [sender object];
    
    if (selfSendMessage) {
        
        NSLog(@"%@",selfSendMessage.message);
        
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSMutableArray *arr = (NSMutableArray *)[_sellerDataArr objectAtIndex:i];
            if (arr) {
                ChatMessageModel *tempMessage = [arr firstObject];
                
                if ([tempMessage.sendUser isEqualToString:selfSendMessage.getUser]) {
                    
                    [_sellerDataArr removeObjectAtIndex:i];
                    [arr addObject:selfSendMessage];
                    [_sellerDataArr insertObject:arr atIndex:0];
                    [_setSellerBadgeValueArr removeObjectAtIndex:i];
                    [_setSellerBadgeValueArr insertObject:@"0" atIndex:0];
                    [_dataSourceTableView reloadData];
                    return;
                }
                
            }
        }
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:1];
        
        [tempArr addObject:selfSendMessage];
        [_sellerDataArr insertObject:tempArr atIndex:0];
        [_setSellerBadgeValueArr insertObject:@"0" atIndex:0];
        [_dataSourceTableView reloadData];
        
    }
    
}


- (void)receivedMessageFromServer:(NSNotification *)sender{
    
    
    ChatMessageModel *messageFromServer = [sender object];
    
    if (messageFromServer) {
        
        NSMutableArray *chatWithServerDetailArr = [_shanGouDataArr lastObject];
        
        
        [chatWithServerDetailArr addObject:messageFromServer];
        [_dataSourceTableView reloadData];
        numberOfServerMessage ++;
        
        if (_isChatWithServer) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"currentServerMessageArriveNotification" object:messageFromServer];
            
            numberOfServerMessage = 0;
            
        }else{
            _shanGouConversationBadge.image = [UIImage imageNamed:[_badgeValueArr firstObject]];
        }
        
        
    }
    
}
- (void)sendMessage2Server:(NSNotification *)sender{
    
    ChatMessageModel *send2ServerMessage = [sender object];
    
    if (send2ServerMessage) {
        
        NSMutableArray *chatWithServerDetailArr = [_shanGouDataArr lastObject];
        
        [chatWithServerDetailArr addObject:send2ServerMessage];
        [_dataSourceTableView reloadData];
        
        
    }
    
    
}

- (void)receivedMessage:(NSNotification *)sender{
    ChatMessageModel *message = [sender object];
    
    if (message) {
        
        NSLog(@"%@",message.message);
        
        
        if (![_currentConversitionObj isEqualToString:@"NO"]) {
            //            在聊天。
            
            
            
        }else{
            //            没有在聊天
            if (numberOfMessage < _badgeValueArr.count) {
                _sellerConversationBadge.image = [UIImage imageNamed:[_badgeValueArr objectAtIndex:numberOfMessage]];
            }else{
                _sellerConversationBadge.image = [UIImage imageNamed:[_badgeValueArr lastObject]];
            }
            
            numberOfMessage ++;
            
        }
        
        for (int i = 0; i < _sellerDataArr.count; i++) {
            
            NSMutableArray *arr = (NSMutableArray *)[_sellerDataArr objectAtIndex:i];
            if (arr) {
                ChatMessageModel *tempMessage = [arr firstObject];
                
                if ([message.sendUser isEqualToString:_currentConversitionObj]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"hasNewMessage4CurrentConversition" object:message];
                }
                if ([tempMessage.sendUser isEqualToString:message.sendUser]) {
                    
                    
                    
                    [_sellerDataArr removeObjectAtIndex:i];
                    
                    [arr addObject:message];
                    [_sellerDataArr insertObject:arr atIndex:0];
                    
                    //                    改变对应元素位置上得红帽
                    NSString *numberStr = [_setSellerBadgeValueArr objectAtIndex:i];
                    int intNumber = [numberStr intValue];
                    intNumber ++;
                    [_setSellerBadgeValueArr removeObjectAtIndex:i];
                    //                    假如是正在聊天的对象 特殊处理
                    if ([message.sendUser isEqualToString:_currentConversitionObj]) {
                        
                        [_setSellerBadgeValueArr insertObject:[NSString stringWithFormat:@"%i",0] atIndex:0];
                    }else{
                        [_setSellerBadgeValueArr insertObject:[NSString stringWithFormat:@"%i",intNumber] atIndex:0];
                    }
                    
                    
                    [_dataSourceTableView reloadData];
                    
                    return;
                    
                }
                
                
            }
        }
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:1];
        
        [tempArr addObject:message];
        [_sellerDataArr insertObject:tempArr atIndex:0];
        
        [_setSellerBadgeValueArr insertObject:[NSString stringWithFormat:@"1"] atIndex:0];
        [_dataSourceTableView reloadData];
        
    }
    
    
}

- (void)CurrentChatWithServer:(NSNotification *)sender{
    
    NSString *chatWithServer = [sender object];
    if ([chatWithServer isEqualToString:@"YES"]) {
        
        _isChatWithServer = YES;
    }else if ([chatWithServer isEqualToString:@"NO"]){
        
        _isChatWithServer = NO;
        
    }
    
}

- (void)loadMainView{
    
    float verHeigh = [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0?0.0f:64.0f;
    //    创建选项卡背景view
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(.0f, verHeigh, SCREENMAIN_WIDTH, 44.0f)];
    self.titleLabel.text = @"闪聊";
    selectView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:selectView];
    //    添加选项卡背景
    UIImageView *selectBtnBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChatNowListButton"]];
    selectBtnBG.frame = CGRectMake(0.0f, .0f, SCREENMAIN_WIDTH, 44.0f);
    [selectView addSubview:selectBtnBG];
    selectBtnBG.userInteractionEnabled = YES;
    //    添加选项卡按钮
    UIButton *sellerConversationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sellerConversationBtn.frame = CGRectMake(0.0f, 0.0f, 160.0f, 44.0f);
    sellerConversationBtn.tag = kSellerConversation;
    [sellerConversationBtn addTarget:self action:@selector(tabStripWasSelected:) forControlEvents:UIControlEventTouchUpInside];
    [sellerConversationBtn setTitle:@"卖家对话" forState:UIControlStateNormal];
    [sellerConversationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectView addSubview:sellerConversationBtn];
    
    _sellerConversationBadge = [[UIImageView alloc] initWithFrame:CGRectMake(110, 5.0f, 20.0f, 20.0f)];
    [selectView addSubview:_sellerConversationBadge];
    UIButton *shanGouConversationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shanGouConversationBtn.frame = CGRectMake(160.0f, 0.0f, 160.0f, 44.0f);
    shanGouConversationBtn.tag = kShanGouConversation;
    [shanGouConversationBtn addTarget:self action:@selector(tabStripWasSelected:) forControlEvents:UIControlEventTouchUpInside];
    [shanGouConversationBtn setTitle:@"闪购客服" forState:UIControlStateNormal];
    [shanGouConversationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectView addSubview:shanGouConversationBtn];
    
    
    _shanGouConversationBadge = [[UIImageView alloc] initWithFrame:CGRectMake(270, 5.0f, 20.0f, 20.0f)];
    [selectView addSubview:_shanGouConversationBadge];
    
    
    
    
    _subscriptImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChatNowListSelected"]];
    _subscriptImageView.frame = CGRectMake(.0f, 40.0f, SCREENMAIN_WIDTH/2, 4.0f);
    
    
    
    _dataSourceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, verHeigh + 44, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - verHeigh - 44) style:UITableViewStylePlain];
    _dataSourceTableView.delegate = self;
    _dataSourceTableView.dataSource = self;
    
    
    [selectBtnBG addSubview:_subscriptImageView];
    [self.view addSubview:_dataSourceTableView];
    
    
    
}

- (void)tabStripWasSelected:(UIButton *)sender{
    
    switch (sender.tag) {
        case kSellerConversation:
        {
            _isChatWithServer = NO;
            [UIView animateWithDuration:.1f animations:^{
                _subscriptImageView.frame = CGRectMake(.0f, 40.0f, SCREENMAIN_WIDTH/2, 4.0f);
                
            }];
            _dataArr = _sellerDataArr;
            [_dataSourceTableView reloadData];
            
        }
            break;
            
        case kShanGouConversation:
        {
            _isChatWithServer = YES;
            [UIView animateWithDuration:.1f animations:^{
                _subscriptImageView.frame = CGRectMake(160.0f, 40.0f, SCREENMAIN_WIDTH/2, 4.0f);
            }];
            _dataArr = _shanGouDataArr;
            [_dataSourceTableView reloadData];
            
        }
            break;
            
        default:
            break;
    }
    
}
- (void)getNumberOfTotalBadge{
    
    int numberOfTotalBadge = 0;
    
    for (int i = 0; i < _setSellerBadgeValueArr.count; i++) {
        NSString *numberOfBadge = [_setSellerBadgeValueArr objectAtIndex:i];
        
        if (![numberOfBadge isEqualToString:@"0"]) {
            numberOfTotalBadge ++;
            
        }
        
    }
    if ( numberOfServerMessage > 0) {
        numberOfTotalBadge += 1;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"numberOfTotalBadgeNotification" object:[NSString stringWithFormat:@"%i",numberOfTotalBadge] userInfo:nil];
    
}



#pragma mark -
#pragma mark UITableDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    ChatNowDetialViewController *chatNowDetialVC = [[ChatNowDetialViewController alloc] init];
    
    
    if (_dataArr == _sellerDataArr) {
        
        if (_dataArr.count == 0) {
            return;
        }
        
        NSString *currentBadgeValueStr = [_setSellerBadgeValueArr objectAtIndex:indexPath.row];
        int intCurrentBadgeValue = [currentBadgeValueStr intValue];
        if (intCurrentBadgeValue > 0) {
            numberOfMessage -= intCurrentBadgeValue;
        }
        
        [_setSellerBadgeValueArr removeObjectAtIndex:indexPath.row];
        [_setSellerBadgeValueArr insertObject:@"0" atIndex:indexPath.row];
        
        NSMutableArray *currentChatArr = (NSMutableArray *)[_dataArr objectAtIndex:indexPath.row];
        
        ChatNowDetialViewController *chatNowDetialVC = [[ChatNowDetialViewController alloc] initWithDataSourceArr:currentChatArr AndChatWithServer:NO];
        
        [self.navigationController pushViewController:chatNowDetialVC animated:YES];
    }else{
        
        NSMutableArray *chatWithServerDetailArr = [_shanGouDataArr lastObject];
        //        重置闪聊客服的消息数
        numberOfServerMessage = 0;
        _shanGouConversationBadge.image = nil;
        ChatNowDetialViewController *chatNowDetialVC = [[ChatNowDetialViewController alloc] initWithDataSourceArr:chatWithServerDetailArr AndChatWithServer:YES];
        [self.navigationController pushViewController:chatNowDetialVC animated:YES];
    }
    
    [self getNumberOfTotalBadge];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!_isChatWithServer) {
        if (_dataArr.count == 0) {
            return 1;
        }
        return _dataArr.count;
    }else{
        return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(24, 10, 150, 40)];
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textColor = [UIColor blackColor];
    
    [cell.contentView addSubview:nameLab];
    UILabel *conversationLab = [[UILabel alloc] initWithFrame:CGRectMake(24, 50, 270, 40)];
    conversationLab.backgroundColor = [UIColor clearColor];
    conversationLab.textColor = [UIColor blackColor];
    [cell.contentView addSubview:conversationLab];
    
    
    UILabel *timeFlagLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 150, 40)];
    timeFlagLab.backgroundColor = [UIColor clearColor];
    timeFlagLab.textColor = [UIColor grayColor];
    timeFlagLab.textAlignment = UITextAlignmentRight;
    [cell.contentView addSubview:timeFlagLab];
    
    UIImageView *badgeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(295.0f, 15.0f, 20.0f, 20.0f)];
    [cell.contentView addSubview:badgeImgView];
    
    
    
    
    //    NSLog(@"%li",indexPath.row);
    if (_dataArr.count > indexPath.row) {
        
        
        NSMutableArray *tempArr = [_dataArr objectAtIndex:indexPath.row];
        
        ChatMessageModel *tempMessage = [tempArr lastObject];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *timeDate = [dateFormatter dateFromString:tempMessage.time];
        dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
        NSString *timeStr = [dateFormatter stringFromDate:timeDate];
        
        timeFlagLab.text = timeStr;
        
        if (_isChatWithServer) {
            
            
        }else{
            
            
            
            NSString *badgeValueStr = [_setSellerBadgeValueArr objectAtIndex:indexPath.row];
            
            int intBadgeValue = [badgeValueStr intValue];
            
            if (intBadgeValue > 0) {
                
                NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
                myDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                //            NSDate *messageTimeDate = [myDateFormatter dateFromString:tempMessage.time];
                NSDate *currentTimeDate = [NSDate date];
                
                //            if ([timeOutDate isEqualToDate:messageTimeDate]) {
                //
                //            }
                NSDate *messageTimeOut = [myDateFormatter dateFromString:tempMessage.timeOut];
                NSLog(@"%@",[messageTimeOut earlierDate:currentTimeDate]);
                if (currentTimeDate == [messageTimeOut earlierDate:currentTimeDate]){
                    
                    timeFlagLab.text = @"刚刚";
                    
                }
                
                if (intBadgeValue < _badgeValueArr.count) {
                    badgeImgView.image = [UIImage imageNamed:[_badgeValueArr objectAtIndex:intBadgeValue - 1]];
                    
                }else{
                    
                    badgeImgView.image = [UIImage imageNamed:[_badgeValueArr lastObject]];
                    
                }
            }
            
        }
        
        nameLab.text = tempMessage.sendUser;
        
        conversationLab.text = tempMessage.message;
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0f;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
