//
//  ChatNowDetialViewController.h
//  flashShopping
//
//  Created by sg on 14-3-19.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
@interface ChatNowDetialViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIToolbar   *_toolBar;
    UITextField *_textField;
    UITableView *_tableView;
    BOOL         _isSendByMe;
    CGFloat _keyboardDistanceToMove;
    NSString *_currentConversitionObj;
    UIActionSheet *_actionSheet;
    UIAlertView *_alertView;
    
}
@property (nonatomic, retain)NSMutableArray *dataSourceArr;
@property (nonatomic, assign)BOOL isChatWithServer;
- (id)initWithDataSourceArr:(NSMutableArray *)aDataSourceArr AndChatWithServer:(BOOL)isWithServer;
@end
