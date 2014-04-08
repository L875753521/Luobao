//
//  ChatNowDetialViewController.m
//  flashShopping
//
//  Created by sg on 14-3-19.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ChatNowDetialViewController.h"
#import "SBJsonWriter.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+NSString_getDictionary.h"
#import "ChatMessageModel.h"
#import "LoginJudgeSingleton.h"
#import "LandViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ChatNowDetialViewController ()

@end

typedef enum{
    kFromLocalMemory = 0,
    kFromCamera,
    kCancel
}kSelectPhotoSourceEnmu;
@implementation ChatNowDetialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithDataSourceArr:(NSMutableArray *)aDataSourceArr AndChatWithServer:(BOOL)isWithServer{
    
    self = [super init];
    
    if (self) {
        
        self.dataSourceArr = aDataSourceArr;
        self.isChatWithServer = isWithServer;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasNewMessageArrived:) name:@"hasNewMessage4CurrentConversition" object:nil];
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(hasNewMessageArrived:) name:@"currentServerMessageArriveNotification" object:nil];
    }
    
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [super viewWillAppear:animated];
    if (self.dataSourceArr) {
        
        ChatMessageModel *message = self.dataSourceArr.firstObject;
        _currentConversitionObj = message.sendUser;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"currentConversitionChangeNotification" object:_currentConversitionObj];
        if (self.isChatWithServer) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChatWithServeringNotification" object:@"YES"];
        }else{
            
            [[NSNotificationCenter defaultCenter ] postNotificationName:@"ChatWithServeringNotification" object:@"NO"];
        }
        
        [self position2TableLastElement];
        
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"currentConversitionChangeNotification" object:@"NO"];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.titleLabel.text = @"基本信息";
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"ChatNowDetialSave"] forState:UIControlStateNormal];
    [commitBtn setFrame:CGRectMake(0, 7, 50, 30)];
    [commitBtn addTarget:self action:@selector(chatNowDetailSave:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [vie addSubview:commitBtn];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vie];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320,SCREENMAIN_HEIGHT - 44) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    [self.view addSubview: _tableView];
    
    
    
    //	创建一个 toolbar
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREENMAIN_HEIGHT - 44, 320, 44)];
    UIImageView *backgroundIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Buttom_01"]];
    backgroundIMG.frame = CGRectMake(0.0f, 0.0f, SCREENMAIN_WIDTH, 44.0f);
    [_toolBar addSubview:backgroundIMG];
    [self.view addSubview:_toolBar];
    _toolBar.backgroundColor = [UIColor greenColor];
    
    UIButton *addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    addImageBtn.backgroundColor = [UIColor redColor];
    [addImageBtn addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    addImageBtn.frame = CGRectMake(10, 2, 40, 40);
    [addImageBtn setBackgroundImage:[UIImage imageNamed:@"Buttom_02"] forState:UIControlStateNormal];
    UIBarButtonItem *addImageBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addImageBtn];
    
    
    
    
    //    创建一个textfield
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 2, 170, 40)];
    
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(keyBoardDown:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //    用textField来初始化一个BarButtonIteam
    UIBarButtonItem *textBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_textField];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    sendButton.frame = CGRectMake(10, 2, 60, 40);
    [sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    //    [sendButton setImage:[UIImage imageNamed:@"Buttom_04.png"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"Buttom_04.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *btnBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    
    NSArray *array = [NSArray arrayWithObjects:addImageBarButtonItem,textBarButtonItem,btnBarButtonItem, nil];
    
    
    //    把数组赋值给toolbar的items属性
    _toolBar.items = array;
    //    _array = [[NSMutableArray alloc] initWithCapacity:0];
    _isSendByMe = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    (0, SCREENMAIN_HEIGHT - 44, 320, 44)
    if (IOS_VERSION < 7.0) {
        [_tableView setFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - 20 - 44 - 10)];
        [_toolBar setFrame:CGRectMake(0.0f, SCREENMAIN_HEIGHT - 44 - 20 - 44, SCREENMAIN_WIDTH, 44)];
        
    }
    
    
}

- (void)chatNowDetailSave:(UIButton *)sender{
    
    
    NSLog(@"%s, chatNowDetailSave",__FUNCTION__);
}

- (void)keyBoardWillShow:(NSNotification *)notification{
    //竖屏:216 横屏:140
    static CGFloat normalKeyboardHeight = 216.0f;
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _keyboardDistanceToMove = kbSize.height - normalKeyboardHeight;
    
    NSLog(@"键盘高度差：%f",_keyboardDistanceToMove);
    [self changeKeyboardHeight:_keyboardDistanceToMove];
    
}

- (void)keyBoardDown:(id)sender{
    [self.view endEditing:YES];
    [self endEdit];
    
    
}
// 正在聊天时有信息到达。
- (void)hasNewMessageArrived:(NSNotification *)sender{
    
    [_tableView reloadData];
    [self position2TableLastElement];
    
    
}


- (void)addImage:(UIButton *)sender{
    [self endEdit];
    [self.view endEditing:YES];
    _actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从本地选取",@"从相机拍照", nil];
    
    [_actionSheet showInView:self.view];
    
}
//选择图片
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%s  %i",__FUNCTION__,buttonIndex);
    
    NSUInteger sourceType = 0;
    
    //    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    switch (buttonIndex) {
            //            从本地选择
        case kFromLocalMemory:
        {
            
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
        }
            break;
            //            从相机拍照
        case kFromCamera:
        {
            
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
            break;
            //            取消
        case kCancel:
        {
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
    
    
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *imageType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSURL *imageReferenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    NSString *imageReferenceStr = [NSString stringWithFormat:@"%@",imageReferenceURL];
    NSArray *extArr = [imageReferenceStr componentsSeparatedByString:@"&"];
    
    
    NSString *extStr = [extArr lastObject];
    
    NSArray *extNameArr = [extStr componentsSeparatedByString:@"="];
    NSString *extName = [extNameArr lastObject];
    
    
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        
        
        
        
        
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    
    
    
    
    
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    //    [self saveImage:image withName:@"currentImage.png"];
    //
    //    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    //
    //    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //
    //    isFullScreen = NO;
    //    [self.imageView setImage:savedImage];
    //
    //    self.imageView.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}


- (ChatMessageModel *)createSendeMessageWithMessageContent:(NSString *)messageStr{
    
    ChatMessageModel *message = [[ChatMessageModel alloc] init];
    message.message = messageStr;
    
    /*
     {"back_type":"msg","send_user":"18676720523","send_user_type":"1","get_user":"ceshi1","get_user_type":"2","message":"33333","time":"2014-03-08 14:29:08"}
     */
    
    NSString *username = USERNAME;
    message.sendUser = username;
    message.sendUserType = @"2";
    message.getUser = _currentConversitionObj;
    message.getUserType = @"1";
    
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormetter = [[NSDateFormatter alloc] init];
    dateFormetter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *currentTime = [dateFormetter stringFromDate:date];
    message.time = currentTime;
    
    message.isSendByMe = YES;
    
    
    return message;
    
}

- (void)sendButtonClick:(id ) sender{
    if (![[LoginJudgeSingleton shareLoginJudge] isLogin]) {
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有登录，无法完成此操作，需要现在登录吗？" delegate:self cancelButtonTitle:@"现在登录" otherButtonTitles:@"稍后登录", nil];
        
        [_alertView show];
        
        return;
    }
    
    NSString *sendTxt = _textField.text;
    
    ChatMessageModel *sendMessage = [self createSendeMessageWithMessageContent:sendTxt];
    if (self.isChatWithServer) {
        sendMessage.getUserType = @"2";
        NSString *serverName = [[NSUserDefaults standardUserDefaults] objectForKey:@"ChatServerName"];
        if (serverName) {
            
            sendMessage.getUser = serverName;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage2ServerNSNotification" object:sendMessage];
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage" object:sendMessage];
    }
    //    [_dataSourceArr addObject:sendMessage];
    
    //    刷新表
    [_tableView reloadData];
    //
    _textField.text = @"";
    //
    
    [self position2TableLastElement];
    
}

- (void)position2TableLastElement{
    
    //   每次发完后让表显示到最后一行
    if (_dataSourceArr.count > 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataSourceArr.count - 1 inSection:0];
        
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
}
- (UIView *)creatBubbleView:(ChatMessageModel *)aMessageModel withFromWhere:(BOOL)isMe{
    
    //    NSString *myName = [[NSUserDefaults standardUserDefaults] objectForKey:USERNAME];
    
    UIView *globalView = [[UIView alloc] init];
    NSString *myName = USERNAME;
    NSString *sendByWhere = [NSString stringWithFormat:@"%@",isMe?myName:aMessageModel.sendUser];
    NSString *showMessage = [NSString stringWithFormat:@"%@: %@",sendByWhere,aMessageModel.message];
    UIFont *font = [UIFont systemFontOfSize:14];
    
    
    //    此处 180 是与要显示字符的label的宽度一致。 这样可以同步换行，计算出同等的高度
    CGSize size = [showMessage sizeWithFont:font constrainedToSize:CGSizeMake(160, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    UIView *contentView = [[UIView alloc] init];
    NSString *imageName = isMe?@"ChatNowDetialBG1":@"ChatNowDetialBG2";
    
    UIImage *image = [UIImage imageNamed:imageName];
    //   拉伸图片方法 第一个参数：
    //    设置图片的边帽，可以根据墨一个像素点区拉伸图片
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:50];
    //    [image stretchableImageWithLeftCapWidth:<#(NSInteger)#> topCapHeight:<#(NSInteger)#>]
    //    image = [image resizableImageWithCapInsets:(20,5,10,5)]
    
    //    UIEdgeInsets *edge = ;
    //    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 35, 5)];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:image];
    
    bubbleImageView.frame = CGRectMake(0, 0, 200, 20+ size.height);
    [contentView addSubview:bubbleImageView];
    
    UIImageView *headPortrait = [[UIImageView alloc] initWithImage:[UIImage imageNamed:isMe?@"ChatNowDetialHead1":@"ChatNowDetialHead2"]];
    //    headPortrait.frame = CGRectMake(10, 0, 50, 50);
    //    [vie addSubview:headPortrait];
    
    
    UILabel *timeLab = [[UILabel alloc] init];
    
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textColor = [UIColor grayColor];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *timeDate = [dateFormatter dateFromString:aMessageModel.time];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSString *timeStr = [dateFormatter stringFromDate:timeDate];
    timeLab.font = [UIFont systemFontOfSize:12];
    
    timeLab.text = timeStr;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 160, size.height)];
    label.backgroundColor = [UIColor clearColor];
    
    label.numberOfLines = 0;
    label.font = font;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = showMessage;
    [contentView addSubview:label];
    [globalView addSubview:timeLab];
    [globalView addSubview:headPortrait];
    [globalView addSubview:contentView];
    //    根据发送方来确实视图的位置和朝向
    if (isMe) {
        
        globalView.frame = CGRectMake(60, 0, 260, size.height + 80);
        contentView.frame = CGRectMake(5.0f, 30.0f, 160.0f, size.height+ 20);
        headPortrait.frame = CGRectMake(205.0f, 30.0f, 40.0f, 40.0f);
        timeLab.frame = CGRectMake(140.0f, 0.0f, 140.0f, 30.0f);
        
        
    }else{
        globalView.frame = CGRectMake(0, 0, 260, size.height + 80);
        contentView.frame = CGRectMake(55.0f, 30.0f, 160.0f, size.height+ 20);
        headPortrait.frame = CGRectMake(15.0f, 30.0f, 40.0f, 40.0f);
        timeLab.frame = CGRectMake(20.0f, 0.0f, 140.0f, 30.0f);
    }
    
    return globalView;
    
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([[LoginJudgeSingleton shareLoginJudge] isLogin]) {
        
        return YES;
    }else{
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有登录，无法完成此操作，需要现在登录吗？" delegate:self cancelButtonTitle:@"现在登录" otherButtonTitles:@"稍后登录", nil];
        
        [_alertView show];
        
        return NO;
    }
    
    
    
    
}

#pragma mark-
#pragma mark UIAlertViewDelegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    加载登录页面
    if (0 == buttonIndex) {
        
        LandViewController *loginVC = [[LandViewController alloc] init];
        
        [self presentModalViewController:loginVC animated:YES];
    }
    
}


//输入框获得第一响应
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    [self changeKeyboardHeight:0.0f];
    
    
}
//"改变控件尺寸以适应键盘高度"
- (void)changeKeyboardHeight:(CGFloat)currentKeyboardHeigetDistance{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    _tableView.frame =CGRectMake(0, 20, 320, SCREENMAIN_HEIGHT - 44 - 216 - currentKeyboardHeigetDistance);
    _toolBar.frame = CGRectMake(0, SCREENMAIN_HEIGHT - 44 -216 - currentKeyboardHeigetDistance, 320, 44);
    [UIView commitAnimations];
    
    
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatMessageModel *messageModel = [_dataSourceArr objectAtIndex:indexPath.row];
    
    UIView *vie = [self creatBubbleView:messageModel withFromWhere:messageModel.isSendByMe];
    return vie.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    
    ChatMessageModel *messageModel = [_dataSourceArr objectAtIndex:indexPath.row];
    
    UIView *vie = [self creatBubbleView:messageModel withFromWhere:messageModel.isSendByMe];
    
    [cell.contentView addSubview:vie];
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_textField resignFirstResponder];
    
    [self endEdit];
}

- (void)endEdit{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    
    _toolBar.frame = CGRectMake(0, SCREENMAIN_HEIGHT - 44, 320, 44);
    _tableView.frame = CGRectMake(0, 20, 320, SCREENMAIN_HEIGHT - 44);
    
    [UIView commitAnimations];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
