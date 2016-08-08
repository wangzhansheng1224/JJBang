//
//  StudentListCell.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentListCell.h"

@interface StudentListCell ()

@property (nonatomic,strong) UIImageView *imageView_pic;
@property (nonatomic,strong) UILabel *label_name;
@property (nonatomic,strong) UIImageView *imageView_loc;
@property (nonatomic,strong) UILabel *label_loc;
@property (nonatomic,strong) UILabel *label_growing;//成长值
@property (nonatomic,strong) UILabel *label_value;//953
@property (nonatomic,strong) UILabel *label_line;

@end

@implementation StudentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.imageView_pic];
        [self.contentView addSubview:self.label_name];
        [self.contentView addSubview:self.imageView_loc];
        [self.contentView addSubview:self.label_loc];
        [self.contentView addSubview:self.label_growing];
        [self.contentView addSubview:self.label_value];
        [self.contentView addSubview:self.label_line];
        [self layoutPageSubviews];
    }
    return self;
}


#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.imageView_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.top.left.equalTo(@0);
    }];
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(70, 17));
        make.top.equalTo(@22);
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(16);
    }];
    [self.imageView_loc mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.top.equalTo(self.label_name.mas_bottom).with.offset(14);
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(16);
    }];
    [self.label_loc mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(150, 14));
        make.top.equalTo(self.label_name.mas_bottom).with.offset(14);
        make.left.equalTo(self.imageView_loc.mas_right).with.offset(14);
    }];
    [self.label_growing mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(51, 17));
        make.top.equalTo(@19);
        make.right.equalTo(@-16);
    }];
    [self.label_value mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(51, 20));
        make.centerX.equalTo(self.label_growing.mas_centerX);
        make.centerY.equalTo(self.label_loc.mas_centerY);
    }];
    [self.label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 4));
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}


#pragma -
#pragma mark - getters and setters
- (UIImageView *)imageView_pic {

    if (!_imageView_pic) {
        
        _imageView_pic = [[UIImageView alloc] init];
        _imageView_pic.image = [UIImage imageNamed:@"student_icon"];
    }
    return _imageView_pic;
}

- (UILabel *)label_name {

    if (!_label_name) {
        
        _label_name = [[UILabel alloc] init];
        _label_name.text = @"王鹿晗";
        _label_name.font = H2;
    }
    return _label_name;
}

- (UIImageView *)imageView_loc {

    if (!_imageView_loc) {
        
        _imageView_loc = [[UIImageView alloc] init];
        _imageView_loc.image = [UIImage imageNamed:@"activity_location"];
    }
    return _imageView_loc;
}

- (UILabel *)label_loc {

    if (!_label_loc) {
        
        _label_loc = [[UILabel alloc] init];
        _label_loc.text = @"来自北京 望湖公园店";
        _label_loc.textColor = COLOR_ORANGE;
        _label_loc.font = H4;
    }
    return _label_loc;
}

- (UILabel *)label_growing {

    if (!_label_growing) {
        
        _label_growing = [[UILabel alloc] init];
        _label_growing.text = @"成长值";
        _label_growing.textAlignment = NSTextAlignmentCenter;
        [_label_growing sizeToFit];
        _label_growing.textColor = COLOR_ORANGE;
        _label_growing.font = H2;
    }
    return _label_growing;
}

- (UILabel *)label_value {

    if (!_label_value) {
        
        _label_value = [[UILabel alloc] init];
        _label_value.text = @"953";
        _label_value.textAlignment = NSTextAlignmentCenter;
        [_label_value sizeToFit];
        _label_value.textColor = COLOR_GRAY;
        _label_value.font = H1;
    }
    return _label_value;
}

- (UILabel *)label_line {

    if (!_label_line) {
        
        _label_line = [[UILabel alloc] init];
        _label_line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _label_line;
}

@end
