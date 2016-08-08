//
//  MBNewActivityTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBNewActivityCell.h"

#import "ShopIndexKeys.h"
@interface MBNewActivityCell ()
//
@property(nonatomic,weak) UIImageView * ActivityImageView;
@property(nonatomic,weak) UILabel * ActivityTitleLabel;

@end
@implementation MBNewActivityCell
#pragma 
#pragma mark - life cycle
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
        
        [self addSubViewContaints];
       
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
//    //图片保持宽高比
//    CGFloat heightScale = 194.0/375.0;
//    //图片
//    self.ActivityImageView.frame = CGRectMake(0, 0, Screen_Width, Screen_Width * heightScale);
//    CGFloat margin = 10.0;
//    //标题
//    self.ActivityTitleLabel.frame = CGRectMake(margin * 2, self.ActivityImageView.frame.size.height, Screen_Width - margin *2, 30);
    
}

#pragma 
#pragma private methods
-(void)addSubViewContaints
{
    [self.ActivityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        make.right.equalTo(self.contentView.mas_right);
    }];
    [self.ActivityTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ActivityImageView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10);

    }];
    
}

-(void)configWithData:(NSDictionary *)data
{
    
}

#pragma 
#pragma mark - getter and setter
-(UIImageView *)ActivityImageView
{
    if (_ActivityImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        [self.contentView addSubview:imageView];
        _ActivityImageView = imageView;
    }
    return _ActivityImageView;
}
-(UILabel *)ActivityTitleLabel
{
    if (_ActivityTitleLabel == nil) {
        
        UILabel * activityTitleLabel = [[UILabel alloc]init];
        activityTitleLabel.text = @"活动测试";
        [activityTitleLabel sizeToFit];
        [self.contentView addSubview:activityTitleLabel];
        self.ActivityTitleLabel = activityTitleLabel;
    }
    return _ActivityTitleLabel;
}
@end
