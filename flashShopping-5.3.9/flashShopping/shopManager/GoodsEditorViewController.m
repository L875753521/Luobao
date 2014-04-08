//
//  GoodsEditorViewController.m
//  flashShopping
//
//  Created by SG on 14-3-26.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodsEditorViewController.h"

@interface GoodsEditorViewController ()

@end

@implementation GoodsEditorViewController

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
    self.titleLabel.text = @"编辑货品";
    _bodyView.top = 0 ;
    _bodyTop = _bodyView.top ;
    _bodyView.userInteractionEnabled = YES ;
    //_bodyView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT + 60);
    //创建导航栏上的保存按钮
    CustomUIBarButtonItem *saveButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 40, 25) andSetdelegate:self andImageName:@"save"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    //适配
    self.bodyView.height = SCREENMAIN_HEIGHT ;
    self.bodyView.width = SCREENMAIN_WIDTH ;
    if (IOS_VERSION < 7.0) {
        self.bodyView.top = 44 ;
    }
    
    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyFrame:) name:UIKeyboardWillShowNotification object:Nil];
    
    //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    
    [topView setItems:buttonsArray];
    
    [_goodCodeTextField setInputAccessoryView:topView];
    [_goodPriceTextField setInputAccessoryView:topView];
    [_goodNumTextField setInputAccessoryView:topView];
    
    //post (  NSDictionary )
    NSDictionary *dict = @{@"actionCode":@"446" , @"appType":@"json" };
    _mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ( textField.tag == 6 || textField.tag ==7 ) {
        [UIView animateWithDuration:0.5 animations:^{
            _bodyView.top = _bodyTop ;
        }];
    }
    return YES ;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textFieldTag = textField.tag ;
    _textFieldBottom = textField.bottom ;
    [self setFrame:_textFieldBottom andKeyboardHeight:_KeyboardHeight andTextFieldTag:_textFieldTag];
    return YES ;
}
#pragma mark--- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _textFieldTag = 0 ;
    return YES ;
}
//Enter做键盘的响应键
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark----NSNotificationCenter
- (void)modifyFrame:(NSNotification*)note
{
    CGRect rect = [[[note userInfo]objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    _KeyboardHeight = rect.size.height ;
    [self setFrame:_textFieldBottom andKeyboardHeight:_KeyboardHeight andTextFieldTag:_textFieldTag];
    
}
#pragma mark---MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---customModth
#pragma mark---保存
- (void)actions:(id)sender
{
//    //必须post字段
//    [_mutableDict setObject:COMPANYID forKey:@"companyId"];
//    [_mutableDict setObject:_Id forKey:@"Id"];
//    [_mutableDict setObject:_goodsId forKey:@"goodsId"];
//    //非必须post字段
//    
//    [_mutableDict setObject:_goodCodeTextField.text forKey:@"goodsCode"];
//    [_mutableDict setObject:_goodPriceTextField.text forKey:@"price"];
//    [_mutableDict setObject:_goodNumTextField.text forKey:@"num"];
//    //NSLog(@"dict = %@",_mutableDict);
//    
//    //提交修改
//    [SGDataService requestWithUrl:BASEURL dictParams:_mutableDict httpMethod:@"post" completeBlock:^(id result){
//        //NSLog(@"%@",result[@"content"]);
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:result[@"content"] delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil , nil];
//        [alertView show];
//    }];
    
}
//键盘自适应
- (void)setFrame:(CGFloat)textFieldBottom andKeyboardHeight:(CGFloat)keyboardHeight andTextFieldTag:(NSInteger)textFieldTag
{
    if ( textFieldTag == 6 || textFieldTag ==7 ) {
        [UIView animateWithDuration:0.5 animations:^{
            _bodyView.top =- (textFieldBottom - (_bodyView.height - keyboardHeight - 64));
        }];
    }
}
//点击完成
- (void)dismissKeyBoard
{
    
    [_goodCodeTextField resignFirstResponder];
    [_goodPriceTextField resignFirstResponder];
    [_goodNumTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        _bodyView.top = _bodyTop ;
    }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}
@end
