//
//  ExplainLevelHeadView.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ExplainLevelHeadView.h"
#import "LevelPrizeView.h"
#import "LevelPrizeSupView.h"

#import "NSURL+OSS.h"
#import "MyBubbleView.h"
@interface ExplainLevelHeadView ()
@property(nonatomic,strong) UIImageView * iconImageView;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UIView * levelBjView;
@property(nonatomic,strong) LevelPrizeView * levelPrizeButton;
@property(nonatomic,strong) LevelPrizeSupView * levelPrizeView;
@property(nonatomic,strong) MyBubbleView * bubbleView;
@end

@implementation ExplainLevelHeadView

#pragma -
#pragma mark - getter and setter

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.levelBjView];
        [self.levelBjView addSubview:self.levelPrizeView];
        [self addSubview:self.bubbleView];
        [self addChildViewConstraints];
        self.nameLabel.text = [UserModel currentUser].nickName;
    }
    return self;
}



-(void)addChildViewConstraints
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
        make.width.and.height.equalTo(@120);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma -
#pragma mark - getter and setter

-(LevelPrizeSupView *)levelPrizeView
{
    if (_levelPrizeView == nil) {
        
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i< 5; i++) {
            LevelPrizeView * cell  = [[LevelPrizeView alloc]initWithImage:[NSString stringWithFormat:@"L_normal_%d",i] selectImage:[NSString stringWithFormat:@"L_select_%d",i]];
            cell.tag = i;
            [array addObject:cell];
        }
        LevelPrizeSupView * view = [[LevelPrizeSupView alloc]initWithItems:array];
        _levelPrizeView = view;
        
    }
    return _levelPrizeView;
}

-(UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
        NSURL *url= [NSURL initWithImageURL:[UserModel currentUser].photo Width:100 Height:100];
        [_iconImageView setHeader:url];

           }
    return _iconImageView;
}
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        
        label.text = @"*****";
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        _nameLabel = label;
    }
    return _nameLabel;
}
-(UIView *)levelBjView
{
    if (_levelBjView == nil) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(30, 200, Screen_Width-60, 60)];
        [view.layer setCornerRadius:30.f];
        [view.layer setMasksToBounds:YES];
      
        view.backgroundColor = RGBACOLOR(203, 79, 42, 0.5f);
        
        _levelBjView = view;
    }
    return _levelBjView;
}
-(MyBubbleView *)bubbleView
{
    if (_bubbleView == nil) {
        _bubbleView = [[MyBubbleView alloc]init];
        _bubbleView.frame = CGRectMake(0, 170, 140, 40);
    }
    return _bubbleView;
}

@end
