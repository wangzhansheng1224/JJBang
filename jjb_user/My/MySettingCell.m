//
//  MySettingCell.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MySettingCell.h"

@interface MySettingCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation MySettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
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
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightImageV.mas_left).with.offset(-10);
        make.centerY.equalTo(_titleLabel.mas_centerY);
        make.left.equalTo(_titleLabel.mas_right).with.offset(10);
        make.height.equalTo(@17);
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
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = COLOR_GRAY;
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
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
- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}
- (void)setContent:(NSString *)content {
    
    self.contentLabel.text = content;
}

@end
