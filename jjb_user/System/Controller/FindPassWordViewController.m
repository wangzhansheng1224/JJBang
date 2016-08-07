//
//  FindPassWordViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/4.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "ReplacePassWordViewController.h"
/**
 *  找回密码控制器
 */
@interface FindPassWordViewController ()


@property(nonatomic,strong) UITextField * telTextfield;
@property(nonatomic,strong) UIButton * codeButton;
@property(nonatomic,strong) UITextField * codeTextfield;
@property(nonatomic,strong) UIButton * commitButton;
@end

@implementation FindPassWordViewController

#pragma mark
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self setupNav];
    [self addChildView];
    [self addChildViewContraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 
#pragma mark -private methods
-(void)setupNav
{
    self.navigationItem.title = @"找回密码";
    
}
//获取验证码
-(void)gotoCode
{
    
}
//提交
-(void)gotoReplace
{
    ReplacePassWordViewController * replaceVC = [[ReplacePassWordViewController alloc]init];
    [self.navigationController pushViewController:replaceVC animated:YES];
}
-(void)addChildView
{
    [self.view addSubview:self.telTextfield];
    [self.view addSubview:self.codeButton];
    [self.view addSubview:self.codeTextfield];
    [self.view addSubview:self.commitButton];
}

-(void)addChildViewContraints
{
    [self.telTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(18);
        make.right.mas_equalTo(self.view.mas_right).offset(-150);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.height.mas_equalTo(@40);
        
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telTextfield.mas_right).offset(10);
        make.centerY.mas_equalTo(self.telTextfield);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(self.telTextfield.mas_height);
    }];
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telTextfield.mas_left);
        make.top.mas_equalTo(self.telTextfield.mas_bottom).offset(2);
        make.right.mas_equalTo(self.codeButton.mas_right);
        make.height.mas_equalTo(self.telTextfield.mas_height);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextfield.mas_bottom).offset(32);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).offset(43);
    }];
    

}
#pragma mark  
#pragma mark -getter and setter

-(UITextField *)telTextfield{
    if (_telTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.placeholder = @"手机号";
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        _telTextfield = textField;
    }
    return _telTextfield;

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
-(UITextField *)codeTextfield
{
    if (_codeTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints  = NO;
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = @"验证码";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextfield = textField;
    }
    return _codeTextfield;
}
-(UIButton *)commitButton
{
    if (_commitButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setBackgroundColor:COLOR_ORANGE];
        [button setTitle:@"提交" forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        [button addTarget:self action:@selector(gotoReplace) forControlEvents:UIControlEventTouchUpInside];
        _commitButton = button;
    }
    return _commitButton;
}

@end
