//
//  MBNavgationCenterView.m
//  jjb_user
//
//  Created by Maybe on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBNavgationCenterView.h"

@interface MBNavgationCenterView ()

@property(nonatomic,strong)UIImageView * iconImageView;

@end
@implementation MBNavgationCenterView

#pragma -
#pragma mark -life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviewConstraints];
    }
    return self;
}


#pragma -
#pragma mark - private methods

-(void)addSubviewConstraints
{
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(2);
                make.top.equalTo(self.mas_top).offset(2);
                make.centerY.equalTo(self.mas_centerY);
        
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopNameLabel.mas_right).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@15);
    }];
}


#pragma -
#pragma mark - getter and setter
-(UIImageView *)iconImageView
{
    if(_iconImageView == nil )
    {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"nav_shop_down"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
-(UILabel*)shopNameLabel
{
    if (_shopNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"望湖公园店";
        label.font = H1;
        label.tintColor = COLOR_WHITE;
        label.textColor = COLOR_WHITE;
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];

        _shopNameLabel = label;
    }
    return _shopNameLabel;
}


@end
