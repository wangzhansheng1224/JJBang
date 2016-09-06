//
//  MBStarTeacherTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBStarTeacherCell.h"
#import "ShopIndexKeys.h"

@interface MBStarTeacherCell ()
@property(nonatomic,weak) UIImageView * starTeacherImageView;
@property(nonatomic,weak) UILabel * starTeacherNameLabel;
@property(nonatomic,weak) UIImageView * starTeacherLevelImageView;
@property(nonatomic,weak) UIView * starView;

@end
@implementation MBStarTeacherCell

#pragma 
#pragma mark life cycle
- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        [self addSubviewConstraint];
    }
    
    
    return self;
}
#pragma 
#pragma private methods
-(void)addSubviewConstraint
{
    [self.starTeacherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.starTeacherNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starTeacherImageView.mas_bottom).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10);
        make.left.equalTo(self.starTeacherImageView.mas_left);
        make.right.equalTo(self.contentView.mas_centerX);
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.starTeacherNameLabel.mas_centerY);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.contentView.mas_right);
    }];
}

#pragma -
#pragma mark - private methods
- (void)configWithData:(NSDictionary *)data
{
    self.starTeacherNameLabel.text=data[kShopIndexTechListName];
    [self.starTeacherImageView sd_setImageWithURL:[NSURL initWithImageURL:data[kShopIndexTechListPhoto] Width:(Screen_Width-40)/2 Height:(Screen_Width-40)/2]  placeholderImage:[UIImage imageNamed:@"img_default"]];
}

#pragma 
#pragma mark - getter and setter
-(UIImageView *)starTeacherImageView
{
    if (_starTeacherImageView == nil) {
        UIImageView * imageView =[[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        _starTeacherImageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _starTeacherImageView;
}
-(UILabel *)starTeacherNameLabel
{
    if (_starTeacherNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"亓凯";
        label.font = H4;
        label.textAlignment  = NSTextAlignmentLeft;
        
        [label sizeToFit];
        _starTeacherNameLabel = label;
        [self.contentView addSubview:label];

    }
    return _starTeacherNameLabel;
}
-(UIView *)starView
{
    if (_starView == nil) {
        UIView * view = [[UIView alloc]init];
        _starView = view;
        [self.contentView addSubview:view];
    }
    return _starView;
}
-(UIImageView *)starTeacherLevelImageView
{
    if (_starTeacherLevelImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"star_solid"];
        _starTeacherLevelImageView = imageView;
        [self.starView addSubview:self.starTeacherLevelImageView];
    }
    return _starTeacherLevelImageView;
}
@end
