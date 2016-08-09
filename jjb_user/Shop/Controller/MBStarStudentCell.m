//
//  MBStarStudentTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBStarStudentCell.h"

@interface MBStarStudentCell ()
/**
 * 学员图
 */
@property(nonatomic,weak) UIImageView * starStudentImageView;
/**
 *  学员名
 */
@property(nonatomic,weak) UILabel * starStudentNameLabel;
/**
 *  成长值
 */
@property(nonatomic,weak) UILabel * starStudentGrowLabel;

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
        [self addSubviewConstraint];
    }
    
    
    
    return self;
}
-(void)addSubviewConstraint
{
    [self.starStudentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    [self.starStudentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starStudentImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10);
        make.left.equalTo(self.starStudentImageView.mas_left);
        make.right.equalTo(self.contentView.mas_centerX);
    }];
    [self.starStudentGrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.starStudentNameLabel.mas_centerY);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.starStudentImageView.mas_right);
    }];
}

#pragma 
#pragma mark - getter and setter
-(UIImageView *)starStudentImageView
{
    if (_starStudentImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        
        _starStudentImageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _starStudentImageView;
}

-(UILabel *)starStudentNameLabel
{
    if (_starStudentNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"明星学员测试";
        label.font = H4;
        label.textAlignment = NSTextAlignmentLeft;
        _starStudentNameLabel = label;
        [self.contentView addSubview:label];
    }
    return _starStudentNameLabel;
}
-(UILabel *)starStudentGrowLabel
{
    if (_starStudentGrowLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
//        NSString * string = [NSString stringWithFormat:@"%@成长值",];
        label.text = @"成长值测试";
        label.font = H4;
        label.textAlignment = NSTextAlignmentRight;
        _starStudentGrowLabel = label;
        [self.contentView addSubview:label];
    }
    return _starStudentGrowLabel;
    
}
@end
