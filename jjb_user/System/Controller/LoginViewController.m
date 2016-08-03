//
//  LoginViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "registerViewController.h"
/**
 *  登录主控制器
 */
@interface LoginViewController ()

//手机号
@property(nonatomic,weak) UITextField * telTextField;
//密码
@property(nonatomic,weak) UITextField * passWordTextField;
//登录按钮
@property(nonatomic,weak) UIButton * loginButton;
//其他登录方式
@property(nonatomic,weak) UILabel * otherLaber;

//
@end

@implementation LoginViewController


#pragma mark
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self setupNav];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark - private methods
-(void)setupNav
{
    UIBarButtonItem * scanButton = [UIBarButtonItem itmeWithNormalImage:nil high:nil target:self action:@selector(gotoRegister) norColor:[UIColor whiteColor] highColor:[UIColor blackColor] title:@"注册账号"];
    self.navigationItem.rightBarButtonItem = scanButton;
    self.navigationItem.title = @"登录";


    
}
-(void)gotoRegister
{
    registerViewController * registerVC = [[registerViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
@end
