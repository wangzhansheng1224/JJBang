//
//  MBStarStudentTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBStarStudentCell.h"
#import "ShopIndexKeys.h"

@interface MBStarStudentCell ()
/**
 * 学员图
 */
@property(nonatomic,strong) UIImageView * starStudentImageView;
/**
 *  学员名
 */
@property(nonatomic,strong) UILabel * starStudentNameLabel;
/**
 *  成长值
 */
@property(nonatomic,strong) UILabel * starStudentGrowLabel;

@end
@implementation MBStarStudentCell

#pragma 
#pragma mark - lefe cycle
- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.starStudentImageView];
        [self.contentView addSubview:self.starStudentNameLabel];
        [self.contentView addSubview:self.starStudentGrowLabel];
        [self addSubviewConstraint];
    }
    return self;
}
-(void)addSubviewConstraint
{
    [self.starStudentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.starStudentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starStudentImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.starStudentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_centerX);
    }];
    [self.starStudentGrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.starStudentNameLabel.mas_centerY);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.starStudentImageView.mas_right);
    }];
}

#pragma -
#pragma mark - private methods
- (void)configWithData:(NSDictionary *)data
{
    self.starStudentNameLabel.text=data[kShopIndexSdtListName];
    [self.starStudentImageView sd_setImageWithURL:[NSURL initWithImageURL:data[kShopIndexSdtListPhoto] Width:(Screen_Width-40)/2 Height:(Screen_Width-40)/2]  placeholderImage:[UIImage imageNamed:@"img_default"]];
}


#pragma 
#pragma mark - getter and setter
-(UIImageView *)starStudentImageView
{
    if (_starStudentImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        imageView.clipsToBounds = YES;
        
        _starStudentImageView = imageView;
    }
    return _starStudentImageView;
}

-(UILabel *)starStudentNameLabel
{
    if (_starStudentNameLabel == nil) {
        _starStudentNameLabel = [[UILabel alloc]init];
        _starStudentNameLabel.font = H4;
        _starStudentNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _starStudentNameLabel;
}
-(UILabel *)starStudentGrowLabel
{
    if (_starStudentGrowLabel == nil) {
        _starStudentGrowLabel = [[UILabel alloc]init];
        _starStudentGrowLabel.font = H4;
        _starStudentGrowLabel.textColor=COLOR_GRAY;
        _starStudentGrowLabel.textAlignment = NSTextAlignmentRight;
    }
    return _starStudentGrowLabel;
    
}
@end
