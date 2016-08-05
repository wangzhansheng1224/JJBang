//
//  GrowingCell.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingCell.h"


@interface GrowingCell ()


@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *moodLabel;
@property (nonatomic,strong) UIImageView *locView;
@property (nonatomic,strong) UILabel *locLabel;

//@property (nonatomic,strong) UIButton *issueBtn;

//@property (nonatomic,strong) UILabel *line;


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
        [self.contentView addSubview:self.picView];
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
        make.size.mas_equalTo(CGSizeMake(50, 50));//mark
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 20));      //mark
        make.top.equalTo(self.mas_top).with.offset(25);  //mark
        make.left.equalTo(_iconView.mas_right).with.offset(8);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 20));//mark
        make.top.equalTo(self.mas_top).with.offset(19);
        make.right.equalTo(self.mas_right).with.offset(-16);
    }];
    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(119, 77));
        make.top.mas_equalTo(_iconView.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.mas_left).with.offset(8);
    }];
    [_moodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width-20, 21));//mark
        make.top.equalTo(_picView.mas_bottom).with.offset(8);
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.left.equalTo(self.mas_left).with.offset(8);
        
    }];
    [_locView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.top.equalTo(_moodLabel.mas_bottom).with.offset(6);
        make.left.equalTo(self.mas_left).with.offset(8);
    }];
    [_locLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 20));//mark
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.left.equalTo(_locView.mas_right).with.offset(8);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = JJBRandomColor;
        _iconView.layer.cornerRadius = 25;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = JJBRandomColor;
        _nameLabel.text = @"王老师";
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor darkGrayColor];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = JJBRandomColor;
        _timeLabel.text = @"5小时";
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor darkGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UIImageView *)picView {
    
    if (!_picView) {
        
        _picView = [[UIImageView alloc] init];
        _picView.backgroundColor = JJBRandomColor;
    }
    return _picView;
}

- (UILabel *)moodLabel {
    
    if (!_moodLabel) {
        
        _moodLabel = [[UILabel alloc] init];
        _moodLabel.backgroundColor = JJBRandomColor;
        _moodLabel.text = @"我们的张檬小朋友";
        _moodLabel.font = [UIFont systemFontOfSize:14];
    }
    return _moodLabel;
}

- (UIImageView *)locView {
    
    if (!_locView) {
        
        _locView = [[UIImageView alloc] init];
        _locView.image = [UIImage imageNamed:@""];  //mark
        _locView.backgroundColor = JJBRandomColor;
    }
    return _locView;
}

- (UILabel *)locLabel {
    
    if (!_locLabel) {
        _locLabel = [[UILabel alloc] init];
        _locLabel.backgroundColor = JJBRandomColor;
        _locLabel.text = @"来自北京，望湖公园店";  //mark
        _locLabel.font = [UIFont systemFontOfSize:14];//mark
    }
    return _locLabel;
}


@end
