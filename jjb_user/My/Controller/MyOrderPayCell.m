//
//  MyOrderPayCell.m
//  jjb_user
//
//  Created by Check on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderPayCell.h"

@interface MyOrderPayCell ()

@property (nonatomic,strong) UIImageView *imageView_pic;
@property (nonatomic,strong) UILabel *label_class;
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_star;
@property (nonatomic,strong) UILabel *label_teacher;
@property (nonatomic,strong) UIImageView *imageView_moneyIcon;
@property (nonatomic,strong) UILabel *label_money;
@property (nonatomic,strong) UILabel *label_count;//报名人数
@property (nonatomic,strong) UIButton *btn_status;//已报名



@end

@implementation MyOrderPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.imageView_pic];
        [self.contentView addSubview:self.label_class];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.imageView_star];
        [self.contentView addSubview:self.label_teacher];
        [self.contentView addSubview:self.imageView_moneyIcon];
        [self.contentView addSubview:self.label_money];
        [self.contentView addSubview:self.label_count];
        [self.contentView addSubview:self.btn_status];
        
        [self layoutPageSubviews];
    }
    return self;
}

#pragma - 
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_imageView_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(180,120));
        make.top.left.equalTo(@8);
    }];
    
    [_label_class mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageView_pic.mas_top).with.offset(6);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        make.left.equalTo(self.imageView_pic.mas_left).with.offset(0);
    }];
    
    [_label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(@10);
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
    }];
    
    [_imageView_star mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
        make.top.equalTo(_label_title.mas_bottom).with.offset(10);
    }];
    
    [_label_teacher mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageView_star.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
    }];
    
    [_imageView_star mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.label_teacher.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
    }];
    
    [_label_money mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.label_teacher.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        make.left.equalTo(self.imageView_star.mas_right).with.offset(8);
    }];
    
    [_label_count mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.right.equalTo(@-10);
    }];
    
    [_btn_status mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)imageView_pic {

    if (!_imageView_pic) {
        
        _imageView_pic = [[UIImageView alloc] init];
    }
    return _imageView_pic;
}

- (UILabel *)label_class {

    if (!_label_class) {
        
        _label_class = [[UILabel alloc] init];
    }
    return _label_class;
}

- (UILabel *)label_title {

    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
    }
    return _label_title;
}

- (UIImageView *)imageView_star {

    if (!_imageView_star) {
        
        _imageView_star = [[UIImageView alloc] init];
    }
    return _imageView_star;
}

- (UILabel *)label_teacher {

    if (!_label_teacher) {
        
        _label_teacher = [[UILabel alloc] init];
    }
    return _label_teacher;
}

- (UIImageView *)imageView_moneyIcon {

    if (!_imageView_moneyIcon) {
        
        _imageView_moneyIcon = [[UIImageView alloc] init];
    }
    return _imageView_moneyIcon;
}

- (UILabel *)label_money {

    if (!_label_money) {
        
        _label_money = [[UILabel alloc] init];
    }
    return _label_money;
}

- (UILabel *)label_count {

    if (!_label_count) {
        
        _label_count = [[UILabel alloc] init];
    }
    return _label_count;
}

- (UIButton *)btn_status {

    if (!_btn_status) {
        
        _btn_status = [[UIButton alloc] init];
    }
    return _btn_status;
}

@end
