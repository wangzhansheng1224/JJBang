//
//  MineHeaderView.m
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MineHeaderView.h"
#import "RHHeader.h"
#import "MyButton.h"
#import "LevelButton.h"

#define HeaderView_Height 250
#define TopImage_Height 150

#define SetBtn_Width 30

#define Item_Width 60


@interface MineHeaderView ()

@property (nonatomic, strong) UIImageView * topImage;

@property (nonatomic, strong) UIButton * setBtn;

@property (nonatomic, strong) UIButton * emailBtn;

@property (nonatomic, strong) UIImageView * itemImage;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * signLabel;

@property (nonatomic, strong) LevelButton * levelBtn;

@property (nonatomic, strong) MyButton * moneyBtn;

@property (nonatomic, strong) MyButton * adBtn;


@end


@implementation MineHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createTopImageView];
        
        [self createSetBtn];
        
        [self createEmailBtn];
        
        [self createItemImageView];
        
        [self createNameLabel];
        
        [self createSignLabel];
        
        [self createLevelBtn];
        
        [self createMoneyBtn];
        
        [self createAdBtn];
        
    }
    
    return self;
}

#pragma mark -- 上部背景图片
- (void)createTopImageView {
    
    _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, TopImage_Height)];
    
    _topImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _topImage.backgroundColor = [UIColor blueColor];
    
    [self addSubview:_topImage];
}

- (void)setTopImageView:(NSString *)topImageView {
    
    _topImage.image = [UIImage imageNamed:topImageView];
}


#pragma mark -- 设置按钮
- (void)createSetBtn {
    
    _setBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SetBtn_Width, SetBtn_Width)];
    
    _setBtn.backgroundColor = [UIColor blackColor];
    
    _setBtn.center = CGPointMake(SCREEN_W - 35, 35);
    
    [self addSubview:_setBtn];
    
}

- (void)setSetButton:(NSString *)setButton {
    
    [_setBtn setImage:[UIImage imageNamed:setButton] forState:UIControlStateNormal];
}

- (void)setBtnAddTarget:(id)target action:(SEL)sel {
    
    [_setBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 邮件按钮
- (void)createEmailBtn {
    
    _emailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SetBtn_Width, SetBtn_Width)];
    
    _emailBtn.backgroundColor = [UIColor blackColor];
    
    _emailBtn.center = CGPointMake(CGRectGetMinX(_setBtn.frame) - 25, _setBtn.center.y);
    
    [self addSubview:_emailBtn];
    
}

- (void)setEmailButton:(NSString *)emailButton {
    
    [_emailBtn setImage:[UIImage imageNamed:emailButton] forState:UIControlStateNormal];
}

- (void)emailBtnAddTarget:(id)target action:(SEL)sel {
    
    [_emailBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 头像
- (void)createItemImageView {
    
    _itemImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Item_Width, Item_Width)];
    
    _itemImage.layer.cornerRadius = _itemImage.frame.size.width/2.0;
    _itemImage.layer.masksToBounds = YES;
    
    _itemImage.center = CGPointMake(30 + Item_Width/2.0, CGRectGetMaxY(_topImage.frame) - 30 - Item_Width/2.0);
    
    _itemImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _itemImage.backgroundColor = [UIColor redColor];
    
    [self addSubview:_itemImage];
}

- (void)setItemImageView:(NSString *)itemImageView {
    
    _itemImage.image = [UIImage imageNamed:itemImageView];
}

#pragma mark -- 名字
- (void)createNameLabel {
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_itemImage.frame) + 20, _itemImage.center.y - 21, 150, 21)];
    
//    _nameLabel.backgroundColor = [UIColor blueColor];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_nameLabel];
    
}

- (void)setName:(NSString *)name {
    
    _nameLabel.text = name;
}

#pragma mark -- 签名
- (void)createSignLabel {
    
    _signLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_itemImage.frame) + 20, _itemImage.center.y + 10, 150, 21)];
    
//    _signLabel.backgroundColor = [UIColor purpleColor];
    
    _signLabel.textColor = [UIColor whiteColor];
    
    _signLabel.alpha = 0.8;
    
    _signLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:_signLabel];
    
}

- (void)setSign:(NSString *)sign {
    
    _signLabel.text = sign;
}

#pragma mark -- 会员等级
- (void)createLevelBtn {
    
    _levelBtn = [[LevelButton alloc] initWithFrame:CGRectMake(SCREEN_W - 100, CGRectGetMaxY(_itemImage.frame) - Item_Width/2.0, 110, 21)];
    
    _levelBtn.backgroundColor = [UIColor lightGrayColor];
    
    _levelBtn.layer.cornerRadius = _levelBtn.frame.size.height/2.0;
    _levelBtn.layer.masksToBounds = YES;
        
    [self addSubview:_levelBtn];
    
}

- (void)setLevelImage:(NSString *)levelImage {
    
    _levelBtn.lImage = levelImage;
}

- (void)setLevelTitle:(NSString *)levelTitle {
    
    _levelBtn.lTitle = levelTitle;
}

- (void)levelBtnAddTarget:(id)target action:(SEL)sel {
    
    [_levelBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 余额
- (void)createMoneyBtn {
    
    _moneyBtn = [[MyButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topImage.frame), SCREEN_W/2.0, HeaderView_Height - TopImage_Height)];
    
    _moneyBtn.backgroundColor = [UIColor orangeColor];
    
    _moneyBtn.bImage = @"";
    
    _moneyBtn.bTitle = @"用户余额";
    
    [self addSubview:_moneyBtn];
    
}

- (void)setMoney:(NSString *)money {
    
    _moneyBtn.bDetail = money;
}

- (void)moneyBtnAddTarget:(id)target action:(SEL)sel {
    
    [_moneyBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 广告
- (void)createAdBtn {
    
    _adBtn = [[MyButton alloc] initWithFrame:CGRectMake(SCREEN_W/2.0, CGRectGetMaxY(_topImage.frame), SCREEN_W/2.0, HeaderView_Height - TopImage_Height)];
    
    _adBtn.backgroundColor = [UIColor yellowColor];
    
    _adBtn.bImage = @"";
    
    _adBtn.bTitle = @"七彩商城";
    
    [self addSubview:_adBtn];
}

- (void)setAd:(NSString *)ad {
    
    _adBtn.bDetail = ad;
}

- (void)adBtnAddTarget:(id)target action:(SEL)sel {
    
    [_adBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
