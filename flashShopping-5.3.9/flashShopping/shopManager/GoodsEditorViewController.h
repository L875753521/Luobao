//
//  GoodsEditorViewController.h
//  flashShopping
//
//  Created by SG on 14-3-26.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomUIBarButtonItem.h"


@interface GoodsEditorViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,barButtonProtocol>

{
    CGFloat         _bodyTop ;
    CGFloat         _textFieldBottom ;
    CGFloat         _KeyboardHeight ;
    NSInteger      _textFieldTag ;
    UIButton       *_StateButton ;
    UIButton       *_recommendButton ;
    NSMutableDictionary     *_mutableDict ;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *bodyView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *goodTitleBg;

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *goodCodeTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *goodPriceTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *goodNumTextField;


@property ( nonatomic , retain )NSNumber *Id ;
@property ( nonatomic , retain )NSNumber *goodsId ;



@end
