//
//  ShopClassifyCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopClassifyCell.h"

@interface ShopClassifyCell ()
@property(nonatomic,weak) UIImageView * classifyImageView;
@property(nonatomic,weak) UILabel * classifyTitleLabel;

@end
@implementation ShopClassifyCell

#pragma 
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addsubViewConstaint];
    }
    return self;
}


#pragma 
#pragma mark - private methods

-(void)addsubViewConstaint
{
    [self.classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@49);
    }];
    [self.classifyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.classifyImageView.mas_bottom).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(2);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
}

#pragma 
#pragma mark - getter and setter
-(UIImageView *)classifyImageView
{

    if (_classifyImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        _classifyImageView = imageView;
    }
    return _classifyImageView;
}

-(UILabel *)classifyTitleLabel
{
    if (_classifyTitleLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"分类";
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        _classifyTitleLabel = label;
    }
    return _classifyTitleLabel;
}
@end
