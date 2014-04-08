//
//  SelectRowViewController.m
//  flashShopping
//
//  Created by Width on 14-1-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "SelectRowViewController.h"

@interface SelectRowViewController ()

@end

@implementation SelectRowViewController
@synthesize navgationTitle=_navgationTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setNavgationTitle:(NSString *)navgationTitle{
    
    if (_navgationTitle!=navgationTitle) {
        _navgationTitle=nil;
        _navgationTitle=[navgationTitle copy];
    }
    self.title=_navgationTitle;
}
@end
