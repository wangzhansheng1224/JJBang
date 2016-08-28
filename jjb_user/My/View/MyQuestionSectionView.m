//
//  MyQuestionSectionView.m
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyQuestionSectionView.h"


@implementation MyQuestionSectionView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightImageV];
        
        [self layout];
    }
    return self;
}



- (void)layout {
    
    [_rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(17, 9));
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
//        make.right.equalTo(_rightImageV.mas_left).with.offset(-10);
        make.height.equalTo(@17);
        make.width.equalTo(@100);
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


@end
