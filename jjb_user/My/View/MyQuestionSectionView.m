//
//  MyQuestionSectionView.m
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyQuestionSectionView.h"

@interface MyQuestionSectionView ()

@property (nonatomic,strong) UILabel *line;

@end

@implementation MyQuestionSectionView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightImageV];
        [self addSubview:self.line];
        [self layoutPageSubviews];
    }
    return self;
}



- (void)layoutPageSubviews {
    
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(17, 9));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@10);
        make.height.equalTo(@17);
        make.width.equalTo(@200);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}
- (UIImageView *)rightImageV {
    if (!_rightImageV) {
        _rightImageV = [[UIImageView alloc] init];
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
