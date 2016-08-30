//
//  MyCourseCell.m
//  jjb_user
//
//  Created by Check on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyCourseCell.h"
#import "StarView.h"
#import "CourseKeys.h"


@interface MyCourseCell ()

@property(nonatomic,strong) UIImageView * couseImageView;
/**
 *  课程名
 */
@property(nonatomic,strong) UILabel * couseNameLabel;
/**
 *  已报名人数
 */
@property(nonatomic,strong) UILabel * numbercouseLabel;
/**
 *  星星图
 */
@property(nonatomic,strong) StarView * starView;
/**
 *  课程价格
 */
@property(nonatomic,strong) UILabel * cousePriceLabel;

/**
 *  线
 */
@property(nonatomic,strong) UIView * lineView;

@end

@implementation MyCourseCell

#pragma
#pragma mark - lefe cycle

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.couseImageView];
        [self.contentView addSubview:self.couseNameLabel];
        [self.contentView addSubview:self.numbercouseLabel];
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.cousePriceLabel];
        [self.contentView addSubview:self.lineView];
        [self addSubviewConstraint];
    }
    return self;
}

#pragma
#pragma mark - private methods
-(void)addSubviewConstraint
{
    [self.couseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo((Screen_Width-40)/2.0);
        make.height.mas_equalTo((Screen_Width-40)/3.0);
        
    }];
    [self.couseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couseImageView.mas_top);
        make.left.equalTo(self.couseImageView.mas_right).offset(10);
        make.right.equalTo(self.numbercouseLabel.mas_left);
        make.height.mas_equalTo(@30);
    }];
    [self.numbercouseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couseNameLabel.mas_top);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couseNameLabel.mas_bottom).offset(8);
        make.left.equalTo(self.couseNameLabel.mas_left);
        make.height.mas_equalTo(@30);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couseNameLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-40);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@1);
    }];
    [self.cousePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    
}

#pragma -
#pragma mark - private methods
- (void)configWithData:(NSDictionary *)data
{
    self.couseNameLabel.text=data[kCourseName];
    
    NSInteger num=0;
    if (data[kCourseNum]==[NSNull null]) {
        num=0;
    }
    else{
        num=[data[kCourseNum] integerValue];
    }
    self.numbercouseLabel.text=[NSString stringWithFormat:@"%ld人报名",(long)num];
    
    self.cousePriceLabel.text=[NSString stringWithFormat:@"￥%@",data[kCoursePrice]] ;
    [self.couseImageView sd_setImageWithURL:[NSURL initWithImageURL:data[kCourseImg] Width:(Screen_Width-40)/2 Height:(Screen_Width-40)/2]  placeholderImage:[UIImage imageNamed:@"img_default"]];
}

#pragma
#pragma mark - getter and setter
-(UIImageView *)couseImageView
{
    if (_couseImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        _couseImageView = imageView;
        
    }
    return _couseImageView;
}

-(UILabel *)couseNameLabel
{
    if (_couseNameLabel == nil) {
        _couseNameLabel = [[UILabel alloc]init];
        _couseNameLabel.text = @"少儿美术";
        _couseNameLabel.font = H2;
        [_couseNameLabel sizeToFit];
    }
    return _couseNameLabel;
}
-(UILabel *)numbercouseLabel
{
    if (_numbercouseLabel == nil) {
        _numbercouseLabel = [[UILabel alloc]init];
        _numbercouseLabel.text = @"98人报名";
        _numbercouseLabel.font = H3;
        _numbercouseLabel.textAlignment=NSTextAlignmentRight;
        [_numbercouseLabel sizeToFit];
    }
    return _numbercouseLabel;
}
-(UIView *)starView
{
    if (_starView == nil) {
        _starView= [[StarView alloc]init];
        _starView.backgroundColor=[UIColor clearColor];
        _starView.score=5.0f;
    }
    return _starView;
}
-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = COLOR_LIGHT_GRAY;
        
    }
    return _lineView;
}
-(UILabel *)cousePriceLabel
{
    if(_cousePriceLabel == nil)
    {
        _cousePriceLabel = [[UILabel alloc]init];
        _cousePriceLabel.text = @"￥1080";
        _cousePriceLabel.font = H3;
        _cousePriceLabel.textColor=COLOR_ORANGE;
        _cousePriceLabel.textAlignment = NSTextAlignmentRight;
        [_cousePriceLabel sizeToFit];
    }
    return _cousePriceLabel;
}
@end
