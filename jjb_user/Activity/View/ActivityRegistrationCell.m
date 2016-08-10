//
//  ActivityRegistrationCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/10.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityRegistrationCell.h"

@interface ActivityRegistrationCell ()

@property (nonatomic,strong) UIView *view_line;
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UILabel *label_info;

@end

@implementation ActivityRegistrationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self addSubview:self.view_line];
        [self addSubview:self.label_title];
        [self addSubview:self.label_info];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView=self;
    
    [self.view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.top.mas_equalTo(superView.mas_top);
        make.height.mas_equalTo(@(10));
    }];
    
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.top.equalTo(self.view_line.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    [self.label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.top.equalTo(self.label_title.mas_bottom).with.offset(8);
    }];
}


#pragma -
#pragma mark - getters and setters

-(UIView*) view_line{
    if (!_view_line) {
        _view_line=[[UIView alloc] init];
        _view_line.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _view_line;
}
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
        _label_info.lineBreakMode = NSLineBreakByWordWrapping;
        _label_info.text = @"围绕户外美食的文章，图片均可以参加。充分体现在野外活动中快捷，方便制作户外美食和户外和谐氛围的全过程。";
        [_label_info setContentMode:UIViewContentModeTop];
        
    }
    return _label_info;
}

@end