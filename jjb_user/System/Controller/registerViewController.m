//
//  registerViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "registerViewController.h"
/**
 *  注册主控制器
 */
@interface registerViewController ()
@property(nonatomic,strong) UITextField * telTextfield;
@property(nonatomic,strong) UITextField * userNameTextfield;
@property(nonatomic,strong) UITextField * passWordTextfield;
@property(nonatomic,strong) UITextField * codeTextfield;
@property(nonatomic,strong) UIButton * codeButton;
@property(nonatomic,strong) UIButton * registerButton;
@property(nonatomic,strong) UIButton * agreeButton;
@property(nonatomic,strong) UILabel * termsLabel;
@end

@implementation registerViewController

#pragma mark 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self addAllChildView];
    [self addChildViewContraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - private methods
-(void)setupNav
{
    self.navigationItem.title = @"注册";
}


-(void)addAllChildView
{
    [self.view addSubview:self.telTextfield];
    [self.view addSubview:self.userNameTextfield];
    [self.view addSubview:self.passWordTextfield];
    [self.view addSubview:self.codeTextfield];
    [self.view addSubview:self.codeButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.agreeButton];
    [self.view addSubview:self.termsLabel];
}
-(void)addChildViewContraints
{
    [self.telTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(18);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.height.mas_equalTo(@40);
        
    }];
    [self.userNameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@40);
        make.top.equalTo(self.telTextfield.mas_bottom).offset(1);
    }];
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@40);
        make.top.equalTo(self.userNameTextfield.mas_bottom).offset(1);
    }];
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.top.equalTo(self.passWordTextfield.mas_bottom).offset(4);
        make.width.mas_equalTo(@150);
//        make.right.equalTo(self.view.mas_right).offset(20);
       make.height.mas_equalTo(@40);
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.codeTextfield.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-20);
//        make.width.mas_equalTo(@150);
        make.left.equalTo(self.codeTextfield.mas_right).offset(20);
        make.height.mas_equalTo(@40);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.codeTextfield.mas_bottom).offset(32);
        make.left.equalTo(self.view.mas_left).offset(42);
//        make.height.mas_equalTo(@35);
    }];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerButton.mas_left);
        make.top.equalTo(self.registerButton.mas_bottom).offset(18);
        
    }];
    [self.termsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.agreeButton.mas_centerY);
        make.left.equalTo(self.agreeButton.mas_right).offset(6);
        make.right.equalTo(self.view.mas_right).offset(20);
    }];


    
}
//获取验证码
-(void)gotoCode
{
    JJBLog(@"%s",__func__);
}

//进行注册
-(void)gotoRegister
{
    
}

#pragma mark
#pragma mark - getter and setter
-(UITextField *)telTextfield
{
    if (_telTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        //去除约束
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.placeholder = @"手机号";
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
        textField.keyboardType = UIKeyboardTypeNumberPad;
//        textField.borderStyle = UITextBorderStyleBezel;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        _telTextfield = textField;
        
        
    }
    return _telTextfield;
}
-(UITextField *)userNameTextfield
{
    if (_userNameTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.placeholder = @"用户名";
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
//        textField.borderStyle = UITextBorderStyleLine;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        _userNameTextfield = textField;
    }
    return _userNameTextfield;
}

-(UITextField *)passWordTextfield
{
    if (_passWordTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"密码";
        
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.secureTextEntry = YES;
        _passWordTextfield = textField;
    }
    return _passWordTextfield;
}

-(UITextField *)codeTextfield
{
    if (_codeTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints  = NO;
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = @"手机验证码";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextfield = textField;
    }
    return _codeTextfield;
}
-(UIButton *)codeButton
{
    if (_codeButton == nil) {
        UIButton  * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setBackgroundColor:COLOR_ORANGE];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTitle:@"60(s)" forState:UIControlStateSelected];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:2.0];
        [button addTarget:self action:@selector(gotoCode) forControlEvents:UIControlEventTouchUpInside];
        
        _codeButton = button;
    }
    return _codeButton;
}
-(UIButton *)registerButton
{
    if (_registerButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setBackgroundColor:COLOR_ORANGE];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        [button addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
        _registerButton = button;
    }
    return _registerButton;
}

-(UIButton *)agreeButton
{
    if (_agreeButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"login_normal"]forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        _agreeButton = button;
    }
    return _agreeButton;
}

-(UILabel *)termsLabel
{
    if (_termsLabel== nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"我已阅读并接受 版权 和 隐私保护 条款";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString * attrobuteStr = [[NSMutableAttributedString alloc]initWithString:label.text];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = COLOR_ORANGE;
        
        [attrobuteStr addAttributes:dict range:NSMakeRange(8, 2)];
        [attrobuteStr addAttributes:dict range:NSMakeRange(13, 4)];
        [label setAttributedText:attrobuteStr];
        _termsLabel = label;
        
    }
    return _termsLabel;

}
@end
