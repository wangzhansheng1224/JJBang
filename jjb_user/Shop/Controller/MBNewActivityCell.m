//
//  MBNewActivityTableViewCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBNewActivityCell.h"
#import "TitleBar.h"

#import "ShopIndexKeys.h"
@interface MBNewActivityCell ()
@property(nonatomic,strong) TitleBar *titleBar;
@property(nonatomic,strong) UIImageView * ActivityImageView;
@property(nonatomic,strong) UILabel * ActivityTitleLabel;
@property(nonatomic,strong) UIView * lineView;
@property(nonatomic,strong) NSDictionary *dataDic;
@end
@implementation MBNewActivityCell
#pragma 
#pragma mark - life cycle

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleBar];
        [self.contentView addSubview:self.ActivityImageView];
        [self.contentView addSubview:self.ActivityTitleLabel];
        [self.contentView addSubview:self.lineView];
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
    UIView *superView=self.contentView;
    
    [self.titleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(30));
    }];

    [self.ActivityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleBar.mas_bottom);
        make.left.equalTo(superView.mas_left);
        make.bottom.equalTo(superView.mas_bottom).offset(-60);
        make.right.equalTo(superView.mas_right);
    }];
    [self.ActivityTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ActivityImageView.mas_bottom);
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ActivityTitleLabel.mas_bottom);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(10));
    }];
    
}

-(void)configWithData:(NSDictionary *)data
{
    self.dataDic=data;
    self.ActivityTitleLabel.text=data[kShopIndexActTitle];
    NSURL *url=[NSURL initWithImageURL:data[kShopIndexActImage] Width:Screen_Width Height:Screen_Width*2/3.0f];
    [self.ActivityImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
}

#pragma -
#pragma mark - getter and setter

-(TitleBar *)titleBar{
    if (!_titleBar) {
        _titleBar=[[TitleBar alloc] initWithTitle:@"最新活动"];
        [_titleBar moreButtonClick:^(TitleBar *sender) {
            
            UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
            //社区商城
            UIViewController* controller=[[CTMediator sharedInstance] CTMediator_ActivityList:@{}];
            [navController pushViewController:controller animated:YES];
            
        }];
    }
    return _titleBar;
}
-(UIImageView *)ActivityImageView
{
    if (_ActivityImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"img_default"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        _ActivityImageView = imageView;
    }
    return _ActivityImageView;
}
-(UILabel *)ActivityTitleLabel
{
    if (_ActivityTitleLabel == nil) {
        _ActivityTitleLabel = [[UILabel alloc]init];
        _ActivityTitleLabel.text = @"活动测试";
        _ActivityTitleLabel.font = H3;
        [_ActivityTitleLabel sizeToFit];
    }
    return _ActivityTitleLabel;
}

-(UIView*) lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}
@end
