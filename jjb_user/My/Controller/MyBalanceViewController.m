//
//  MyBalanceViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/10.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyBalanceViewController.h"
#import "MyOrderDetailController.h"
#import "MyRechargeController.h"
/**
 *  余额界面
 */
@interface MyBalanceViewController ()
//@property(nonatomic,weak) UITextField * moneyTextfield;
@property(nonatomic,weak) UILabel * presentLabel;
@property(nonatomic,weak) UILabel * moneyLabel;
@property(nonatomic,weak) UIView * bjView;
@property(nonatomic,weak) UIButton * rechargeButton;

@end

@implementation MyBalanceViewController

#pragma 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self setupNav];
    [self addChildViews];
    [self addChildVIewConstraints];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma 
#pragma mark - private methods

-(void)setupNav
{
    
    UIBarButtonItem * orderDetailButton = [UIBarButtonItem itmeWithNormalImage:nil high:nil target:self action:@selector(gotoOrderDetailVC:) norColor:nil highColor:nil title:@"明细"];
    self.navigationItem.rightBarButtonItem = orderDetailButton;
    self.navigationItem.title = @"余额";
    }

 //跳转明细界面
-(void)gotoOrderDetailVC:(UIButton *)btn
{
    MyOrderDetailController * MyOrderDetailVC = [[MyOrderDetailController alloc]init];
    [self.navigationController pushViewController:MyOrderDetailVC animated:YES];
}
//跳转充值界面
-(void)gotoRechargeVC:(UIButton *)btn
{
    MyRechargeController * myRechargeVC = [[MyRechargeController alloc]init];
    [self.navigationController pushViewController:myRechargeVC animated:YES];
}

-(void)addChildViews
{
    [self.view addSubview:self.bjView];
    [self.bjView addSubview:self.presentLabel];
    [self.bjView addSubview:self.moneyLabel];
    
}
-(void)addChildVIewConstraints
{
    [self.bjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@150);
    }];
    [self.presentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView.mas_top).offset(24);
        make.left.equalTo(self.bjView.mas_left).offset(24);
//        make.right.equalTo(self.bjView.)
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.presentLabel.mas_bottom).offset(8);
        make.left.equalTo(self.presentLabel.mas_left);
    }];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView.mas_bottom).offset(32);
        make.left.equalTo(self.view.mas_left).offset(43);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}
#pragma 
#pragma mark - getter and setter
-(UILabel *)presentLabel
{
    if (_presentLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"账户余额(元)";
        label.textColor = COLOR_WHITE;
        label.font = H4;
        [label sizeToFit];
        _presentLabel  = label;
        [self.bjView addSubview:label];

    }
    return _presentLabel;
}
-(UILabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        
        label.text = @"88.88";
        label.font = FONT_SIZE(30);
        label.textColor = COLOR_WHITE;
        [label sizeToFit];
        _moneyLabel = label;
        [self.bjView addSubview:label];
    }
    return _moneyLabel;
}
-(UIView *)bjView
{
    if (_bjView == nil) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = COLOR_ORANGE;
        _bjView = view;
        [self.view addSubview:view];
    }
    return _bjView;
}
-(UIButton *)rechargeButton
{
    if (_rechargeButton == nil) {
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button setBackgroundColor:COLOR_ORANGE];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0f];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(gotoRechargeVC:) forControlEvents:UIControlEventTouchUpInside];
        _rechargeButton = button;
    }
    return _rechargeButton;
}
@end
