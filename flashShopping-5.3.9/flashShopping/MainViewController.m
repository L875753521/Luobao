//
//  MainViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "MainViewController.h"
#import "ShopMvoingViewController.h"
#import "ChatViewController.h"
#import "MoreViewController.h"
#import "BaseNavViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import "SBJsonWriter.h"
#import "NoLogingViewController.h"
#import "LoginJudgeSingleton.h"

@interface MainViewController (){
    UIView *barView;
    NSTimer *timer;
}

//初始化MainViewController管理的4个ViewController
- (void)_initView;
//自定义ItemBar
- (void)customItemBar;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     _isChatNowInvoke = @"NO";
    
    [self _initView];
    
    [self customItemBar];
    
    //    监听当前是否在闪聊页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatNowViewControllerIsInvoke:) name:@"chatNowInvokeStateNotification" object:nil];
//    监听发送普通消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage:) name:@"sendMessage" object:nil];
//    监听给服务器发送消息。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage2Server:) name:@"sendMessage2ServerNSNotification" object:nil];
//    监听登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusWasChanged:) name:@"loginSuccessNotification" object:nil];
//    当店铺首页上得聊天按钮被点击后，接收到该通知。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopMvoingChatWasClick:) name:@"shopMvoingChatButtonWasClickNotification" object:nil];
    

}

- (void)loadChat{

    [self initDictionary];
    _parser = [[ChatNowReceiveJSONParser alloc] init];
    _mainSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://sztest.iflashbuy.com:8201"]]];
    _mainSocket.delegate = self;
    
    if ([[LoginJudgeSingleton shareLoginJudge] isLogin]) {
        
        [_mainSocket open];
        _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkConnection:) userInfo:nil repeats:YES];
        [_timer fire];
    }
    

    
    
    
}
//聊天登录字典初始化。
- (void)initDictionary{
    
    _loginDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    _sendMessageDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    _sendImageDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSString *username = USERNAME;
    NSString *password = PASSWORD;
    
    password = [self md5:password];
    [_loginDataDic setObject:@"login" forKey:@"soc_type"];
    [_loginDataDic setObject:username forKey:@"username"];
    [_loginDataDic setObject:password forKey:@"pwd"];
    [_loginDataDic setObject:@"" forKey:@"session_id"];
    [_loginDataDic setObject:@"2" forKey:@"user_type"];
    [_loginDataDic setObject:@"0" forKey:@"no_user"];
    [_loginDataDic setObject:@"" forKey:@"enterpriseId"];
    [_loginDataDic setObject:@"AAAA" forKey:@"token"];
    
    
    
    
    [_sendMessageDic setObject:@"send" forKey:@"soc_type"];
    //    [_sendMessageDic setObject:@"ceshi1" forKey:@"username"];
    //    [_sendMessageDic setObject:@"2" forKey:@"user_type"];
    //    [_sendMessageDic setObject:@"18676720523" forKey:@"get_user"];
    //    [_sendMessageDic setObject:@"1" forKey:@"get_user_type"];
    
    
    
    
}

- (void)loginStatusWasChanged:(NSNotification *)sender{
    
//    如果登录成功添加聊天通信功能。
    [self loadChat];
}

-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

- (void)sendMessage:(NSNotification *)aSendMessageContent{
    //    NSLog(@"%@",aSendMessageContent);
    
    ChatMessageModel *sendMessage = [aSendMessageContent object];
    
    [self SendMessageWithChatMessage:sendMessage];
    
    //    NSLog(@"%s  %@",__FUNCTION__,sendMessageStr);
    
    
    
}

- (void)sendMessage2Server:(NSNotification *)sender{
    
    ChatMessageModel *send2ServerMessage = [sender object];
    
    [self SendMessageWithChatMessage:send2ServerMessage];
    
    
}


- (void)SendMessageWithChatMessage:(ChatMessageModel *)aChatMessageModel{
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    //    设置发送消息的初始化信息
    [_sendMessageDic setObject:USERNAME forKey:@"username"];
    [_sendMessageDic setObject:aChatMessageModel.message forKey:@"send_msg"];
    [_sendMessageDic setObject:aChatMessageModel.getUser forKey:@"get_user"];
    [_sendMessageDic setObject:aChatMessageModel.getUserType forKey:@"get_user_type"];
    [_sendMessageDic setObject:aChatMessageModel.sendUserType forKey:@"user_type"];
    NSString *UUID = [self stringWithUUID];
    [_sendMessageDic setObject:UUID forKey:@"msg_id"];
    NSString *sendMessageStr = [writer stringWithObject:_sendMessageDic];
    
    if (_mainSocket.readyState == SR_OPEN) {
        
        [_mainSocket send:sendMessageStr];
    }
    
    return;
    
    
}



- (NSString*) stringWithUUID {
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}


- (void)checkConnection:(id)sender{
    
    NSLog(@"++++_mainSocket is %@  readyState is  %i  +++",_mainSocket,_mainSocket.readyState);
    if (_mainSocket.readyState != SR_OPEN) {
        
        _mainSocket.delegate = nil;
        _mainSocket = nil;
        _mainSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://sztest.iflashbuy.com:8201"]]];
        _mainSocket.delegate = self;
        [_mainSocket open];
        
    }
    
}


- (void)chatNowViewControllerIsInvoke:(NSNotification *)sender{
    
    _isChatNowInvoke = (NSString *)[sender object];
    
}
#pragma mark-
#pragma markSRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:SESSIONID];
    if (sessionId) {
        //        [_loginDataDic setObject:sessionId forKey:SESSIONID];
    }
    NSLog(@"%@",[writer stringWithObject:_loginDataDic]);
    [_mainSocket send:[writer stringWithObject:_loginDataDic]];
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"%s  %@",__FUNCTION__,message);
    
    [_parser parserWithMessage:message isLogin:^(ChatNowLoginModel *login) {
        
        //        登陆返回信息
        NSLog(@"%@",login);
        
        [[NSUserDefaults standardUserDefaults] setObject:login.sessionID forKey:SESSIONID];
        
        NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"server",@"soc_type", nil];
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *getServerStr = [writer stringWithObject:tempDic];
        NSLog(@"%s,%@",__FUNCTION__,getServerStr);
        
        [_mainSocket send:getServerStr];
        
    } isMessage:^(ChatMessageModel *message) {
        
        //        接收消息
        NSLog(@"%@",message.message);
        
//        NSString *serverName = [[NSUserDefaults standardUserDefaults] objectForKey:@"ChatServerName"];
        
        NSString *serverName = [[LoginJudgeSingleton shareLoginJudge] objectForKey:SERVERCHATIDSINGLETON];
        
        if ([message.sendUser isEqualToString:serverName]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessageFromServerNotification" object:message];
            
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessageNotification" object:message];
        
//        [[_selfNavigation.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:@"5"];
        
//        NSLog(@"%@",[_selfNavigation.tabBarController.tabBar.items objectAtIndex:1]);
        //        红帽推送
//        if ([_isChatNowInvoke isEqualToString:@"NO"]) {
//            
//            numberOfMessage++;
//            
//            
//        }
        
        
        
    } isFile:^(ChatNowFileModel *file) {
        
        //        文件返回信息
        
        
    } isMessageResult:^(ChatNowResultModel *messageResult) {
        //        消息发送返回
        
        
    } isReceiveNotic:^(ChatNowReceiveNoticModel *receiveNotic) {
        //        消息接收提示
        
        
    }];
    
    
    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    
    
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    
    
}


//初始化MainViewController管理的4个ViewController；
- (void)_initView{
    
    //初始化视图控制器
    ShopMvoingViewController *shopMoveView = [[ShopMvoingViewController alloc]init];
    
    ChatViewController *chatView = [[ChatViewController alloc]init];
    MoreViewController *moreView = [[MoreViewController alloc]init];
    //    NoLogingViewController *noLogingView = [[NoLogingViewController alloc] init];
    NSArray *viewArr = @[shopMoveView, chatView, moreView  ];
    NSMutableArray *navArr = [NSMutableArray new];
    
    for (UIViewController *view in viewArr) {
        //给视图控制器加导航
        BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:view];
        nav.delegate = self;
        [navArr addObject:nav];
    }
    
    self.viewControllers = navArr;
}

//自定义ItemBar
- (void)customItemBar{
    
    barView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREENMAIN_HEIGHT-49, SCREENMAIN_WIDTH,49)];
    barView.backgroundColor=[UIColor redColor];
    [self.view addSubview:barView];
    
    NSArray *imgNormaArr = @[@"ItemBar1-1",@"ItemBar2-1",@"ItemBar3-1"];
    NSArray *imgSelectedArr = @[@"ItemBar1-2",@"ItemBar2-2",@"ItemBar3-2"];
    
    for (int i = 0; i < imgNormaArr.count ; i++) {
        
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setFrame:CGRectMake(i*SCREENMAIN_WIDTH/imgNormaArr.count, 0, SCREENMAIN_WIDTH/imgNormaArr.count, 49)];
        itemButton.tag = 100+i;
        if (itemButton.tag == 100) {
            _lastSelecteButton = itemButton ;
            _lastSelecteButton.selected = YES ;
        }
        [itemButton setBackgroundImage:[UIImage imageNamed:imgNormaArr[i]] forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:imgSelectedArr[i]] forState:UIControlStateSelected];
        [itemButton addTarget:self action:@selector(selectedViewControllers:) forControlEvents:UIControlEventTouchUpInside];
        
        [barView addSubview:itemButton];
    }
    
}

//ViewController视图之间的切换
- (void)selectedViewControllers:(UIButton*)button{
    
    button.selected = YES ;
    _lastSelecteButton.selected = NO ;
    _lastSelecteButton = button ;
    self.selectedIndex = button.tag - 100 ;
    
}

- (void)shopMvoingChatWasClick:(NSNotification *)sender{
    UIButton *chatBtn;
    for (UIView *vie in barView.subviews) {
        if ([vie isKindOfClass:[UIButton class]]) {
            if (101 == vie.tag) {
                
                 chatBtn = (UIButton *)vie;
                
            }
            
        }
    }
    
    [self selectedViewControllers:chatBtn];
}

//是否要显示BarItem
- (void)showBarItem:(BOOL)show
{
    [UIView animateWithDuration:0 animations:^{
        if (show) {
            self.tabBar.hidden = YES;
            [barView setFrame:CGRectMake(0, SCREENMAIN_HEIGHT-49, SCREENMAIN_WIDTH,49)];
        }else{
            self.tabBar.hidden = YES;
            [barView setFrame:CGRectMake(-320, SCREENMAIN_HEIGHT-49, SCREENMAIN_WIDTH,49)];
        }
        
    }];
    [self resizeView:show];
}

//隐藏tabBar后调整frame
- (void)resizeView:(BOOL)isFrame{
    
    
    for (UIView *subView in self.view.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (isFrame) {
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-49)];
            }else{
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT)];
            }
            
        }
    }}
#pragma mark-----UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    _selfNavigation = navigationController;
    NSInteger count = navigationController.viewControllers.count ;
    if (count == 1) {
        [self showBarItem:YES];
    }else{
        [self showBarItem:NO];
    }
}

#pragma mark----Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
