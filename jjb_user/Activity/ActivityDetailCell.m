//
//  ActivityDetailCell.m
//  jjb_user
//
//  Created by Check on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailCell.h"

@interface ActivityDetailCell ()

@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UILabel *label_info;

@end

@implementation ActivityDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_info];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 16));
        make.top.equalTo(@66);
        make.left.equalTo(@16);
    }];
    
    [self.label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 16));
        make.top.equalTo(self.label_title.mas_bottom).with.offset(8);
        make.left.equalTo(@6);
    }];
}


#pragma -
#pragma mark - getters and setters
- (UILabel *)label_title {

    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        _label_title.font = H3;
        _label_title.numberOfLines = 1;
        [_label_title sizeToFit];
        _label_title.text = @"活动规则";
    }
    return _label_title;
}

- (UILabel *)label_info {
    
    if (!_label_info) {
        
        _label_info = [[UILabel alloc] init];
        _label_info.font = H4;
        _label_info.numberOfLines = 0;
        _label_info.lineBreakMode = UILineBreakModeWordWrap;
        [_label_info sizeToFit];
        _label_info.text = @"围绕户外美食的文章，图片均可以参加。充分体现在野外活动中快捷，方便制作户外美食和户外和谐氛围的全过程。";
    }
    return _label_info;
}


@end
