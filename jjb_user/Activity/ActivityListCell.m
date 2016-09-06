//
//  ActivityListCell.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListCell.h"
#import "ActivityListKey.h"

@interface ActivityListCell()

@property (nonatomic,strong) UIImageView *imageView_pic;
@property (nonatomic,strong) UILabel *label_status;
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_location;
@property (nonatomic,strong) UILabel *label_location;
@property (nonatomic,strong) UIImageView *imageView_time;
@property (nonatomic,strong) UILabel *label_time;
@property (nonatomic,strong) UILabel *label_line;

@end

@implementation ActivityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = COLOR_WHITE;
        [self.contentView addSubview:self.imageView_pic];
        [self.contentView addSubview:self.label_status];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.imageView_location];
        [self.contentView addSubview:self.label_location];
        [self.contentView addSubview:self.imageView_time];
        [self.contentView addSubview:self.label_time];
        [self.contentView addSubview:self.label_line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_imageView_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 178));
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
    }];
    [_label_status mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_imageView_pic.mas_bottom).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(76, 30));
        make.left.equalTo(@0);
    }];
    [_label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imageView_pic.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(Screen_Width - 10, 20));
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
    }];
    [_imageView_location mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_title.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.left.equalTo(@16);
    }];
    [_label_location mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_title.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(200, 17));
        make.left.equalTo(_imageView_location.mas_right).with.offset(8);
    }];
    [_imageView_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imageView_location.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.left.equalTo(@16);
    }];
    [_label_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_location.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(200, 17));
        make.left.equalTo(_imageView_time.mas_right).with.offset(8);
    }];
    [_label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 8));
        make.left.equalTo(@0);
        make.top.equalTo(self.imageView_time.mas_bottom).with.offset(8);
    }];
}


#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
        
    [self.label_title setText:data[kActivityListTitle]];
    [self.label_location setText:data[kActivityListAddress]];
    [self.label_status setText:data[kActivityListState]];
    [self.label_time setText:data[kActivityListDate]];
    [self.imageView_pic sd_setImageWithURL:data[kActivityListImageURL] placeholderImage:[UIImage imageNamed:@"img_default"]];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)imageView_pic {
    
    if (!_imageView_pic) {
        
        _imageView_pic = [[UIImageView alloc] init];
        _imageView_pic.backgroundColor = JJBRandomColor;
        _imageView_pic.contentMode = UIViewContentModeScaleAspectFill;
        _imageView_pic.clipsToBounds = YES;
    }
    return _imageView_pic;
}
- (UILabel *)label_status {
    
    if (!_label_status) {
        
        _label_status = [[UILabel alloc] init];
        _label_status.textAlignment = NSTextAlignmentCenter;
        _label_status.text = @"进行中";
        _label_status.font = H3;
        _label_status.textColor = COLOR_WHITE;
        _label_status.numberOfLines = 1;
        [_label_status setBackgroundColor:COLOR_DARK_GRAY];
        [_label_status setAlpha:0.3];
    }
    return _label_status;
}
- (UILabel *)label_title {
    
    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        _label_title.text = @"三峡游开始了，大家快快报名吧";
        _label_title.font = H2;
        [_label_title sizeToFit];
        _label_title.textColor = [UIColor blackColor];
        _label_title.numberOfLines = 1;
    }
    return _label_title;
}
- (UIImageView *)imageView_location {
    
    if (!_imageView_location) {
        
        _imageView_location = [[UIImageView alloc] init];
        _imageView_location.image = [UIImage imageNamed:@"activity_location"];
    }
    return _imageView_location;
}
- (UILabel *)label_location {
    
    if (!_label_location) {
        
        _label_location = [[UILabel alloc] init];
        _label_location.text = @"社区儿童成长中心兴源店";
        _label_location.textColor = COLOR_GRAY;
        _label_location.font = H4;
        [_label_location sizeToFit];
    }
    return _label_location;
}
- (UIImageView *)imageView_time {
    
    if (!_imageView_time) {
        
        _imageView_time = [[UIImageView alloc] init];
        _imageView_time.image = [UIImage imageNamed:@"activity_time"];
    }
    return _imageView_time;
}
- (UILabel *)label_time {
    
    if (!_label_time) {
        
        _label_time = [[UILabel alloc] init];
        _label_time.text = @"08-02 00:00至08-02 24:00";
        _label_time.textColor = COLOR_GRAY;
        [_label_time sizeToFit];
        _label_time.font = H4;
    }
    return _label_time;
}
- (UILabel *)label_line {

    if (!_label_line) {
        
        _label_line = [[UILabel alloc] init];
        _label_line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _label_line;
}

@end
