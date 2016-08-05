//
//  ShopController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopController.h"
#import "SHopIndexAPIManager.h"
#import "LoginViewController.h"
#import <LBXScanViewController.h>
#import "ScanViewController.h"
@interface ShopController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> shopIndexReformer;
@property(nonatomic,strong) UIButton * LoginButton;      //点击登录测试按钮
@end

@implementation ShopController

#pragma -
#pragma mark- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self.shopIndexAPIManager loadData];
    [self setUpNav];
    [self setUpButton];
}






#pragma -
#pragma mark - private methods
//自定义导航栏
-(void)setUpNav
{
    UIBarButtonItem * scanButton = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"tab_activity_normal"] highImage:[UIImage imageNamed:@"tab_activity_normal"] target:self action:@selector(gotoScan)];
    self.navigationItem.rightBarButtonItem = scanButton;
    
    UIBarButtonItem * loactionButton = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"tab_activity_normal"] highImage:[UIImage imageNamed:@"tab_activity_normal"] target:self action:@selector(gotoLocation)];
    self.navigationItem.leftBarButtonItem = loactionButton;
    self.navigationItem.title = @"望湖公园店";
}

//扫描
-(void)gotoScan
{
    JJBLog(@"%s",__func__);
    
}
//定位
-(void)gotoLocation
{
    JJBLog(@"%s",__func__);
//    ScanViewController * ScanVC = [[ScanViewController alloc]init];
//    [self.navigationController pushViewController:ScanVC animated:YES];
}
//点击登录
-(void)loginClick
{
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)setUpButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击登录" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(100, 100, 100, 30);
    _LoginButton = button;

    [_LoginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_LoginButton];
   
}
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary *reformedShopIndexData = [manager fetchDataWithReformer:self.shopIndexReformer];
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{@"lng":@"117.10",@"lat":@"40.13"};
}

#pragma -
#pragma mark - getters and setters
- (LDAPIBaseManager *)shopIndexAPIManager {
    if (_shopIndexAPIManager == nil) {
        _shopIndexAPIManager = [ShopIndexAPIManager  sharedInstance];
        _shopIndexAPIManager.delegate=self;
        _shopIndexAPIManager.paramSource=self;
    }
    return _shopIndexAPIManager;
}
//-(UIButton *)LoginButton
//{
//    if (_LoginButton == nil) {
//    }
//    return _LoginButton;
//}


@end
