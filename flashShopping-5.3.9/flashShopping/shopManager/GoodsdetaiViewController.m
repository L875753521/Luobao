//
//  GoodsdetaiViewController.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-11.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodsdetaiViewController.h"
#import "UIImageView+WebCache.h"
#import "CustomUIBarButtonItem.h"
#import "ModifyInfoViewController.h"
#import "LogisticViewController.h"
#import "GoodsDataModel.h"
#import "GoodsModel.h"
#import "AttrsDataModel.h"
#import "LogisticModel.h"
#import "GoodsEditorViewController.h"

@interface GoodsdetaiViewController ()<barButtonProtocol>
{
    UITableView *goodsTableView;
    UIScrollView *scrollView;
    UIImageView *imageViewgoodsInfoBg ;
    UIImageView *imageViewLogisticInfoBg ;
    UIImageView *imageViewAttrsInfoBg;
    
    UIImageView *goodsImgView;
    UIImageView *goodsFormImg;
    UIImageView *imageViewLogisticInfoBg1 ;
    UIImageView *imageViewLogisticInfoBg2;
    
    NSMutableArray *dataArr;
    GoodsDataModel *goodsDataModel;
    GoodsModel *goodsModel;

    
    UIImageView *_viewUrlImg   ;   //缩略图路径
    UILabel     *_idLabel      ;   //商品ID
    UILabel     *_nameLabel    ;   //商品名称
    UILabel     *_priceTitle   ;   //闪购价(字体)
    UILabel     *_priceLabel   ;   //闪购价
    UILabel     *_auditingDate ;   //审核时间
    UILabel     *_isUpLabel    ;   //是否上架
    UILabel     *_goods        ;   //货品明细
    
    UILabel     *_attrs        ;   //属性
    
    CGFloat     heightSize     ;
    
    
    UILabel *LogisticType ;
    UILabel *LogisticPrice ;
    
}
@end

@implementation GoodsdetaiViewController


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
    self.navigationController.navigationBar.hidden = NO ;
    
    self.titleLabel.text = @"商品详情" ;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomePagebackground"]];
    
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 25, 25) andSetdelegate:self andImageName:@"refresh"];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    
    [self _initView];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
}
#pragma mark----barButtonProtocol
#pragma mark----点击刷新按钮
- (void)actions:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:[NSString stringWithFormat:@"%d" , _index]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中……" ;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUI:) name:@"toGoodsDetaiView" object:nil];
}
#pragma mark----NSNotificationCenter
#pragma mark----更新数据
- (void)refreshUI:(NSNotification*)note
{
    _goodsInfoModel = [note object];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self loadGoodsDataModelInfo];
}
#pragma mark----customMethod
- (void)_initView
{
    heightSize = 0;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, IOS7?SCREENMAIN_HEIGHT:SCREENMAIN_HEIGHT - 64)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
//    scrollView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT+100);
    
    [self.view addSubview:scrollView];
    
    //商品信息img
    imageViewgoodsInfoBg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, SCREENMAIN_WIDTH - 10, 170)];
    imageViewgoodsInfoBg.userInteractionEnabled = YES ;
    imageViewgoodsInfoBg.image = [UIImage imageNamed:@"goodInfoBg"];
    [scrollView addSubview:imageViewgoodsInfoBg];
    
    //物流信息image
    imageViewLogisticInfoBg = [[UIImageView alloc]initWithFrame:CGRectMake(5, imageViewgoodsInfoBg.bottom + 15, SCREENMAIN_WIDTH - 10, 80)];
    imageViewLogisticInfoBg.userInteractionEnabled = YES;
    imageViewLogisticInfoBg.image = [UIImage imageNamed:@"LogisticInfoBg"];
    [scrollView addSubview:imageViewLogisticInfoBg];
    
    
    
    //    //货品明细image
    //    imageViewLogisticInfoBg = [[UIImageView alloc]initWithFrame:CGRectMake(5, imageViewgoodsInfoBg.bottom + 30, SCREENMAIN_WIDTH - 10, 180)];
    //    imageViewLogisticInfoBg.userInteractionEnabled = YES;
    //    imageViewLogisticInfoBg.image = [UIImage imageNamed:@"goodInfoBg"];
    //    [scrollView addSubview:imageViewLogisticInfoBg];
    //
    //    //属性image
    //    imageViewAttrsInfoBg = [[UIImageView alloc]initWithFrame:CGRectMake(5, imageViewLogisticInfoBg.bottom + 30, SCREENMAIN_WIDTH - 10, 180)];
    //    imageViewAttrsInfoBg.userInteractionEnabled = YES ;
    //    imageViewAttrsInfoBg.image = [UIImage imageNamed:@"goodInfoBg"];
    //    [scrollView addSubview:imageViewAttrsInfoBg];
    
    
    
    //    //货品明细image
    //    imageViewLogisticInfoBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, imageViewgoodsInfoBg.bottom + 30, SCREENMAIN_WIDTH - 10, 40)];
    //    imageViewLogisticInfoBg1.image = [UIImage imageNamed:@"landing_002a.png"];
    //    imageViewLogisticInfoBg1.userInteractionEnabled = YES;
    //    [scrollView addSubview:imageViewLogisticInfoBg1];
    //
    //    imageViewLogisticInfoBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, imageViewgoodsInfoBg.bottom + 70, SCREENMAIN_WIDTH - 10, 80)];
    //    imageViewLogisticInfoBg2.image = [UIImage imageNamed:@"landing_003a.png"];
    //    imageViewLogisticInfoBg2.userInteractionEnabled = YES;
    //    [scrollView addSubview:imageViewLogisticInfoBg2];
    
    
    
    //商品信息label
    UILabel *goodsInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 30, 25)];
    goodsInfoLabel.text = @"商品信息" ;
    goodsInfoLabel.font = [UIFont systemFontOfSize:16];
    goodsInfoLabel.backgroundColor = [UIColor clearColor];
    [goodsInfoLabel sizeToFit];
    [imageViewgoodsInfoBg addSubview:goodsInfoLabel];
    
    //小笔按钮
    UIButton *penButton = [UIButton buttonWithType:UIButtonTypeCustom];
    penButton.backgroundColor = [UIColor clearColor];
    [penButton setBackgroundImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
    [penButton addTarget:self action:@selector(editorInfo:) forControlEvents:UIControlEventTouchUpInside];
    [penButton setFrame:CGRectMake(imageViewgoodsInfoBg.width - 80, 13, 16, 16)];
    [imageViewgoodsInfoBg addSubview:penButton];
    
    //编辑按钮
    UIButton *EditorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    EditorButton.titleLabel.font = [UIFont systemFontOfSize:16];
    EditorButton.backgroundColor = [UIColor clearColor];
    [EditorButton setTitle:@"编辑" forState:UIControlStateNormal];
    [EditorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [EditorButton sizeToFit];
    [EditorButton addTarget:self action:@selector(editorInfo:) forControlEvents:UIControlEventTouchUpInside];
    [EditorButton setFrame:CGRectMake(penButton.right + 10, 10, 40, 25)];
    [imageViewgoodsInfoBg addSubview:EditorButton];
    
    
    
    //货品明细label
    UILabel *goodsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 295, 30, 25)];
    goodsLabel.text = @"货品明细" ;
    goodsLabel.font = [UIFont systemFontOfSize:16];
    goodsLabel.backgroundColor = [UIColor clearColor];
    [goodsLabel sizeToFit];
    [scrollView addSubview:goodsLabel];
    
    //小笔按钮
    UIButton *goodsPenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goodsPenButton.backgroundColor = [UIColor clearColor];
    [goodsPenButton setBackgroundImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
    [goodsPenButton addTarget:self action:@selector(editorgoodsInfo:) forControlEvents:UIControlEventTouchUpInside];
    [goodsPenButton setFrame:CGRectMake(scrollView.width - 80, 300, 16, 16)];
    [scrollView addSubview:goodsPenButton];
    
    //编辑按钮
    UIButton *goodsEditorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goodsEditorButton.titleLabel.font = [UIFont systemFontOfSize:16];
    goodsEditorButton.backgroundColor = [UIColor clearColor];
    [goodsEditorButton setTitle:@"编辑" forState:UIControlStateNormal];
    [goodsEditorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goodsEditorButton addTarget:self action:@selector(editorgoodsInfo:) forControlEvents:UIControlEventTouchUpInside];
    [goodsEditorButton setFrame:CGRectMake(scrollView.width - 55, 295, 40, 25)];
    [scrollView addSubview:goodsEditorButton];
    
    
    //    //货品明细label
    //    UILabel *attrsInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 30, 25)];
    //    attrsInfoLabel.text = @"属性列表" ;
    //    attrsInfoLabel.backgroundColor = [UIColor clearColor];
    //    [attrsInfoLabel sizeToFit];
    //    [imageViewAttrsInfoBg addSubview:attrsInfoLabel];
    //
    
    //物流信息label
    UILabel *LogisticInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 30, 25)];
    LogisticInfoLabel.text = @"物流信息" ;
    LogisticInfoLabel.font = [UIFont systemFontOfSize:16];
    [LogisticInfoLabel sizeToFit];
    [imageViewLogisticInfoBg addSubview:LogisticInfoLabel];
    
    //小笔按钮
    UIButton *LogistipenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [LogistipenButton setBackgroundImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
    [LogistipenButton addTarget:self action:@selector(editorLogistiInfo:) forControlEvents:UIControlEventTouchUpInside];
    [LogistipenButton setFrame:CGRectMake(imageViewLogisticInfoBg.width - 80, 13, 16, 16)];
    [imageViewLogisticInfoBg addSubview:LogistipenButton];
    
    //编辑按钮
    UIButton *LogistiEditorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    LogistiEditorButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [LogistiEditorButton setTitle:@"编辑" forState:UIControlStateNormal];
    [LogistiEditorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LogistiEditorButton addTarget:self action:@selector(editorLogistiInfo:) forControlEvents:UIControlEventTouchUpInside];
    [LogistiEditorButton setFrame:CGRectMake(LogistipenButton.right + 10, 10, 40, 25)];
    [imageViewLogisticInfoBg addSubview:LogistiEditorButton];
    
    LogisticType = [[UILabel alloc]init] ;
    [imageViewLogisticInfoBg2 addSubview:LogisticType];
    LogisticPrice = [[UILabel alloc]init ];
    [imageViewLogisticInfoBg2 addSubview:LogisticPrice];
    
    //实例化
    _viewUrlImg  = [[UIImageView alloc]init ];
    [imageViewgoodsInfoBg addSubview:_viewUrlImg];
    _idLabel = [[UILabel alloc]init ] ;
    [imageViewgoodsInfoBg addSubview:_idLabel];
    _nameLabel = [[UILabel alloc]init ];
    [imageViewgoodsInfoBg addSubview:_nameLabel];
    _priceLabel = [[UILabel alloc]init ];
    [imageViewgoodsInfoBg addSubview:_priceLabel];
    _auditingDate = [[UILabel alloc]init ] ;
    [imageViewgoodsInfoBg addSubview:_auditingDate];
    _isUpLabel = [[UILabel alloc]init];
    [_nameLabel addSubview:_isUpLabel];
    
    
    
    //加载数据模型
    [self loadGoodsDataModelInfo];
}

- (GoodsDataModel *)getGoodsDataObjFromJsonDict:(NSDictionary *)jsonDic{
    
    
    GoodsDataModel *tempGoodsDataModel  = [[GoodsDataModel alloc] init];
    
    tempGoodsDataModel.auditingDate = [jsonDic objectForKey:@"auditingDate"];
    tempGoodsDataModel.Id       = [jsonDic objectForKey:@"id"];
    tempGoodsDataModel.isUp     = [jsonDic objectForKey:@"isUp"];
    tempGoodsDataModel.name     = [jsonDic objectForKey:@"name"];
    tempGoodsDataModel.price    = [jsonDic objectForKey:@"price"];
    tempGoodsDataModel.viewUrl  = [jsonDic objectForKey:@"viewUrl"];
    
    NSArray *tempGoodsArr = [jsonDic objectForKey:@"goods"];
    if (tempGoodsArr) {
        
        for (int i = 0; i < tempGoodsArr.count; i ++) {
            
            NSDictionary *dic = [tempGoodsArr objectAtIndex:i];
            if (dic) {
                
                GoodsModel *tempGoodsModel = [[GoodsModel alloc]init];
                
                tempGoodsModel.ID = [dic objectForKey:@"id"];
                tempGoodsModel.num = [dic objectForKey:@"num"];
                tempGoodsModel.price = [dic objectForKey:@"price"];
                NSArray *attsArr = [dic objectForKey:@"atts"];
                
                if (attsArr) {
                    
                    for (int j = 0; j < attsArr.count; j ++) {
                        NSDictionary *attsDic = [attsArr objectAtIndex:j];
                        
                        if (attsDic) {
                            AttrsDataModel *attrsDataModel = [[AttrsDataModel alloc] init];
                            
                            attrsDataModel.customValue = [attsDic objectForKey:@"customValue"];
                            attrsDataModel.skuid = [attsDic objectForKey:@"skuid"];
                            
                            [tempGoodsModel.attrs addObject:attrsDataModel];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                [tempGoodsDataModel.goods addObject:tempGoodsModel];
                
            }
            
            
        }
        
    }
    

    return tempGoodsDataModel;
}

- (void)loadGoodsDataModelInfo
{
    
    NSDictionary *dict = @{@"actionCode":@"444" , @"appType":@"json"};
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *idString =  [NSString stringWithFormat:@"%@",_goodsInfoModel.Id];
    //添加企业Id
    [mutableDict setObject:COMPANYID forKey:@"companyId"];
    [mutableDict setObject:idString forKey:@"id"];
    
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        NSDictionary *jsonDic = result[@"content"];
        NSLog(@"jsonArr==============%@",jsonDic);
        
       goodsDataModel =  [self getGoodsDataObjFromJsonDict:jsonDic];
        
        
        
     //商品图片(缩略图路径)
    [_viewUrlImg setFrame:CGRectMake(10.0f, 60.0f, 80.0f, 80.0f)];
    [_viewUrlImg setImageWithURL:[NSURL URLWithString:goodsDataModel.viewUrl] placeholderImage:[UIImage imageNamed:@"init.jpg"]];
    _viewUrlImg.backgroundColor = [UIColor clearColor];

        
    //商品名称
//    [_nameLabel setFrame:CGRectMake(100, 60, self.view.width - _viewUrlImg.right , 20)];

    _nameLabel.text = [NSString stringWithFormat:@"%@",goodsDataModel.name];

    CGSize size = [goodsDataModel.name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        
    _nameLabel.numberOfLines = 0;
    _nameLabel.frame = CGRectMake(100, 60, 200, size.height +10);
        
//    _nameLabel.height = size.height;
    _nameLabel.textColor = nameTextColor ;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [_nameLabel sizeToFit];
//        _nameLabel.textAlignment = UITextAlignmentLeft;

        
//    //商品状态
//    [_isUpLabel setFrame:CGRectMake(0, 0, 30, 20)];
//    if ([goodsDataModel.isUp isEqualToString:@"1"]) {
//        _isUpLabel.text = @"[已上架]" ;
//    }else{
//        _isUpLabel.text = @"[未上架]" ;
//    }
//    _isUpLabel.textColor = [UIColor redColor];
//    [_isUpLabel setBackgroundColor:[UIColor clearColor]];
//    [_isUpLabel sizeToFit];

//    //商品ID
//    [_idLabel setFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom, 50, 20)];
//    _idLabel.text = [NSString stringWithFormat:@"商品ID : %@",goodsDataModel.Id];
//    [_idLabel sizeToFit];
//    _idLabel.textColor = priceTextColor ;
//    _idLabel.backgroundColor = [UIColor clearColor];



        //闪购价
    if (_priceTitle == nil) {
        _priceTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        [imageViewgoodsInfoBg addSubview:_priceTitle];
        _priceTitle.textColor = priceTextColor ;
    }

    [_priceTitle setFrame:CGRectMake(100, _nameLabel.bottom+10, 50, 20)];
    _priceTitle.text = @"闪购价:" ;
    _priceTitle.font = [UIFont systemFontOfSize:15];
    _priceTitle.backgroundColor = [UIColor clearColor];
    [_priceTitle sizeToFit];

      //价格数据
    [_priceLabel setFrame:CGRectMake(_priceTitle.right, _priceTitle.origin.y , 50, 20)];
    _priceLabel.text = [NSString stringWithFormat:@" %@",goodsDataModel.price];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor redColor] ;
    _priceLabel.backgroundColor = [UIColor clearColor];
    [_priceLabel sizeToFit];

       //商品审核时间

    [_auditingDate setFrame:CGRectMake(_idLabel.left+100, _priceLabel.bottom+15, 50, 20)];
    _auditingDate.hidden = NO ;
    _auditingDate.text = [NSString stringWithFormat:@"上架  %@",goodsDataModel.auditingDate];
    _auditingDate.font = [UIFont systemFontOfSize:15];
    _auditingDate.textColor = priceTextColor;
    _auditingDate.backgroundColor = [UIColor clearColor];
    [_auditingDate sizeToFit];
        
        
    
    //解析货品明细(将集合类型转为数组类型)
    NSArray *goodsArr = (NSArray *)goodsDataModel.goods;

        for (int i = 0; i < goodsArr.count; i++) {

            GoodsModel *tempGoodsModel = goodsArr[i];
            
            if (tempGoodsModel) {
                
                //货品明细imageView
                goodsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 320+130*i, SCREENMAIN_WIDTH - 10, 120)];
                goodsImgView.userInteractionEnabled = YES;
                goodsImgView.image = [UIImage imageNamed:@"textFieldView@x2"];
            
                [scrollView addSubview:goodsImgView];
                
                
                heightSize = goodsImgView.frame.origin.y+120;
                
                
                //            //货品ID
                //            UILabel *_goodsCodeId = [[UILabel alloc] initWithFrame:CGRectMake(10, 45+70*i, 50, 20)];
                //
                //            _goodsCodeId.text = [NSString stringWithFormat:@"货品ID：%@",goodsModel.ID];
                //            _goodsCodeId.textColor = priceTextColor ;
                //            _goodsCodeId.backgroundColor = [UIColor clearColor];
                //            [_goodsCodeId sizeToFit];
                //            [imageViewLogisticInfoBg addSubview:_goodsCodeId];
                
                //商品库存
                UILabel *_goodsNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 5+1*i, 50, 20)];
                _goodsNum.text = [NSString stringWithFormat:@"库 存:  %@",tempGoodsModel.num];
                _goodsNum.textColor = priceTextColor ;
                _goodsNum.font = [UIFont systemFontOfSize:15];
                _goodsNum.backgroundColor = [UIColor clearColor];
                [_goodsNum sizeToFit];
                [goodsImgView addSubview:_goodsNum];
                
                
                //价格
                UILabel *_goodsPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 25+1*i, 50, 20)];
                
                _goodsPrice.text = [NSString stringWithFormat:@"价 格:  %@",tempGoodsModel.price];
                _goodsPrice.textColor = priceTextColor;
                _goodsPrice.font = [UIFont systemFontOfSize:15];
                _goodsPrice.backgroundColor = [UIColor clearColor];
                [_goodsPrice sizeToFit];
                [goodsImgView addSubview:_goodsPrice];
                
                
                goodsFormImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 55+1*i, 300, 60)];
                goodsFormImg.userInteractionEnabled = YES;
                goodsFormImg.image = [UIImage imageNamed:@"GoodsForm"];
                [goodsImgView addSubview:goodsFormImg];

                
                //解析货品明细：属性(将集合类型转为数组类型)
                NSArray *attrsArr = (NSArray *)tempGoodsModel.attrs;
                for (int j = 0; j < attrsArr.count; j++) {
                    
                    AttrsDataModel *tempAttrsDataModel = attrsArr[j];
                    
                    if (tempAttrsDataModel) {
                        
                        //skuid
                        UILabel *_skuid = [[UILabel alloc] initWithFrame:CGRectMake(45, 5+30*j, 50, 20)];
                        
                        _skuid.text = [NSString stringWithFormat:@"%@",tempAttrsDataModel.skuid];
                        
                        _skuid.font = [UIFont systemFontOfSize:15];
                        
                        _skuid.textColor = priceTextColor;
                        _skuid.backgroundColor = [UIColor clearColor];
                        [_skuid sizeToFit];
                        
                        [goodsFormImg addSubview:_skuid];
                        
                        //customValue自定义值
                        UILabel *_customValue = [[UILabel alloc] initWithFrame:CGRectMake(220, 5+30*j, 50, 20)];
                        
                        _customValue.text = [NSString stringWithFormat:@"%@",tempAttrsDataModel.customValue];
                        _customValue.font = [UIFont systemFontOfSize:15];
                        _customValue.textColor = priceTextColor;
                        
                        _customValue.backgroundColor = [UIColor clearColor];
                        [_customValue sizeToFit ];
                        [goodsFormImg addSubview:_customValue];
                        
                    }

                }
                    
            }
                
        }

        
        //物流页面数据的获取和布局UI
        [self logisticsView];
        
        scrollView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, heightSize);
//        NSLog(@" --------------- %f",heightSize);



    if (_nameLabel.height + 80 >130) {
        imageViewgoodsInfoBg.height = _nameLabel.height + 120 ;

    }else
    {
        imageViewgoodsInfoBg.height = 171 ;
    }
    imageViewLogisticInfoBg2.top = imageViewgoodsInfoBg.bottom + 30 ;

    }];
}
- (void)logisticsView{
    
    //请求获取货品运费
    NSDictionary *logisticsDic = @{@"actionCode":@"443" , @"appType":@"json"};
    NSMutableDictionary *logisticsMutableDict = [[NSMutableDictionary alloc]initWithDictionary:logisticsDic];
    NSString *logisticsIdString =  [NSString stringWithFormat:@"%@",goodsDataModel.Id];
    
    //添加企业Id
    //    [logisticsMutableDict setObject:COMPANYID forKey:@"companyId"];
    [logisticsMutableDict setObject:logisticsIdString forKey:@"productId"];
    
    [SGDataService requestWithUrl:BASEURL dictParams:logisticsMutableDict httpMethod:@"post" completeBlock:^(id result){
        //        NSDictionary *json = result[@"content"];
        //        NSLog(@"jsonArr==============%@",json);
        //        if (json) {
        //
        //            //把数据装入数据模型
        //            goodsDataModel = [[GoodsDataModel alloc] initWithDataDic:json];
        //        }
        
        
        //物流
        LogisticType = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 20, 20)];
        LogisticType.text = @"普通物流" ;
        LogisticType.font = [UIFont systemFontOfSize:15];
        LogisticType.textColor = priceTextColor ;
        [LogisticType sizeToFit];
        [imageViewLogisticInfoBg addSubview:LogisticType];
        
        //快递费
        LogisticPrice = [[UILabel alloc] initWithFrame:CGRectMake(LogisticType.right + 20, 45, 20, 20)];
        //        NSLog(@"godsDataModel ====== %@",);
        //        if ([LogisticModel.baseprice isEqualToString:@"0"]) {
        //
                    LogisticPrice.text = @" 免运费";
        //        }else{
        //
        //            LogisticPrice.text = goodsDataModel.baseprice;
        //        }
        LogisticPrice.font = [UIFont systemFontOfSize:15];
        LogisticPrice.textColor = [UIColor greenColor];
        [LogisticPrice sizeToFit];
        [imageViewLogisticInfoBg addSubview:LogisticPrice];
        
    }];
}
//商品编辑
- (void)editorInfo:(UIButton*)sender
{
    ModifyInfoViewController *modifyInfoViewCtl = [[ModifyInfoViewController alloc]init];
    modifyInfoViewCtl.Id = goodsDataModel.Id;
    modifyInfoViewCtl.goodsId = goodsModel.ID;
    [self.navigationController pushViewController:modifyInfoViewCtl animated:YES];
}
//物流编辑
- (void)editorLogistiInfo:(UIButton*)sender
{
    LogisticViewController *logisticViewCtl = [[LogisticViewController alloc]init];
    [self.navigationController pushViewController:logisticViewCtl animated:YES];
}
//货品编辑
- (void)editorgoodsInfo:(UIButton *)sender
{
    GoodsEditorViewController *goodsEditorViewCtl = [[GoodsEditorViewController alloc] init];
    
    [self.navigationController pushViewController:goodsEditorViewCtl animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
