//
//  LoginViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "registerViewController.h"
#import "FindPassWordViewController.h"
#import "LoginAPIManager.h"
#import "UserModel.h"
#import "UserReformer.h"

/**
 *  登录主控制器
 */
@interface LoginViewController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

//手机号
@property(nonatomic,strong) UITextField * telTextField;
//密码
@property(nonatomic,strong) UITextField * passWordTextField;
//登录按钮
@property(nonatomic,strong) UIButton * loginButton;
//其他登录方式
@property(nonatomic,strong) UILabel * otherLabel;
//其他登陆方式线
@property(nonatomic,strong) UILabel * otherLabelLine;
@property(nonatomic,strong) UILabel * secondLabelLine;
//忘记密码
@property(nonatomic,strong) UIButton * forgetPassWordButton;
//微信
@property(nonatomic,strong) UIButton * weChatButton;
//QQ
@property(nonatomic,strong) UIButton * qqButton;
//微博
@property(nonatomic,strong) UIButton * weiBoButton;

@property(nonatomic,strong) LDAPIBaseManager *loginAPIManager;

@property(nonatomic,strong) UserReformer *userReformer;

@end

@implementation LoginViewController


#pragma mark
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self setupNav];
    //添加所有子视图
    [self.view addSubview:self.telTextField];
    [self.view addSubview:self.passWordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetPassWordButton];
    [self.view addSubview:self.otherLabel];
    [self.view addSubview:self.otherLabelLine];
    [self.view addSubview:self.secondLabelLine];
    [self.view addSubview:self.weChatButton];
    [self.view addSubview:self.weiBoButton];
    [self.view addSubview:self.qqButton];
    
    [self layoutPageSubviews];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //退出键盘
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark - private methods
-(void)setupNav
{
    UIBarButtonItem * scanButton = [UIBarButtonItem itmeWithNormalImage:nil high:nil target:self action:@selector(gotoRegister:) norColor:[UIColor whiteColor] highColor:[UIColor blackColor] title:@"注册账号"];
    self.navigationItem.rightBarButtonItem = scanButton;
    self.navigationItem.title = @"登录";
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    UserModel *user=[manager fetchDataWithReformer:self.userReformer];
    [UserModel save:user];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
     [self.view makeToast:@"登录失败！" duration:3.0 position:CSToastPositionCenter];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"phone":self.telTextField.text,
             @"password":self.passWordTextField.text
             };
}

#pragma mark
#pragma mark - Event methods
//注册
-(void)gotoRegister:(id)sender
{
    registerViewController * registerVC = [[registerViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
//找回密码
-(void)gotoFindPassWord
{
    FindPassWordViewController * findVC = [[FindPassWordViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
}
//微信登陆
-(void)weChatLogin
{
    JJBLog(@"%s",__func__);
}
-(void)QQLogin
{
    JJBLog(@"%s",__func__);
}
//微博登陆
-(void)weiboLogin
{
    JJBLog(@"%s",__func__);
}

//用户登录事情
-(void)login:(id)sender{
    [self.loginAPIManager loadData];
}


#pragma mark
#pragma mark - layoutPageSubviews
-(void)layoutPageSubviews
{
    UIView *superView=self.view;
    
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(18);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.height.mas_equalTo(@40);
        
    }];
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@40);
        make.top.equalTo(self.telTextField.mas_bottom).offset(10);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.passWordTextField.mas_bottom).offset(32);
        make.left.mas_equalTo(self.view.mas_left).offset(42);
    }];
    [self.forgetPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginButton.mas_right);
        make.top.equalTo(self.loginButton.mas_bottom).offset(15);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@60);
    }];
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_bottom).offset(-200);
        make.centerX.equalTo(superView.mas_centerX);
//        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@10);
    }];
    [self.otherLabelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(self.otherLabel.mas_left).offset(-17);
        make.centerY.equalTo(self.otherLabel.mas_centerY);
        make.height.mas_equalTo(@1);
    }];
    [self.secondLabelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherLabel.mas_right).offset(17);
        make.right.equalTo(self.view.mas_right);
        make.centerY.equalTo(self.otherLabelLine.mas_centerY);
        make.height.equalTo(self.otherLabelLine.mas_height);
    }];
    

    [self.weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.otherLabel.mas_bottom).offset(43);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.width.equalTo(self.view.mas_width).multipliedBy(1.0/3.0).offset(-20);
//        make.right.equalTo(self.qqButton.mas_right).offset(14);

    }];
    
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.centerY.equalTo(self.weChatButton.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.weChatButton.mas_width);
    }];

    [self.weiBoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weChatButton.mas_top);
        make.centerY.equalTo(self.weChatButton.mas_centerY);
//        make.height.equalTo(self.weChatButton.mas_height);
        make.width.equalTo(self.weChatButton.mas_width);
        make.right.equalTo(self.view.mas_right).offset(-14);
    }];
}

#pragma mark
#pragma mark - getter and setter
-(UITextField *)telTextField
{
    if (_telTextField == nil) {
       UITextField * textField = [[UITextField alloc]init];
        //去除约束
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.placeholder = @"手机号";
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
       _telTextField = textField;
    }
    
    return _telTextField;
}
-(UITextField *)passWordTextField
{
    if (_passWordTextField == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"密码";
        
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.secureTextEntry = YES;
        _passWordTextField = textField;
    }
    return _passWordTextField;
}
-(UIButton *)loginButton
{
    if (_loginButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        [button setBackgroundColor:COLOR_ORANGE];
        [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor whiteColor];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        _loginButton = button;
        
    }
    return _loginButton;
}
-(UIButton *)forgetPassWordButton
{
    if (_forgetPassWordButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:@"忘记密码" forState:UIControlStateNormal];
        
        button.titleLabel.textColor = [UIColor blackColor];
        [button addTarget:self action:@selector(gotoFindPassWord) forControlEvents:UIControlEventTouchUpInside];
        _forgetPassWordButton = button;
    }
    return _forgetPassWordButton;
}
-(UILabel *)otherLabel
{
    if (_otherLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        
        label.text = @"其它登陆方式";
        _otherLabel = label;
    }
    
    return _otherLabel;
}
-(UILabel *)otherLabelLine
{
    if (_otherLabelLine == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.backgroundColor = [UIColor lightGrayColor];
        _otherLabelLine = label;
    }
    return _otherLabelLine;
}
-(UILabel *)secondLabelLine
{
    if (_secondLabelLine == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.backgroundColor = [UIColor lightGrayColor];
        _secondLabelLine = label;
    }
    return _secondLabelLine;
}
-(UIButton *)weChatButton
{
    if (_weChatButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button sizeToFit];
        [button setBackgroundImage:[UIImage imageNamed:@"login_other_wechat"] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(weChatLogin) forControlEvents:UIControlEventTouchUpInside];
        _weChatButton = button;
    }
    return _weChatButton;
}
-(UIButton *)qqButton
{
    if (_qqButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button sizeToFit];
        [button setBackgroundImage:[UIImage imageNamed:@"login_other_qq"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(QQLogin) forControlEvents:UIControlEventTouchUpInside];
        _qqButton = button;
    }
    return _qqButton;
}
-(UIButton *)weiBoButton
{
    if (_weiBoButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button sizeToFit];
        [button setBackgroundImage:[UIImage imageNamed:@"login_other_weibo"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(weiboLogin) forControlEvents:UIControlEventTouchUpInside];
        _weiBoButton = button;
    }
    return _weiBoButton;
}


- (LDAPIBaseManager *)loginAPIManager {
    if (_loginAPIManager == nil) {
        _loginAPIManager = [LoginAPIManager  sharedInstance];
        _loginAPIManager.delegate=self;
        _loginAPIManager.paramSource=self;
    }
    return _loginAPIManager;
}

- (id<ReformerProtocol>) userReformer{
    
    if (!_userReformer) {
        _userReformer=[[UserReformer alloc] init];
    }
    return _userReformer;
}

@end
