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
#import "LBXScanView.h"
#import "LBXScanViewController.h"

@interface ShopController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> shopIndexReformer;
@property(nonatomic,strong) UIButton * LoginButton;      //点击登录测试按钮
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ShopController

#pragma -
#pragma mark- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.shopIndexAPIManager loadData];
    [self setUpNav];
    [self setUpButton];
}


#pragma -
#pragma mark - private methods
//自定义导航栏
-(void)setUpNav
{
    UIBarButtonItem * scanButton = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"scan"] highImage:[UIImage imageNamed:@"scan"] target:self action:@selector(gotoScan)];
    self.navigationItem.rightBarButtonItem = scanButton;
    
    UIBarButtonItem * loactionButton =[[UIBarButtonItem alloc] initWithTitle:@"合肥市" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoLocation)];
    self.navigationItem.leftBarButtonItem=loactionButton;
    self.navigationItem.leftBarButtonItem = loactionButton;
    self.navigationItem.title = @"望湖公园店";
}

//扫描
-(void)gotoScan
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    LBXScanViewController *vc = [LBXScanViewController new];
    vc.style = style;   
    
  //  vc.isQQSimulator = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//定位
-(void)gotoLocation
{
    JJBLog(@"%s",__func__);
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


-(UITableView*) tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    }
    return _tableView;
}

@end
