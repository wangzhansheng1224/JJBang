//
//  MyRechargeController.m
//  jjb_user
//
//  Created by Maybe on 16/8/10.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//


#import "MyRechargeController.h"
#import "MyBalanceViewController.h"
#import "RechargeWeChatAndAliCell.h"
#import "RechargeWeChatAndAliView.h"
#import "MyRechargeAPIManager.h"
#import "MyRechargeReformer.h"
//#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "DataSigner.h"
#import "MBWeChatPayManger.h"
#import "MBAliPayManger.h"
#import "MyRechargeWeChatAPIManager.h"

/**
 *  充值界面
 */
@interface MyRechargeController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property(nonatomic,weak) UITextField * moneyTextfield;
@property(nonatomic,weak) UILabel * nameLabel;
@property(nonatomic,weak) UIView * bjTextfieldView;
@property(nonatomic,strong) RechargeWeChatAndAliCell * cell;
@property(nonatomic,strong) RechargeWeChatAndAliView * RechargeWeChatAndAliView;
@property(nonatomic,weak) UIButton * rechargeButton;
@property(nonatomic,strong) LDAPIBaseManager * AliPayprepayIdManager;
@property(nonatomic,strong) LDAPIBaseManager * WeChatprepayIdManager;
@property(nonatomic,strong) id<ReformerProtocol> MyRecargeReformer;
@property(nonatomic,strong) NSMutableArray * arrData;
@property(nonatomic,copy) NSString * timeStamp;
@property(nonatomic,copy) NSString * prepayID;
@property(nonatomic,copy) NSString * order;  //阿里订单号
@property(nonatomic,copy) NSString * notifyURL; //阿里回调url
@property(nonatomic,copy) NSString * productName; //阿里商品名
@property(nonatomic,copy) NSString * productDescription ;//阿里商品描述
@property(nonatomic,copy) NSString * amount;   //阿里商品价格


@end

static NSString * const RechargeCellIdentifier = @"rechargeIdentifier";
@implementation MyRechargeController

#pragma 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"充值";
    
    

    RechargeWeChatAndAliCell * ReView = [[RechargeWeChatAndAliCell alloc]init];
    [ReView selectButton:^(RechargeWeChatAndAliCell *sender) {
    NSString * str = self.nameLabel.text;
                JJBLog(@"++++=========%@",str);
    }];
   [self addSubViewConstraints];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma 
#pragma mark - private methods

-(void)addSubViewConstraints
{
    
    [self.bjTextfieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(70);
    }];
    
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjTextfieldView.mas_top).offset(20);
        make.left.equalTo(self.bjTextfieldView.mas_left).offset(48);
        make.bottom.equalTo(self.bjTextfieldView.mas_bottom).offset(-20);
        make.width.mas_equalTo(@35);
    }];
    
    
    [self.moneyTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
        make.right.equalTo(self.bjTextfieldView.mas_right);
        
    }];
   
    [self.RechargeWeChatAndAliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjTextfieldView.mas_bottom).offset(8);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);

    }];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RechargeWeChatAndAliView.mas_bottom).offset(21);
        make.left.equalTo(self.view.mas_left).offset(43);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
}
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    NSDictionary * dict = [manager fetchDataWithReformer:nil];
    NSDictionary * dictData = [dict objectForKey:@"data"];

    if ([manager isKindOfClass:[self.AliPayprepayIdManager class]]
) {
        
        self.order = [dictData objectForKey:@"order"];
        self.notifyURL= [dictData objectForKey:@"notify_url"];
        [self jumpAliPay];
    }
    
    else{
        
        [MBWeChatPayManger wxPayWithInfoDictionary:dictData];
    }
   
}



- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    NSDictionary * dict = @{
                            @"user_id":@([UserModel currentUser].userID),
                            @"boby":@"余额充值",
                            @"total_fee":@"0.01"};
    return dict;
                                

}


#pragma -
#pragma mark - private methods

//确认支付
-(void )gotoRecharge:(UIButton *)btn
{
    JJBLog(@"确认支付");
        //支付宝支付
    if ( self.RechargeWeChatAndAliView.selectIndex == 0) {
        [self.AliPayprepayIdManager loadData];
    }
    else
    {    //微信
        [self.WeChatprepayIdManager loadData];
    }
    
    
}

#pragma -
#pragma mark - AliPay

-(void)jumpAliPay
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.order,@"tradeNo",
                           self.productName,@"productName",
                           self.productDescription,@"productDescription",
                           self.amount,@"amount",
                           self.notifyURL,@"notifyURL",
                           nil];
    [MBAliPayManger aliPayWithParamDictonary:dict];
    
}
#pragma
#pragma mark - getter and setter
-(UITextField *)moneyTextfield
{
    if (_moneyTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.placeholder = @"输入充值金额";
        textField.font = [UIFont systemFontOfSize:14];
        
        [self.bjTextfieldView addSubview:textField];
        
        _moneyTextfield = textField;
        
    }
    return _moneyTextfield;
}
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"充值";
        label.font = H2;
//        label.font = [UIFont systemFontOfSize:20];
        [label sizeToFit];
        [self.bjTextfieldView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
-(UIView *)bjTextfieldView
{
    if (_bjTextfieldView == nil) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = COLOR_WHITE;
        [self.view addSubview:view];
        _bjTextfieldView = view;
    }
    return _bjTextfieldView;
}
//-(RechargeWeChatAndAliCell *)cell
//{
//    if (_cell == nil) {
//        RechargeWeChatAndAliCell * cell = [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"img_default"] title:@"支付宝支付"];
//        
//        [self.view addSubview:cell];
//        _cell = cell;
//        
//    }
//    return _cell;
//}
-(RechargeWeChatAndAliView *)RechargeWeChatAndAliView
{
    if (_RechargeWeChatAndAliView == nil) {
        
        RechargeWeChatAndAliCell* AliPayCell=  [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_rechargeAli"] title:@"支付宝支付"];
        AliPayCell.tag=0;
        RechargeWeChatAndAliCell* WeChatCell=  [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_weChat"] title:@"微信支付"];
        WeChatCell.tag=1;
        NSArray * item =@[AliPayCell,WeChatCell];
        RechargeWeChatAndAliView * view = [[RechargeWeChatAndAliView alloc]initWithItems:item];
        
        
        [self.view addSubview:view];
        _RechargeWeChatAndAliView = view;
    }
    return _RechargeWeChatAndAliView;
    
}
-(UIButton *)rechargeButton
{
    if (_rechargeButton == nil) {
        UIButton * buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:@"确认支付" forState:UIControlStateNormal];
        [buttton addTarget:self action:@selector(gotoRecharge:) forControlEvents:UIControlEventTouchUpInside];
        [buttton setBackgroundColor:COLOR_ORANGE];
        [buttton.layer setMasksToBounds:YES];
        [buttton.layer setCornerRadius:5.0f];
        [self.view addSubview:buttton];
        _rechargeButton = buttton;
    }
    return _rechargeButton;
}
-(LDAPIBaseManager *)AliPayprepayIdManager
{
    if (_AliPayprepayIdManager == nil) {
        _AliPayprepayIdManager = [MyRechargeAPIManager sharedInstance];
        _AliPayprepayIdManager.delegate = self;
        _AliPayprepayIdManager.paramSource = self;
    }
    return _AliPayprepayIdManager;
}

-(LDAPIBaseManager *)WeChatprepayIdManager
{
    if (_WeChatprepayIdManager ==nil) {
        _WeChatprepayIdManager = [MyRechargeWeChatAPIManager sharedInstance];
        _WeChatprepayIdManager.delegate = self;
        _WeChatprepayIdManager.paramSource = self;
    }
    return _WeChatprepayIdManager;
}
-(id<ReformerProtocol>)MyRecargeReformer
{
    if (_MyRecargeReformer == nil) {
        _MyRecargeReformer = [[MyRechargeReformer alloc]init];
    }
    return _MyRecargeReformer;
}
-(NSMutableArray *)arrData
{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
-(NSString *)prepayID
{
    if (_prepayID == nil) {
        _prepayID = [[NSString alloc]init];
    }
    return _prepayID;
}
-(NSString *)timeStamp
{
    if (_timeStamp == nil) {
        _timeStamp = [[NSString alloc]init];
    }
    return _timeStamp;
}
-(NSString *)order
{
    if (_order == nil) {
        _order = [[NSString alloc]init];
    }
    return _order;
}
-(NSString *)notifyURL
{
    if (_notifyURL == nil) {
        _notifyURL = [[NSString alloc]init];
    }
    return _notifyURL;
}
-(NSString *)productName
{
    if (_productName == nil) {
        _productName = @"余额充值";
    }
    return _productName;
}
-(NSString *)productDescription
{
    if (_productDescription == nil) {
        _productDescription = @"余额充值";
    }
    return _productDescription;
}
-(NSString *)amount
{
    if (_amount == nil) {
        _amount = @"0.01";
    }
    return _amount;
}
@end
