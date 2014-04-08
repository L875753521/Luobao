//
//  LogisticViewController.h
//  flashShopping
//
//  Created by Width on 14-2-26.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomUIBarButtonItem.h"

@interface LogisticViewController : BaseViewController<barButtonProtocol>
{
    UIButton *_logisticButton ;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIView *bodyView;
- (IBAction)logisticStatus:(id)sender;

@end
