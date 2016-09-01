//
//  PayResultController.m
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "PayResultController.h"
#import "OrderStatusAPImanager.h"
#import "MyBalanceViewController.h"
@interface PayResultController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) OrderStatusAPImanager *apiManager;
@property(nonatomic,weak) UILabel * infoLabel;
@property(nonatomic,weak) UIButton * FinishButton;
@end

@implementation PayResultController
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付完成";
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self addSubViewContraints];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
    if(self.aliPayStatus){
        self.infoLabel.text = self.aliPayStatus;
        
        return;
    }
    if (self.isSuccess) {
        self.infoLabel.text = @"支付成功";
    }
    else
    {
        self.infoLabel.text = @"支付失败";
    }
    [self.apiManager loadData];
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma -
#pragma mark - private methods
-(void)getOrderPayResult:(NSNotification *)notification
{
    
    if ([notification.object isEqualToString:@"success"]) {
        self.infoLabel.text = @"支付成功";
        [self.apiManager loadData];
    }else if ([notification.object isEqualToString:@"cancel"])
    {

        self.infoLabel.text = @"用户取消了支付";
        [self.apiManager loadData];
    }
    else
    {
        self.infoLabel.text = @"支付失败";
        [self.apiManager loadData];
    }
    
    
}
-(void)getBalanceResult:(NSNotification *)noti
{
    NSLog(@"%@",noti.object);
    if (self.isSuccess) {
        self.infoLabel.text = @"支付成功";
    }
    else
    {
        self.infoLabel.text = @"支付失败";
    }
    [self.apiManager loadData];

}
-(void)gotoFinish:(UIButton *)button
{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)addSubViewContraints
{
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(150);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    [self.FinishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(45);
    }];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[OrderStatusAPImanager class]]) {
        
        NSDictionary * dict = [manager fetchDataWithReformer:nil];
        NSDictionary * data = dict[@"data"];
        double money = [data[@"balance"] doubleValue];
        [UserModel currentUser].balance =  money;
        [UserModel save:[UserModel currentUser]];
        JJBLog(@"()()()%lf",[UserModel currentUser].balance);
        JJBLog(@"%@",dict);
        
    }
    

    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
    JJBLog(@"请求失败");
    
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    if ([manager isKindOfClass:[OrderStatusAPImanager class]]) {
        ((OrderStatusAPImanager *)manager).methodName = [NSString stringWithFormat:@"gateway/getOrderStatus/%@/%@/%@",@([UserModel currentUser].userID),self.orderNo,@0];
        
    }
    return nil;
}


#pragma -
#pragma mark - setter and getter
-(OrderStatusAPImanager*) apiManager{
    if (!_apiManager) {
        _apiManager=[OrderStatusAPImanager sharedInstance];
        _apiManager.delegate=self;
        _apiManager.paramSource=self;
    }
    return _apiManager;
}
-(UILabel *)infoLabel
{
    if (_infoLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"支付结果";
        label.font = H1;
        [label sizeToFit];
        [self.view addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}
-(UIButton *)FinishButton
{
    if (_FinishButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setBackgroundColor:COLOR_ORANGE];
        [button addTarget:self action:@selector(gotoFinish:) forControlEvents:UIControlEventTouchUpInside];

        button.titleLabel.textColor = [UIColor whiteColor];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        [self.view addSubview:button];
        _FinishButton = button;
        

    }
    return _FinishButton;
}
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
