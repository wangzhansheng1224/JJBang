//
//  MBStarCouseTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBStarCouseCell.h"

@interface MBStarCouseCell ()
/**
 *  课程图片
 */
@property(nonatomic,weak) UIImageView * couseImageView;
/**
 *  课程名
 */
@property(nonatomic,weak) UILabel * couseNameLabel;
/**
 *  已报名人数
 */
@property(nonatomic,weak) UILabel * numbercouseLabel;
/**
 *  星星图
 */
@property(nonatomic,weak) UIView * starView;
/**
 *  老师名字
 */
@property(nonatomic,weak) UILabel * couseTeacherNameLabel;
/**
 *  课程价格
 */
@property(nonatomic,weak) UILabel * cousePriceLabel;

/**
 *  线
 */
@property(nonatomic,weak) UIView * lineView;

@end
@implementation MBStarCouseCell

#pragma 
#pragma mark - lefe cycle

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviewConstraint];
    }
    return self;
}

#pragma 
#pragma mark - private methods
-(void)addSubviewConstraint
{
    [self.couseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.width.mas_equalTo(@155);
        make.height.mas_equalTo(@100);
    
    }];
    [self.couseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.couseImageView.mas_right).offset(20);
        make.right.equalTo(self.numbercouseLabel.mas_left).offset(-20);
        make.height.mas_equalTo(@30);
    }];
    [self.numbercouseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.couseNameLabel.mas_bottom);
        make.left.equalTo(self.couseNameLabel.mas_right).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couseNameLabel.mas_bottom).offset(20);
        make.left.equalTo(self.couseNameLabel.mas_left);
        make.height.mas_equalTo(@14);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [self.couseTeacherNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starView.mas_bottom).offset(20);
        make.left.equalTo(self.couseNameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couseNameLabel.mas_left);
        make.bottom.equalTo(self.couseImageView.mas_bottom).offset(-20);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@2);
    }];
    [self.cousePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    
}
#pragma 
#pragma mark - getter and setter
-(UIImageView *)couseImageView
{
    if (_couseImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        _couseImageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _couseImageView;
}

-(UILabel *)couseNameLabel
{
    if (_couseNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"少儿美术";
        _couseNameLabel = label;
        [self.contentView addSubview:label];
    }
    return _couseNameLabel;
}
-(UILabel *)numbercouseLabel
{
    if (_numbercouseLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"98人已报名";
        _numbercouseLabel = label;
        [self.contentView addSubview:label];
    }
    return _numbercouseLabel;
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
-(UILabel *)couseTeacherNameLabel
{
    if (_couseNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"王蒙老师";
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _couseNameLabel = label;
    }
    return _couseNameLabel;
}
-(UIView *)lineView
{
    if (_lineView == nil) {
        UIView * line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        _lineView = line;
        
    }
    return _lineView;
}
-(UILabel *)cousePriceLabel
{
    if(_cousePriceLabel == nil)
    {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"￥1080";
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _cousePriceLabel = label;
    }
    return _cousePriceLabel;
}
@end
