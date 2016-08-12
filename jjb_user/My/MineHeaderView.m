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

@property (nonatomic,strong) UIImageView * topImage;
@property (nonatomic,strong) UIButton * setBtn;
@property (nonatomic,strong) UIButton * emailBtn;
@property (nonatomic,strong) UIImageView * itemImage;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * signLabel;
@property (nonatomic,strong) LevelButton * levelBtn;
@property (nonatomic,strong) MyButton * moneyBtn;
@property (nonatomic,strong) MyButton * adBtn;
@property (nonatomic,strong) UILabel *label_line;


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
        [self createLine];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 202));
        make.top.left.equalTo(@0);
    }];

    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(@28);
        make.right.equalTo(@-16);
    }];
    
    
    [self.emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(@28);
        make.right.equalTo(self.setBtn.mas_left).with.offset(-16);
    }];
    
    [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.left.equalTo(@16);
        make.top.equalTo(@124);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 16));
        make.top.equalTo(self.itemImage.mas_top).with.offset(22);
        make.left.equalTo(self.itemImage.mas_right).with.offset(16);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 14));
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(8);
        make.left.equalTo(self.itemImage.mas_right).with.offset(16);
    }];
    
    [self.levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(110, 21));
        make.right.equalTo(@20);
        make.top.equalTo(self.setBtn.mas_bottom).with.offset(80);
    }];
    
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0, 74));
        make.top.equalTo(@202);
        make.left.equalTo(@0);
    }];
    
    [self.adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0, 74));
        make.top.equalTo(@202);
        make.left.equalTo(self.moneyBtn.mas_right).with.offset(0);
    }];
    
    [self.label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(2, 30));
        make.centerY.equalTo(self.adBtn.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
}




#pragma mark -- 上部背景图片
- (void)createTopImageView {
    
    _topImage = [[UIImageView alloc] init];
    
    _topImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:_topImage];
}

- (void)setTopImageView:(NSString *)topImageView {
    
    _topImage.image = [UIImage imageNamed:topImageView];
}


#pragma mark -- 设置按钮
- (void)createSetBtn {
    
    _setBtn = [[UIButton alloc] init];
    _setBtn.backgroundColor = COLOR_GRAY;
    _setBtn.layer.cornerRadius = 15;
    _setBtn.clipsToBounds = YES;
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
    
    _emailBtn = [[UIButton alloc] init];
    _emailBtn.backgroundColor = COLOR_GRAY;
    _emailBtn.layer.cornerRadius = 15;
    _emailBtn.clipsToBounds = YES;
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
    
    _itemImage = [[UIImageView alloc] init];
    _itemImage.layer.cornerRadius = 39;
    _itemImage.layer.masksToBounds = YES;
    _itemImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_itemImage];
}

- (void)setItemImageView:(NSString *)itemImageView {
    
    _itemImage.image = [UIImage imageNamed:itemImageView];
}

#pragma mark -- 名字
- (void)createNameLabel {
    
    _nameLabel = [[UILabel alloc] init];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_nameLabel];
    
}

- (void)setName:(NSString *)name {
    
    _nameLabel.text = name;
}

#pragma mark -- 签名
- (void)createSignLabel {
    
    _signLabel = [[UILabel alloc] init];
    
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
    
    _moneyBtn = [[MyButton alloc] init];
    
    _moneyBtn.backgroundColor = COLOR_WHITE;
    
    _moneyBtn.bImage = @"my_money";
    
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
    
    _adBtn = [[MyButton alloc] init];
    
    _adBtn.backgroundColor = COLOR_WHITE;
    
    _adBtn.bImage = @"my_shop";
    
    _adBtn.bTitle = @"七彩商城";
    
    [self addSubview:_adBtn];
}

- (void)setAd:(NSString *)ad {
    
    _adBtn.bDetail = ad;
}

- (void)adBtnAddTarget:(id)target action:(SEL)sel {
    
    [_adBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)createLine {

    _label_line = [[UILabel alloc] init];
    _label_line.backgroundColor = COLOR_LIGHT_GRAY;
    
    [self addSubview:self.label_line];
    
    [self bringSubviewToFront:self.label_line];

}

@end
