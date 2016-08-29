//
//  MBVideoTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBVideoCell.h"
#import "TitleBar.h"
#import "ShopIndexKeys.h"

/**
 * 直播间
 */
@interface MBVideoCell ()
@property(nonatomic,strong) TitleBar *titleBar;
@property(nonatomic,strong) UIImageView * videoImageView;
@property(nonatomic,strong) UILabel * videoTitleLabel;
@property(nonatomic,strong) UIButton * videoButton;
@property(nonatomic,strong) UIView * lineView;
@property(nonatomic,strong) NSDictionary *dataDic;
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
        [self.contentView addSubview:self.titleBar];
        [self.contentView addSubview:self.videoImageView];
        [self.contentView addSubview:self.videoTitleLabel];
        [self.contentView addSubview:self.videoButton];
        [self.contentView addSubview:self.lineView];
        [self addSubviewConstraint];
    }
    return self;
}

#pragma 
#pragma mark - private methods
-(void)addSubviewConstraint
{
    UIView* superView=self.contentView;
    
    [self.titleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.height.equalTo(@(30));
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
    }];
    
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBar.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-60);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.videoImageView.mas_centerX);
        make.centerY.equalTo(self.videoImageView.mas_centerY);
        make.width.mas_equalTo(@44);
        make.height.equalTo(self.videoButton.mas_width);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_videoTitleLabel.mas_bottom);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(10));
    }];
}
//配置数据
-(void)configWithData:(NSDictionary *)data
{
    self.dataDic=data;
    self.videoTitleLabel.text=data[kShopIndexCourseName];
    NSURL *url=[NSURL initWithImageURL:data[kShopIndexCourseImg] Width:Screen_Width Height:Screen_Width*2/3.0f];
    [self.videoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
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
        label.font = H4;
        [self.contentView addSubview:label];
        _videoTitleLabel = label;
    }
    return _videoTitleLabel;
}
-(UIButton *)videoButton
{
    if (_videoButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"shop_video_playbutton"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
//    [button addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>];
        _videoButton = button;
    }
    return _videoButton;
}

-(TitleBar*) titleBar{
    if (!_titleBar) {
        _titleBar=[[TitleBar alloc] init ];
                    
    }
    return _titleBar;
}
-(UIView*) lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}
@end
