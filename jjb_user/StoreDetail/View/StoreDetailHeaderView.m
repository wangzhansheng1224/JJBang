//
//  StoreDetailHeaderView.m
//  jjb_user
//
//  Created by Aimee on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StoreDetailHeaderView.h"
#import "StoreDetailKeys.h"

@interface StoreDetailHeaderView ()

@property (nonatomic,strong) UILabel *nameLabel;//名称
@property (nonatomic,strong) UILabel *addressLabel;//地址
@property (nonatomic,strong) UIImageView *picImageV;//门店图片
@property (nonatomic,strong) UILabel *mobileLabel;//电话
@property (nonatomic,strong) UIView *lineView;

@end

@implementation StoreDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:self.picImageV];
        [self addSubview:self.mobileLabel];
        [self addSubview:self.lineView];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 197));
        make.top.left.equalTo(@0);
        make.left.equalTo(@10);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width-10, 20));
        make.top.equalTo(_picImageV.mas_bottom).offset(10);
        make.left.equalTo(@10);
    }];
    [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width-10, 16));
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.equalTo(@10);
    }];

    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width-10, 16));
        make.top.equalTo(_mobileLabel.mas_bottom).with.offset(10);
        make.left.equalTo(@10);

    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@10);
    }];
}


- (void)configWithData:(NSDictionary *)data{
//    NSURL *url=[NSURL initWithImageURL:data[kStoreDetailPhoto] Width:50 Height:50];
//    [self.iconImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
//    [self.nameLabel setText:data[kStoreDetailName]];
//    //[self.ageLabel setText:data[kStoreDetailAge]];
//    if ([data[kStoreDetailSex] integerValue]==1) {
//        [self.sexLabel setText:@"男"];
//    } else if ([data[kStoreDetailSex] integerValue]==0)
//    {
//        [self.sexLabel setText:@"女"];
//    } else
//    {
//        [self.sexLabel setText:@"未知"];
//    }
    
    
}
/*
#pragma -
#pragma mark - getters and setters
- (UIImageView *)picImageV {
    
    if (!_picImageV) {
        
        _picImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_background"]];
        _picImageV.backgroundColor = COLOR_GRAY;
    }
    return _picImageV;
}

- (UIImageView *)iconImageV {
    
    if (!_iconImageV) {
        
        _iconImageV = [[UIImageView alloc] init];
        _iconImageV.image = [UIImage imageNamed:@"student_icon"];
        _iconImageV.layer.cornerRadius = 39;
        _iconImageV.clipsToBounds = YES;
    }
    return _iconImageV;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"王鹿晗";
        _nameLabel.font = H3;
        _nameLabel.textColor = COLOR_WHITE;
    }
    return _nameLabel;
}

- (UILabel *)sexLabel {
    
    if (!_sexLabel) {
        
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"男";
        _sexLabel.font = H3;
        _sexLabel.textColor = COLOR_WHITE;
    }
    return _sexLabel;
}
*/
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}

@end
