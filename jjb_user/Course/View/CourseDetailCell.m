//
//  CourseDetailCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseDetailCell.h"
@interface CourseDetailCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *dropdownImageView;
@end

@implementation CourseDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.dropdownImageView];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    UIView *superView=self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(self.dropdownImageView.mas_right);
        make.bottom.mas_equalTo(superView.mas_bottom);
    }];
    [self.dropdownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.width.mas_equalTo(@(30));
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.bottom.mas_equalTo(superView.mas_bottom);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)dropdownImageView {
    
    if (!_dropdownImageView) {
        _dropdownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"course_down"]];
        _dropdownImageView.backgroundColor=COLOR_WHITE;
    }
    return _dropdownImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"第一节课 拉伸运动";
        _titleLabel.font = H3;
        _titleLabel.textColor=COLOR_GRAY;
        [_titleLabel sizeToFit];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}
@end