//
//  MySettingIconCell.m
//  jjb_user
//
//  Created by Check on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MySettingIconCell.h"

@interface MySettingIconCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *rightImageV;
@property (nonatomic,strong) UILabel *line;

@end

@implementation MySettingIconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.iconImageV];
        [self.contentView addSubview:self.rightImageV];
        [self.contentView addSubview:self.line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0, 17));
    }];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightImageV.mas_left).with.offset(-10);
        make.centerY.equalTo(_titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((self.height)*4.0/5.0, (self.height)*4.0/5.0));
    }];
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-18);
        make.centerY.equalTo(_titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 16));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COLOR_GRAY;
        _titleLabel.text = @"头像";
    }
    return _titleLabel;
}
-(UIImageView *)iconImageV {
    if (!_iconImageV) {
        _iconImageV = [[UIImageView alloc] init];
        NSURL * url = [NSURL initWithImageURL:[UserModel currentUser].photo Width:100 Height:100];
        [_iconImageV setHeader:url];

    }
    return _iconImageV;
}
- (UIImageView *)rightImageV {
    if (!_rightImageV) {
        _rightImageV = [[UIImageView alloc] init];
        _rightImageV.image = [UIImage imageNamed:@"my_right"];
    }
    return _rightImageV;
}
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

@end
