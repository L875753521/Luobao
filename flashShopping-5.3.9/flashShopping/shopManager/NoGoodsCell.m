//
//  NoGoodsCell.m
//  flashShopping
//
//  Created by SG on 14-3-27.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "NoGoodsCell.h"
#import "UIImageView+WebCache.h"

@implementation NoGoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self _initSunView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)_initSunView
{
    //缩略图路径
    _noGoodsViewUrl = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_noGoodsViewUrl];
    
    //商品名称
    _noGoodsNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_noGoodsNameLabel];
    
    
    //商品ID
    _noGoodsIdLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_noGoodsIdLabel];
    //价格（字体）
    _noGoodsPriceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_noGoodsPriceLabel];
    //闪购价
    _noGoodsPriceMoneyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_noGoodsPriceMoneyLabel];
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图片
    [_noGoodsViewUrl setFrame:CGRectMake(10, 10, 80, 80)];
    [_noGoodsViewUrl setImageWithURL:[NSURL URLWithString:_noGoodsModel.noGoodsViewUrl] placeholderImage:[UIImage imageNamed:@"init.jpg"]];
    
    //商品名称
    [self setIntroductionText:_noGoodsModel.noGoodsName];
    _noGoodsNameLabel.left = _noGoodsViewUrl.right + 5;
    _noGoodsNameLabel.top = 10 ;
    _noGoodsNameLabel.width = self.width - _noGoodsViewUrl.width - 20 ;
    //    NSLog(@"++++++++++++++++%f",_goodsImgView.right);
    _noGoodsNameLabel.numberOfLines = 0 ;
    _noGoodsNameLabel.backgroundColor = [UIColor clearColor];
    _noGoodsNameLabel.textColor = nameTextColor ;
    _noGoodsNameLabel.text = [NSString  stringWithFormat:@"              %@",_noGoodsModel.noGoodsName];
    
    
    
    //商品ID
    _noGoodsIdLabel.left = _noGoodsNameLabel.left ;
    _noGoodsIdLabel.top  = 10.0f;
    //    NSLog(@"%s,%@",__FUNCTION__,NSStringFromCGRect(_nameLabel.frame));
    _noGoodsIdLabel.text = [NSString stringWithFormat:@"%@",_noGoodsModel.noGoodsId];
    _noGoodsIdLabel.textColor = [UIColor redColor];
    _noGoodsIdLabel.backgroundColor = [UIColor clearColor];
    [_noGoodsIdLabel sizeToFit];
    
    //价格（字体）
    _noGoodsPriceLabel.left = _noGoodsNameLabel.left ;
    _noGoodsPriceLabel.top = _noGoodsNameLabel.bottom ;
    _noGoodsPriceLabel.text = @"闪购价:";
    _noGoodsPriceLabel.textColor = priceTextColor ;
    _noGoodsPriceLabel.backgroundColor = [UIColor clearColor];
    [_noGoodsPriceLabel sizeToFit];
    
    
    //闪购价
    _noGoodsPriceMoneyLabel.left = _noGoodsPriceLabel.right;
    _noGoodsPriceMoneyLabel.top = _noGoodsPriceLabel.top;
    _noGoodsPriceMoneyLabel.text = [NSString stringWithFormat:@"  %@",_noGoodsModel.noGoodsPrice];
    _noGoodsPriceMoneyLabel.textColor = [UIColor redColor];
    _noGoodsPriceMoneyLabel.backgroundColor = [UIColor clearColor];
    [_noGoodsPriceMoneyLabel sizeToFit];
    
    
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString *)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.noGoodsNameLabel.text = text;
    //设置label的最大行数
    self.noGoodsNameLabel.numberOfLines = 12;
    CGSize size = CGSizeMake(220, 300);
    CGSize labelSize = [self.noGoodsNameLabel.text sizeWithFont:self.noGoodsNameLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.noGoodsNameLabel.frame = CGRectMake(self.noGoodsNameLabel.frame.origin.x, self.noGoodsNameLabel.frame.origin.y, labelSize.width, labelSize.height );
    
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
