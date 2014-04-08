//
//  FeedbackViewController.h
//  flashShopping
//
//  Created by sg on 14-3-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomUIBarButtonItem.h"


@interface FeedbackViewController :BaseViewController<UITextViewDelegate,UITextFieldDelegate,barButtonProtocol>
{
    UITextView *_opinion;
    UITextField *_contact;
    UIActivityIndicatorView *_indicator;
}
@property (nonatomic,retain) UITextView *opinion;
@end
