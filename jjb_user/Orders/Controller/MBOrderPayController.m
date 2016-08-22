//
//  MBOrderPayController.m
//  jjb_user
//
//  Created by Maybe on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//
//支付订单界面


#import "MBOrderPayController.h"
#import "MBOrderPayHeadView.h"
#import "RechargeWeChatAndAliView.h"
#import "RechargeWeChatAndAliCell.h"
#import "MBWeChatPayManger.h"
#import "MBAliPayManger.h"
#import "MBOrderPayTypeAPIManager.h"

@interface MBOrderPayController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property(nonatomic,strong)MBOrderPayHeadView * orderPayHeadView;
@property(nonatomic,strong)RechargeWeChatAndAliView * RechargeWeChatAndAliView;
@property(nonatomic,strong)LDAPIBaseManager * RechrgeManager;

//充值按钮
@property(nonatomic,weak)UIButton * RechargeButton;
@end

@implementation MBOrderPayController


#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付订单";
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self.view addSubview:self.orderPayHeadView];
    [self.view addSubview:self.RechargeWeChatAndAliView];
    [self addSubViewsConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)addSubViewsConstraints
{
    [self.RechargeWeChatAndAliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderPayHeadView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@180);
    }];
    [self.RechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RechargeWeChatAndAliView.mas_bottom).offset(25);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(25);
    }];
    
}

#pragma -
#pragma mark - 支付按钮点击事件
-(void)gotoRecharge:(UIButton *)btn
{
    if (self.RechargeWeChatAndAliView.selectIndex == 0) {
        JJBLog(@"余额支付");
    }
    else if (self.RechargeWeChatAndAliView.selectIndex == 1)
    {
        JJBLog(@"支付宝支付");
        [self.RechrgeManager loadData];
    }else
    {
        JJBLog(@"微信支付");
    }
}


#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    NSDictionary * dict = [manager fetchDataWithReformer:nil];
    NSDictionary * dictData = [dict objectForKey:@"data"];
    
//    if ([manager isKindOfClass:[self.AliPayprepayIdManager class]]
//        ) {
//        
//        self.order = [dictData objectForKey:@"order"];
//        self.notifyURL= [dictData objectForKey:@"notify_url"];
//        [self jumpAliPay];
//    }
//    
//    else{
//        
//        [MBWeChatPayManger wxPayWithInfoDictionary:dictData];
//    }
    
}



- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    
    if ([manager isKindOfClass:[MBOrderPayTypeAPIManager class]]) {
        ((MBOrderPayTypeAPIManager *)manager).methodName = [NSString stringWithFormat:@"gateway/orderPayWay/%@/%@",@1,self.orderNo];
    }
    return nil;
    
    
    
    
    
//    NSDictionary * dict = @{
//                            @"way":@1,
//                            @"order_no":@"余额充值",
//                            };
//    return dict;
    
    
}





#pragma -
#pragma mark - getter and setter
-(MBOrderPayHeadView *)orderPayHeadView
{
    if (_orderPayHeadView == nil) {
        _orderPayHeadView = [[MBOrderPayHeadView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    }
    return _orderPayHeadView;
}

-(RechargeWeChatAndAliView *)RechargeWeChatAndAliView
{
    if (_RechargeWeChatAndAliView == nil) {
        RechargeWeChatAndAliCell * balancePay = [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_money"] title:@"用户余额"];
        balancePay.tag = 0;
        RechargeWeChatAndAliCell* AliPayCell=  [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_rechargeAli"] title:@"支付宝支付"];
        AliPayCell.tag=1;
        RechargeWeChatAndAliCell* WeChatCell=  [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_weChat"] title:@"微信支付"];
        WeChatCell.tag=2;
        NSArray * item = @[balancePay,AliPayCell,WeChatCell];
        RechargeWeChatAndAliView * view = [[RechargeWeChatAndAliView alloc]initWithItems:item];
        _RechargeWeChatAndAliView = view;
    
    }
    return _RechargeWeChatAndAliView;
}
-(UIButton *)RechargeButton
{
    if (_RechargeButton == nil) {
        UIButton * buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:@"确认支付" forState:UIControlStateNormal];
        [buttton addTarget:self action:@selector(gotoRecharge:) forControlEvents:UIControlEventTouchUpInside];
        [buttton setBackgroundColor:COLOR_ORANGE];
        [buttton.layer setMasksToBounds:YES];
        [buttton.layer setCornerRadius:5.0f];
        [self.view addSubview:buttton];
        _RechargeButton = buttton;

    }
    return _RechargeButton;
}
-(LDAPIBaseManager *)RechrgeManager
{
    if (_RechrgeManager == nil) {
        _RechrgeManager = [MBOrderPayTypeAPIManager sharedInstance];
        _RechrgeManager.delegate = self;
        _RechrgeManager.paramSource = self;
        
    }
    return _RechrgeManager;
}
@end
