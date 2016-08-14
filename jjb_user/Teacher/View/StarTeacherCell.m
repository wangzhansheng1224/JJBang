//
//  StarTeacherCell.m
//  jjb_user
//
//  Created by Check on 16/8/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StarTeacherCell.h"

@interface StarTeacherCell ()

@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *locImageV;
@property (nonatomic,strong) UILabel *locLabel;
@property (nonatomic,strong) UIImageView *starImageV;

@end

@implementation StarTeacherCell

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self.contentView addSubview:self.picImageV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.locImageV];
        [self.contentView addSubview:self.locLabel];
        [self.contentView addSubview:self.starImageV];
        
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.top.left.equalTo(@0);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(70, 17));
        make.top.equalTo(@22);
        make.left.equalTo(self.picImageV.mas_right).with.offset(16);
    }];
    [_locImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(14);
        make.left.equalTo(self.picImageV.mas_right).with.offset(16);
    }];
    [_locLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(150, 14));
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(14);
        make.left.equalTo(_locImageV.mas_right).with.offset(14);
    }];
    [_starImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(78, 14));
        make.top.equalTo(@24);
        make.right.equalTo(@-8);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)picImageV {

    if (!_picImageV) {
        
        _picImageV = [[UIImageView alloc] init];
    }
    return _picImageV;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UIImageView *)locImageV {
    
    if (!_locImageV) {
        
        _locImageV = [[UIImageView alloc] init];
    }
    return _locImageV;
}

- (UILabel *)locLabel {
    
    if (!_locLabel) {
        
        _locLabel = [[UILabel alloc] init];
    }
    return _locLabel;
}

- (UIImageView *)starImageV {
    
    if (!_starImageV) {
        
        _starImageV = [[UIImageView alloc] init];
        _starImageV.backgroundColor = JJBRandomColor;
    }
    return _starImageV;
}
@end
