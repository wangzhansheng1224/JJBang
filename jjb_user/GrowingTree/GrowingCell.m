//
//  GrowingCell.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingCell.h"
#import <Masonry.h>

#define SIZE [UIScreen mainScreen].bounds.size


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
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.issueBtn];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            }];
         
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.mas_top).with.offset(25);
            make.left.equalTo(_iconView.mas_right).with.offset(10);
            }];

        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.top.equalTo(self.mas_top).with.offset(25);
            make.right.equalTo(self.mas_right).with.offset(-10);
            }];

        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(200, 180));
            make.top.mas_equalTo(_iconView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(self.mas_left).with.offset(5);
        }];
        
        [_moodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(SIZE.width-20, 21));
            make.top.equalTo(_picView.mas_bottom).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.left.equalTo(self.mas_left).with.offset(10);
            
        }];

        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(2);
            make.top.equalTo(_moodLabel.mas_bottom).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.left.equalTo(self.mas_left).with.offset(20);
        }];

        [_issueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(42, 21));
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.top.equalTo(_line.mas_bottom).with.offset(20);
            
        }];
    }
    return self;
}



#pragma mark -- event response
- (void)btnClick:(UIButton *)btn {
    
    NSLog(@"发布");
}


#pragma mark - getters and setters
- (UIImageView *)iconView {
    
    if (!_iconView) {
        
        _iconView = [[UIImageView alloc] init];
        _iconView.frame = CGRectMake(84, 20, 50, 50);
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
//        _picView.frame = CGRectMake(100, 100, 200, 180);
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
 
- (UILabel *)line {
 
    if (!_line) {
 
        _line = [[UILabel alloc] init];
        _line.textColor = [UIColor blackColor];
    }
    return _line;
}
 
- (UIButton *)issueBtn {
 
    if (!_issueBtn) {
 
        _issueBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _issueBtn.backgroundColor = JJBRandomColor;
        _issueBtn.frame = CGRectMake(0, 0, 20, 20);
        [_issueBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_issueBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _issueBtn;
}
 










- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
