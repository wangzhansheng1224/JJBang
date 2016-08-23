//
//  RechargeWeChatAndAliView.m
//  jjb_user
//
//  Created by Maybe on 16/8/11.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "RechargeWeChatAndAliCell.h"
#import "MyRechargeController.h"
@interface RechargeWeChatAndAliCell ()
@property(nonatomic,weak) UIImageView * iconImageView;
@property(nonatomic,weak) UILabel * nameLabel;
@property(nonatomic,weak) UIButton * choiceButton;
@property(nonatomic,weak) UIView * lineView;
@property(nonatomic,copy) SelectButtonBlock selectBlock;

@end
@implementation RechargeWeChatAndAliCell


#pragma 
#pragma mark - life cycle
-(instancetype)initWithImage:(UIImage *)iconImage title:(NSString *)title;
{
    self = [super init];
    if (self) {
        [self addSubViewConstraints];
        self.backgroundColor=  COLOR_WHITE;
        self.userInteractionEnabled = YES;
        self.iconImageView.image = iconImage;
        self.nameLabel.text = title;
    }
    return self;
}

#pragma 
#pragma mark -private methods
-(void)addSubViewConstraints
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14);
        make.left.equalTo(self.mas_left).offset(16);
        make.bottom.equalTo(self.mas_bottom).offset(-14);

    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(16);
    }];
    [self.choiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-24);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@1);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right);
    }];
}

-(void)selectButton:(SelectButtonBlock)block
{
    
    self.selectBlock = block;
}


-(void)selectBtn:(UIButton * )btn
{
    JJBLog(@"%s",__func__);
    btn.selected = !btn.selected;
    JJBLog(@"$$$$$$$$%ld",btn.tag);
//    JJBWeakSelf;
    if(self.selectBlock)
    {
        self.selectBlock(self);
    }

}

#pragma
#pragma mark getter and setter
-(UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"my_rechargeAli"];
        [self addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
-(UILabel *)nameLabel
{
    if(_nameLabel == nil)
    {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"支付宝支付";
        label.textColor = COLOR_GRAY;
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UIButton *)choiceButton
{
    if (_choiceButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
       [button setBackgroundImage:[UIImage imageNamed:@"my_recharge_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"my_recharge_select"]forState:UIControlStateSelected];
        [button setSelected:NO];
         [self addSubview:button];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        _choiceButton = button;
    }
    return _choiceButton;
}
-(UIView *)lineView
{
    if (_lineView == nil) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = COLOR_LIGHT_GRAY;
        [self addSubview:view];
        _lineView = view;
    }
    return _lineView;
}
@end
