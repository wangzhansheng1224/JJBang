//
//  ReplacePassWordViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/4.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ReplacePassWordViewController.h"

//重置密码

@interface ReplacePassWordViewController ()

@property(nonatomic,strong) UITextField * PassWordTextfield;
@property(nonatomic,strong) UITextField * againPassWordTextfield;
@property(nonatomic,strong) UIButton * commitButton;

@end

@implementation ReplacePassWordViewController

#pragma mark
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    // Do any additional setup after loading the view.
    [self setupNav];
    [self addAllChildView];
    [self addChildViewContraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
}


#pragma mark
#pragma mark -private methods
-(void)setupNav
{
    self.navigationItem.title = @"密码重置";
}

-(void)gotoTureReplacePassWord
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)addAllChildView
{
    [self.view addSubview:self.PassWordTextfield];
    [self.view addSubview:self.againPassWordTextfield];
    [self.view addSubview:self.commitButton];
}
-(void)addChildViewContraints
{
    [self.PassWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(18);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(@40);
        
    }];
    [self.againPassWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@40);
        make.top.equalTo(self.PassWordTextfield.mas_bottom).offset(1);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.againPassWordTextfield.mas_bottom).offset(32);
        make.left.equalTo(self.view.mas_left).offset(42);
        
    }];

}
#pragma mark
#pragma mark - getter and setter
-(UITextField *)PassWordTextfield
{
    if (_PassWordTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints  = NO;
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = @"输入新密码";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _PassWordTextfield = textField;
    }
    return _PassWordTextfield;

}
-(UITextField *)againPassWordTextfield
{
    if (_againPassWordTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints  = NO;
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = @"请再次输入新密码";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _againPassWordTextfield = textField;
    }
    return _againPassWordTextfield;
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
        [button addTarget:self action:@selector(gotoTureReplacePassWord) forControlEvents:UIControlEventTouchUpInside];
        _commitButton = button;
    }
    return _commitButton;
}

@end
