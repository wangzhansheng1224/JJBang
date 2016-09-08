//
//  MyFamilyDetailCell.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyFamilyDetailCell.h"

@interface MyFamilyDetailCell ()

@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation MyFamilyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headerImageV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {

    [_headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageV.mas_right).with.offset(10);
        make.centerY.equalTo(_headerImageV.mas_centerY);
        make.right.equalTo(_titleLabel.mas_left);
        make.height.equalTo(@30);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(_headerImageV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)headerImageV {
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc] init];
        _headerImageV.backgroundColor = JJBRandomColor;
        _headerImageV.layer.cornerRadius = 40;
        _headerImageV.clipsToBounds = YES;
    }
    return _headerImageV;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = JJBRandomColor;
        
    }
    return _nameLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = JJBRandomColor;
    }
    return _titleLabel;
}
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}
@end
