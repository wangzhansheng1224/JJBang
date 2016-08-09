//
//  MBSaleTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBSaleCell.h"

@interface MBSaleCell ()
/**
 *  图片
 */
@property(nonatomic,weak) UIImageView * scaleImageView;
/**
 *  商品名
 */
@property(nonatomic,weak) UILabel * scaleTitleLabel;
/**
 *  价格
 */
@property(nonatomic,weak) UILabel * scalePriceLabel;

@end
@implementation MBSaleCell


#pragma
#pragma mark - life cycle

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
     [self addAllChildViewConstaint];
    }
    return self;

}
#pragma 
#pragma mark - private methods
-(void)addAllChildViewConstaint
{
    [self.scaleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.scaleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scaleImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.scaleImageView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
    }];
    [self.scalePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scaleTitleLabel.mas_centerY);
//        make.left.equalTo(self.scaleTitleLabel.mas_right).offset(50);
        make.right.equalTo(self.contentView.mas_right);
    }];
}
#pragma 
#pragma mark - getter and setter
-(UIImageView *)scaleImageView
{
    if (_scaleImageView == nil) {
        UIImageView * scaleImageView = [[UIImageView alloc]init];
        scaleImageView.image = [UIImage imageNamed:@"img_default"];
    
        [self.contentView addSubview:scaleImageView];
        _scaleImageView = scaleImageView;
        

    }
    return _scaleImageView;
}
-(UILabel *)scaleTitleLabel
{
    if (_scaleTitleLabel == nil) {
        UILabel * scaleTitleLabel = [[UILabel alloc]init];
        scaleTitleLabel.text = @"特惠商品测试";
        scaleTitleLabel.font = H4;
        [self.contentView addSubview:scaleTitleLabel];
        _scaleTitleLabel = scaleTitleLabel;
 
    }
    return _scaleTitleLabel;
}

-(UILabel *)scalePriceLabel
{
    if (_scalePriceLabel == nil) {
        UILabel * scalePriceLabel = [[UILabel alloc]init];
        scalePriceLabel.text = @"价格测试";
        scalePriceLabel.font = H4;
        [self.contentView addSubview:scalePriceLabel];
        _scalePriceLabel = scalePriceLabel;
    }
    return _scalePriceLabel;
}
@end
