//
//  GrowingCell.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingCell.h"
#import "GrowingTreeListKey.h"
#import "GrowingPicController.h"

@interface GrowingCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *moodLabel;
@property (nonatomic,strong) UIImageView *locView;
@property (nonatomic,strong) UILabel *locLabel;

@end

@implementation GrowingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.view_image];
        [self.contentView addSubview:self.moodLabel];
        [self.contentView addSubview:self.locView];
        [self.contentView addSubview:self.locLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark -- layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 16));
        make.top.equalTo(self.mas_top).with.offset(19);
        make.left.equalTo(_iconView.mas_right).with.offset(8);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 14));
        make.top.equalTo(self.mas_top).with.offset(19);
        make.right.equalTo(self.mas_right).with.offset(-16);
    }];
    [_view_image mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_moodLabel.mas_top).with.offset(-8);
        make.top.equalTo(_iconView.mas_bottom).with.offset(8);
        make.left.equalTo(self.mas_left).with.offset(8);
        make.right.equalTo(self.mas_right).with.offset(-8);
    }];
    [_moodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@0);
        make.bottom.equalTo(_locView.mas_top).with.offset(-6);
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.left.equalTo(self.mas_left).with.offset(8);
    }];
    [_locView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.centerY.equalTo(_locLabel.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(8);
    }];
    [_locLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 14));
        make.bottom.equalTo(@-10);
        make.left.equalTo(_locView.mas_right).with.offset(8);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    
    [self.nameLabel setText:data[kGrowingTreeListFromUserName]];
    [self.locLabel setText:data[kGrowingTreeListAddress]];
    [self.timeLabel setText:data[kGrowingTreeListCreateTime]];
    [self.moodLabel setText:data[kGrowingTreeListContent]];
    
    NSURL *url=[NSURL initWithImageURL:data[kGrowingTreeListFromUserFace] Size:self.iconView.frame.size];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    CGSize size = [data[kGrowingTreeListContent] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H2} context:nil].size;
    
    float height = size.height;
    
    if ([data[kGrowingTreeListContent] length] <= 0) {
        
        height = 0;
    }
    
    [_moodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(height));
        make.bottom.equalTo(_locView.mas_top).with.offset(-6);
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.left.equalTo(self.mas_left).with.offset(8);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 17;
        _iconView.clipsToBounds = YES;
        _iconView.image = [UIImage imageNamed:@"student_icon"];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"王老师";
        _nameLabel.font = H3;
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"5小时";
        _timeLabel.font = H4;
        _timeLabel.textColor = COLOR_GRAY;
        [_timeLabel sizeToFit];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)moodLabel {
    
    if (!_moodLabel) {
        
        _moodLabel = [[UILabel alloc] init];
        _moodLabel.font = H2;
        _moodLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _moodLabel.numberOfLines = 0;
    }
    return _moodLabel;
}

- (UIImageView *)locView {
    
    if (!_locView) {
        
        _locView = [[UIImageView alloc] init];
        _locView.image = [UIImage imageNamed:@"growing_loc"];
    }
    return _locView;
}

- (UILabel *)locLabel {
    
    if (!_locLabel) {
        _locLabel = [[UILabel alloc] init];
        _locLabel.text = @"来自北京，望湖公园店";
        _locLabel.textColor = COLOR_ORANGE;
        _locLabel.font = H4;
    }
    return _locLabel;
}

- (UIView *)view_image {
    
    if (!_view_image) {
        
        _view_image = [[UIView alloc] initWithFrame:CGRectMake(0, 10, Screen_Width, self.frame.size.height - 20)];
    }
    return _view_image;
}

@end
