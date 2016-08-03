//
//  ActivityListCell.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListCell.h"
#import "ActivityListKey.h"

#define SIZE [UIScreen mainScreen].bounds.size
#define PIC_HEIGHT 240
@interface ActivityListCell()

@property (nonatomic,strong) UIImageView *picView;

@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *locView;

@property (nonatomic,strong) UILabel *locLabel;

@property (nonatomic,strong) UIImageView *timeView;

@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation ActivityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        [self.contentView addSubview:self.picView];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.locView];
        [self.contentView addSubview:self.locLabel];
        [self.contentView addSubview:self.timeView];
        [self.contentView addSubview:self.timeLabel];
        
        [self configMasonry];
        
    }
    return self;
}

#pragma mark -- Masonry
- (void)configMasonry {

    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(SIZE.width, PIC_HEIGHT));
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_picView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_picView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(SIZE.width - 10, 20));
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    
    [_locView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
    }];
    
    [_locLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.left.equalTo(_locView.mas_right).with.offset(10);
    }];
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_locView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_locLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.left.equalTo(_timeView.mas_right).with.offset(10);
    }];
    
}

- (void)configWithData:(NSDictionary *)data{
        
    [self.titleLabel setText:data[kActivityListTitle]];
    [self.locLabel setText:data[kActivityListAddress]];
    [self.picView sd_setImageWithURL:data[kActivityListImageURL] placeholderImage:[UIImage imageNamed:@"img_default"]];
}


#pragma mark - getters and setters
- (UIImageView *)picView {
    
    if (!_picView) {
        
        _picView = [[UIImageView alloc] init];
        _picView.backgroundColor = JJBRandomColor;
        
    }
    return _picView;
}

- (UILabel *)statusLabel {
    
    if (!_statusLabel) {
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.text = @"进行中";
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.numberOfLines = 1;

    }
    
    return _statusLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor lightGrayColor];
        _titleLabel.text = @"三峡游开始了，大家快快报名吧";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 1;
        [_statusLabel setBackgroundColor:COLOR_DARK_GRAY];
        [_statusLabel setAlpha:0.3];
    }
    
    return _titleLabel;
}

- (UIImageView *)locView {
    
    if (!_locView) {
        
        _locView = [[UIImageView alloc] init];
        _locView.backgroundColor = JJBRandomColor;
    }
    
    return _locView;
}

- (UILabel *)locLabel {
    
    if (!_locLabel) {
        
        _locLabel = [[UILabel alloc] init];
        _locLabel.backgroundColor = [UIColor lightGrayColor];
        _locLabel.text = @"社区儿童成长中心兴源店";
        _locLabel.font = [UIFont systemFontOfSize:10];
    }
    
    return _locLabel;
}

- (UIImageView *)timeView {
    
    if (!_timeView) {
        
        _timeView = [[UIImageView alloc] init];
        _timeView.backgroundColor = JJBRandomColor;
    }
    return _timeView;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor lightGrayColor];
        _timeLabel.text = @"08-02 00:00至08-02 24:00";
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    
    return _timeLabel;
}

@end
