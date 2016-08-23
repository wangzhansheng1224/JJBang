//
//  MBOrderPayHeadView.m
//  jjb_user
//
//  Created by Maybe on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBOrderPayHeadView.h"

@interface MBOrderPayHeadView ()
/**
 *  图片
 */
@property(nonatomic,weak)UIImageView * iconImageView;
/**
 *  购买商品名
 */
@property(nonatomic,weak)UILabel * orderNameLabel;
/**
 *  价格
 */
@property(nonatomic,weak)UILabel * orderPrice;
@end

@implementation MBOrderPayHeadView

#pragma -
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_WHITE;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
    }];
    [self.orderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
}
#pragma -
#pragma mark


#pragma -
#pragma mark - getter and setter 
-(UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"my_course"];
        _iconImageView = imageView;
        [self addSubview:imageView];
    }
    return _iconImageView;
}

-(UILabel*)orderPrice
{
    if (_orderPrice == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"￥ 1080";
        label.textColor = COLOR_ORANGE;
        [label sizeToFit];
        _orderPrice = label;
        [self addSubview:label];
    }
    return _orderPrice;
}
-(UILabel *)orderNameLabel
{
    if(_orderNameLabel == nil)
    {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"少儿体育";
        [label sizeToFit];
        _orderNameLabel = label;
        [self addSubview:label];
    }
    return _orderNameLabel;
}
@end
