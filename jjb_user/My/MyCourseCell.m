//
//  MyCourseCell.m
//  jjb_user
//
//  Created by Check on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyCourseCell.h"
#import "CourseListKey.h"

@interface MyCourseCell ()

@property (nonatomic,strong) UIImageView *imageView_pic;
@property (nonatomic,strong) UILabel *label_class;      //少儿
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_star;
@property (nonatomic,strong) UILabel *label_evaluation; //评价
@property (nonatomic,strong) UILabel *label_teacher;
@property (nonatomic,strong) UILabel *label_status;     //已报名
@property (nonatomic,strong) UIImageView *imageView_moneyIcon;  //￥
@property (nonatomic,strong) UILabel *label_money;
@property (nonatomic,strong) UILabel *label_line;

@end

@implementation MyCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        [self.contentView addSubview:self.imageView_pic];
        [self.contentView addSubview:self.label_class];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.imageView_star];
        [self.contentView addSubview:self.label_evaluation];
        [self.contentView addSubview:self.label_teacher];
        [self.contentView addSubview:self.label_status];
        [self.contentView addSubview:self.imageView_moneyIcon];
        [self.contentView addSubview:self.label_money];
        [self.contentView addSubview:self.label_line];
        [self layoutPageSubviews];
        
    }
    return self;
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    [self.label_title setText:data[kCourseListName]];
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
        
        make.right.mas_equalTo(self.label_status.mas_left);
        make.top.equalTo(@10);
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
    }];
    
    [_imageView_star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
        make.top.equalTo(_label_title.mas_bottom).with.offset(10);
    }];
    
    [_label_evaluation mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@40);
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(self.imageView_star.mas_right).with.offset(8);
    }];
    
    [_label_teacher mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageView_star.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.left.equalTo(self.imageView_pic.mas_right).with.offset(10);
    }];
    
    [_label_status mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.right.equalTo(@-10);
    }];
    
    [_label_money mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.bottom.right.equalTo(@-10);
    }];
    
    [_imageView_moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.label_money.mas_left).with.offset(-10);
    }];
    [_label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 8));
        make.left.equalTo(@0);
        make.top.equalTo(self.imageView_moneyIcon.mas_bottom).with.offset(8);
    }];
}


#pragma -
#pragma mark - getters and setters
- (UIImageView *)imageView_pic {
    
    if (!_imageView_pic) {
        
        _imageView_pic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_default"]];
        
    }
    return _imageView_pic;
}

- (UILabel *)label_class {
    
    if (!_label_class) {
        _label_class = [[UILabel alloc] init];
        _label_class.text = @"少儿";
        _label_class.textColor = [UIColor whiteColor];
        _label_class.numberOfLines = 1;
        
    }
    
    return _label_class;
}

- (UILabel *)label_title {
    
    if (!_label_title) {
        _label_title = [[UILabel alloc] init];
        _label_title.text = @"逻辑思维";
        _label_title.font=H3;
        _label_title.numberOfLines = 1;
        [_label_title setAlpha:0.3];
    }
    
    return _label_title;
}

- (UIImageView *)imageView_star {
    
    if (!_imageView_star) {
        
        _imageView_star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_solid"]];
    }
    
    return _imageView_star;
}

- (UILabel *)label_evaluation {
    
    if (!_label_evaluation) {
        
        _label_evaluation = [[UILabel alloc] init];
        _label_evaluation.backgroundColor = [UIColor lightGrayColor];
        _label_evaluation.text = @"很棒";
        _label_evaluation.font = [UIFont systemFontOfSize:10];
    }
    
    return _label_evaluation;
}

- (UILabel *)label_teacher {
    
    if (!_label_teacher) {
        
        _label_teacher = [[UILabel alloc] init];
        _label_teacher.backgroundColor = [UIColor lightGrayColor];
        _label_teacher.text = @"lulu 老师";
        _label_teacher.font = [UIFont systemFontOfSize:10];
    }
    
    return _label_teacher;
}

- (UILabel *)label_status {
    
    if (!_label_status) {
        
        _label_status = [[UILabel alloc] init];
        _label_status.backgroundColor = [UIColor lightGrayColor];
        _label_status.text = @"已报名";
        _label_status.font = [UIFont systemFontOfSize:10];
    }
    
    return _label_status;
}

- (UIImageView *)imageView_moneyIcon {
    
    if (!_imageView_moneyIcon) {
        
        _imageView_moneyIcon = [[UIImageView alloc] init];
        _imageView_moneyIcon.backgroundColor = JJBRandomColor;
    }
    
    return _imageView_moneyIcon;
}

- (UILabel *)label_money {
    
    if (!_label_money) {
        
        _label_money = [[UILabel alloc] init];
        _label_money.backgroundColor = [UIColor lightGrayColor];
        _label_money.text = @"1280";
        _label_money.font = [UIFont systemFontOfSize:10];
    }
    
    return _label_money;
}
- (UILabel *)label_line {
    
    if (!_label_line) {
        
        _label_line = [[UILabel alloc] init];
        _label_line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _label_line;
}

@end
