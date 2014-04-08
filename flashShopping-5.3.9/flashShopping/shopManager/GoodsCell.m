//
//  GoodsCell.m
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
/*
 @property ( nonatomic , retain )UIImageView         *goodsImgView;                      //缩略图路径
 @property ( nonatomic , retain )UILabel                   *isUpLabel;                         //商品是否上架
 @property ( nonatomic , retain )UILabel                   *nameLabel;                         //商品名称
 @property ( nonatomic , retain )UILabel                   * idLabel;                            //商品ID
 @property ( nonatomic , retain )UILabel                   *priceLabel;                        //价格（字体）
 @property ( nonatomic , retain )UILabel                   *priceMoneyLabel;                    //闪购价
 @property ( nonatomic , retain )UILabel                   *numLabel;                          //库存 （字体）
 @property ( nonatomic , retain )UILabel
 *numNumberabel;                         //库存
 */

#import "GoodsCell.h"
#import "UIImageView+WebCache.h"

@implementation GoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self _initSunView];
       
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)_initSunView
{
    //缩略图路径
    _goodsImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_goodsImgView];
    
    //商品名称
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_nameLabel];
    
    //出售状态
//     _isUpLabel = [[UILabel alloc]init];
//    [_directionsLabel addSubview:_isUpLabel];
    
    //商品ID
    _idLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_idLabel];
     //价格（字体）
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_priceLabel];
    //闪购价
    _priceMoneyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_priceMoneyLabel];
     //库存
    _numLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_numLabel];
     //库存数量
    _numNumberabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_numNumberabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图片
    [_goodsImgView setFrame:CGRectMake(10, 10, 80, 80)];
    [_goodsImgView setImageWithURL:[NSURL URLWithString:_goodsModel.viewUrl] placeholderImage:[UIImage imageNamed:@"init.jpg"]];
    
    //商品名称
    [self setIntroductionText:_goodsModel.name];
    _nameLabel.left = _goodsImgView.right + 5 ;
    
    _nameLabel.top = 10 ;
    _nameLabel.width = self.width - _goodsImgView.width - 20 ;
//    NSLog(@"++++++++++++++++%f",_goodsImgView.right);
    _nameLabel.numberOfLines = 0 ;
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = nameTextColor ;
    _nameLabel.text = [NSString  stringWithFormat:@"              %@",_goodsModel.name];
    
    //出售状态
    _isUpLabel.left = 0 ;
    _isUpLabel.top = 0 ;
    _isUpLabel.textColor = [UIColor redColor];
   // NSLog(@"goodsIsUP = %d",_goodsModel.isUp);
    
//    if ([_goodsModel.isUp isEqualToString:@"1" ]) {
//        _isUpLabel.text = @"[出售中]";
//    }else{
//        _isUpLabel.text = @"[已下架]";
//    }
//    [_isUpLabel sizeToFit];
    
//    //商品ID
//    _idLabel.left = _nameLabel.left ;
//    _idLabel.top  = 10.0f;
////    NSLog(@"%s,%@",__FUNCTION__,NSStringFromCGRect(_nameLabel.frame));
//    _idLabel.text = [NSString stringWithFormat:@"%@",_goodsModel.Id];
//    _idLabel.textColor = [UIColor redColor];
//    _idLabel.backgroundColor = [UIColor clearColor];
//    [_idLabel sizeToFit];
    
    //价格（字体）
    _priceLabel.left = _nameLabel.left ;
    _priceLabel.top = _nameLabel.bottom ;
    _priceLabel.text = @"闪购价:";
    _priceLabel.textColor = priceTextColor ;
    _priceLabel.backgroundColor = [UIColor clearColor];
    [_priceLabel sizeToFit];
   
    
    //闪购价
    _priceMoneyLabel.left = _priceLabel.right;
    _priceMoneyLabel.top = _priceLabel.top;
    _priceMoneyLabel.text = [NSString stringWithFormat:@"  %@",_goodsModel.price];
    _priceMoneyLabel.textColor = [UIColor redColor];
    _priceMoneyLabel.backgroundColor = [UIColor clearColor];
    [_priceMoneyLabel sizeToFit];
    
    //库存
    [_numLabel setFrame:CGRectMake(_priceLabel.left, _priceLabel.bottom, 0, 0)];
    _numLabel.text = @"库存：";
    _numLabel.textColor = priceTextColor ;
    _numLabel.backgroundColor = [UIColor clearColor];
//    [_numLabel sizeToFit];

//    //库存数量
//    [_numNumberabel setFrame:CGRectMake(_numLabel.right, _priceLabel.bottom, 0, 0)];
//    _numNumberabel.text = [NSString stringWithFormat:@"%@",_goodsModel.num] ;
//    _numNumberabel.textColor = nameTextColor ;
//    _numNumberabel.backgroundColor = [UIColor clearColor];
//    [_numNumberabel sizeToFit];
    
  
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString *)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.nameLabel.text = text;
    //设置label的最大行数
    self.nameLabel.numberOfLines = 12;
    CGSize size = CGSizeMake(220, 300);
    CGSize labelSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, labelSize.width, labelSize.height );
    
    //计算出自适应的高度
    if (labelSize.height < 60) {
        frame.size.height = 100 ;
    }else{
        frame.size.height = labelSize.height+60;
    }
    
    self.frame = frame;
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    
//}

@end
