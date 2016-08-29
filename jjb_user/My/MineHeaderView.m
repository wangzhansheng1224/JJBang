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
#import "MySettingController.h"
#import "LevelController.h"
#import "MyBalanceViewController.h"
#import "GoodsListController.h"

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
        
        [self addSubview:self.topImage];
        [self addSubview:self.label_line];
        [self addSubview:self.signLabel];
        [self addSubview:self.itemImage];
//        [self addSubview:self.emailBtn];
        [self addSubview:self.nameLabel];
        [self addSubview:self.levelBtn];
        [self addSubview:self.setBtn];
        [self addSubview:self.moneyBtn];
        [self addSubview:self.adBtn];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width,194.0f));
        make.top.left.mas_equalTo(@0);
    }];

    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(@30);
        make.right.equalTo(@-10);
    }];
    
//    [self.emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//        make.top.equalTo(@10);
//        make.right.equalTo(self.setBtn.mas_left).with.offset(-10);
//    }];
    
    [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.left.equalTo(@10);
        make.bottom.equalTo(self.moneyBtn.mas_top).offset(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.size.mas_equalTo(CGSizeMake(60, 16));
        make.top.equalTo(self.itemImage.mas_top).with.offset(22);
        make.left.equalTo(self.itemImage.mas_right).with.offset(16);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@16);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(8);
        make.left.equalTo(self.itemImage.mas_right).with.offset(16);
    }];
    
    [self.levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(110, 21));
        make.right.equalTo(@20);
        make.top.equalTo(self.setBtn.mas_bottom).with.offset(70);
    }];
    
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0, 74));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(@0);
    }];
    
    [self.adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0, 74));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.moneyBtn.mas_right);
    }];
    
    [self.label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2, 30));
        make.centerY.equalTo(self.adBtn.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma -
#pragma - configWithData
- (void)configWithData:(UserModel *)model{
    [self.nameLabel setText:model.nickName];
    NSURL *url=[NSURL initWithImageURL:model.photo Size:self.itemImage.frame.size];
    [self.itemImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    self.moneyBtn.bDetail=[NSString stringWithFormat:@" %.2f",model.balance];
    self.signLabel.text = model.signature;
}


#pragma -
#pragma - Event 

-(void)settingClick:(id)sender{
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    MySettingController *setting=[[MySettingController alloc] init];
      UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:setting];
    [navController pushViewController:controller animated:YES];
}

-(void)levelBtnClick:(id)sender{
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    LevelController *levelController=[[LevelController alloc] init];
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:levelController];
    [navController pushViewController:controller animated:YES];
}

-(void)moneyBtnClick:(id)sender{
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    MyBalanceViewController *balanceController=[[MyBalanceViewController alloc] init];
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:balanceController];
    [navController pushViewController:controller animated:YES];
}

- (void)goodsBtnClick:(id)sender {

    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    GoodsListController *goodsListController=[[GoodsListController alloc] init];
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:goodsListController];
    [navController pushViewController:controller animated:YES];
}

#pragma -
#pragma mark - setter and getter

- (UIImageView*)topImage {
    
    if (!_topImage) {
        _topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_background"]];
        _topImage.frame=CGRectMake(0, 0, Screen_Width, 194);
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topImage;
}

- (UIButton*)setBtn {
    if (!_setBtn) {
        _setBtn = [[UIButton alloc] init];
        _setBtn.backgroundColor = COLOR_GRAY;
        _setBtn.layer.cornerRadius = 15;
        _setBtn.clipsToBounds = YES;
        _setBtn.center = CGPointMake(SCREEN_W - 35, 35);
        [_setBtn setImage:[UIImage imageNamed:@"my_setting"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(settingClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

- (void)setSetButton:(NSString *)setButton {
    
    [_setBtn setImage:[UIImage imageNamed:setButton] forState:UIControlStateNormal];
}

- (void)setBtnAddTarget:(id)target action:(SEL)sel {
    
    [_setBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton*)emailBtn {
    
    if (!_emailBtn) {
        _emailBtn = [[UIButton alloc] init];
        _emailBtn.backgroundColor = COLOR_GRAY;
        _emailBtn.layer.cornerRadius = 15;
        _emailBtn.clipsToBounds = YES;
         [_emailBtn setImage:[UIImage imageNamed:@"my_email"] forState:UIControlStateNormal];
    }
    return _emailBtn;
}

- (void)emailBtnAddTarget:(id)target action:(SEL)sel {
    
    [_emailBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (UIImageView*)itemImage {
    
    if (!_itemImage) {
        _itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_default"]];
        _itemImage.layer.cornerRadius = 39;
        _itemImage.layer.masksToBounds = YES;
        _itemImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _itemImage;
}
- (UILabel*)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel sizeToFit];
        _nameLabel.textColor=COLOR_WHITE;
    }
    return _nameLabel;
}

- (UILabel*)signLabel {
    
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.alpha = 0.8;
        _signLabel.text=@"这家伙很懒，什么都没留下！";
        _signLabel.textColor=COLOR_WHITE;
        _signLabel.font = [UIFont systemFontOfSize:13];
    }
    return _signLabel;
}

- (LevelButton*)levelBtn {
    
    if (!_levelBtn) {
        _levelBtn = [[LevelButton alloc] initWithFrame:CGRectMake(SCREEN_W - 100, CGRectGetMaxY(_itemImage.frame) - Item_Width/2.0, 110, 21)];
        _levelBtn.backgroundColor = [UIColor lightGrayColor];
        _levelBtn.layer.cornerRadius = _levelBtn.frame.size.height/2.0;
        _levelBtn.layer.masksToBounds = YES;
        [_levelBtn addTarget:self action:@selector(levelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _levelBtn.lImage=@"my_member1_select";
        NSString * string = [[NSString alloc]init];
        switch ([UserModel currentUser].level) {
            case 0:
                string = @"铜牌会员";
                break;
            case 1:
                string = @"银牌会员";
                break;
            case 2:
                string = @"金牌会员";
                break;
            case 3:
                string = @"钻石会员";
                break;
            default:
                break;
        }

         _levelBtn.lTitle = string;
    }
    return _levelBtn;
    
}

- (MyButton*)moneyBtn {
    
    if (!_moneyBtn) {
        _moneyBtn = [[MyButton alloc] init];
        _moneyBtn.backgroundColor = COLOR_WHITE;
        _moneyBtn.bImage = @"my_money";
        _moneyBtn.bTitle = @"用户余额";
        _moneyBtn.bDetail = @"100";
        [_moneyBtn addTarget:self action:@selector(moneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moneyBtn;
}

- (MyButton*)adBtn {
    
    if (!_adBtn) {
        _adBtn = [[MyButton alloc] init];
        _adBtn.backgroundColor = COLOR_WHITE;
        _adBtn.bImage = @"my_shop";
        _adBtn.bTitle = @"儿童水吧";
        _adBtn.bDetail = @"门店超市";
        [_adBtn addTarget:self action:@selector(goodsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _adBtn;
}

- (void)adBtnAddTarget:(id)target action:(SEL)sel {
    
    [_adBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (UILabel*)label_line {
    if (!_label_line) {
        _label_line = [[UILabel alloc] init];
        _label_line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _label_line;
}

@end
