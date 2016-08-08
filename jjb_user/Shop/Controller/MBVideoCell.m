//
//  MBVideoTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBVideoCell.h"
/**
 * 直播间
 */
@interface MBVideoCell ()
@property(nonatomic,weak) UIImageView * videoImageView;
@property(nonatomic,weak) UILabel * videoTitleLabel;
@property(nonatomic,weak) UIButton * videoButton;

@end
@implementation MBVideoCell

#pragma 
#pragma mark life cycle

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self.contentView addSubview:self.videoImageView];
//        [self.contentView addSubview:self.videoTitleLabel];
//        [self.contentView addSubview:self.videoButton];
        [self addSubviewConstraint];
    }
    return self;
}

#pragma 
#pragma mark - private methods
-(void)addSubviewConstraint
{
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        
    }];
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.videoImageView.mas_centerX);
        make.centerY.equalTo(self.videoImageView.mas_centerY);
        make.width.mas_equalTo(@44);
        make.height.equalTo(self.videoButton.mas_width);
    }];
}

#pragma 
#pragma mark - getter and setter
-(UIImageView *)videoImageView
{
    if (_videoImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        [self.contentView addSubview:imageView];
        _videoImageView = imageView;
    }
    return _videoImageView;
}
-(UILabel *)videoTitleLabel
{
    if (_videoTitleLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"直播间测试";
        [self.contentView addSubview:label];
        _videoTitleLabel = label;
    }
    return _videoTitleLabel;
}
-(UIButton *)videoButton
{
    if (_videoButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
//    [button addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>];
        _videoButton = button;
    }
    return _videoButton;
}
@end
