//
//  registerViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "registerViewController.h"
#import "GetCodeAPIManager.h"
#import "RegisterAPIManager.h"
#import "VerifyCodeAPIManager.h"
#import "UserReformer.h"
/**
 *  注册主控制器
 */
@interface registerViewController ()<LDAPIManagerParamSourceDelegate,LDAPIManagerApiCallBackDelegate>
@property(nonatomic,strong) UITextField * telTextfield;
@property(nonatomic,strong) UITextField * userNameTextfield;
@property(nonatomic,strong) UITextField * passWordTextfield;
@property(nonatomic,strong) UITextField * codeTextfield;
@property(nonatomic,strong) UIButton * codeButton;
@property(nonatomic,strong) UIButton * registerButton;
@property(nonatomic,strong) UIButton * agreeButton;
@property(nonatomic,strong) UILabel * termsLabel;
@property(nonatomic,strong) LDAPIBaseManager * getCodeAPIManager; //获取验证码
@property(nonatomic,strong) LDAPIBaseManager * verCodeAPIManager; //验证验证码

@property(nonatomic,strong) LDAPIBaseManager * registerAPIManager; //注册
@property(nonatomic,strong) UserReformer *userReformer;
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //退出键盘
    [self.view endEditing:YES];

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
        make.top.equalTo(self.telTextfield.mas_bottom).offset(10);
    }];
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@40);
        make.top.equalTo(self.userNameTextfield.mas_bottom).offset(10);
    }];
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(18);
        make.top.equalTo(self.passWordTextfield.mas_bottom).offset(10);
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
-(void)gotoCode:(UIButton *)btn
{
    JJBLog(@"%s",__func__);
    btn.userInteractionEnabled = NO;
    btn.backgroundColor = COLOR_GRAY;
    [self createTimer];
    [self.getCodeAPIManager loadData];
    
}
- (void)createTimer{
    
    __block int timeout = 60;
    //获取全局队列 将倒计时的任务 交给全局队列执行
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个定时器 设置触发的间隔时间 以及触发的事件
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    //定时器的任务 交给全局队列执行
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0* NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //设置定时器触发的时间 以及时间允许的误差
    __weak typeof(self)weakSelf = self;
    //设置触发事件
    dispatch_source_set_event_handler(timer, ^{
        //倒计时 刷新button上的title 在适当的时候 结束倒计时
        //每调用一次 时间-1
        timeout--;
        //判断时间 是否需要停止倒计时 或者是修改button的title
        if(timeout <= 0){
            //停止倒计时 button打开可交互 背景色还原 title还原
            
            //关闭定时器
            dispatch_source_cancel(timer);
            
            //button上的相关设置
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.codeButton.userInteractionEnabled  = YES;
                
                weakSelf.codeButton.backgroundColor = COLOR_ORANGE;
                
                [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal ];
            });
        }else{
            
            //处于正在倒计时 刷新button上的title 时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *title = [NSString stringWithFormat:@"%d秒后重新获取",timeout];
                
                [weakSelf.codeButton setTitle:title forState:UIControlStateNormal];
                
            });
        }
    });
    dispatch_resume(timer);
}

//进行注册
-(void)gotoRegister
{
    [self.verCodeAPIManager loadData]; //验证验证码
    
    
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
//    UserModel *user=[manager fetchDataWithReformer:self.userReformer];
//    [UserModel save:user];
//    [self.navigationController popViewControllerAnimated:YES];
    if([manager isKindOfClass:[self.verCodeAPIManager class]])
    {
        //验证成功则进行注册验证
        NSDictionary * dict = [manager fetchDataWithReformer:nil];
        NSString * string = dict[@"data"];
        if(string)
        {
        [self.registerAPIManager loadData];
        }

    }
    else if([manager isKindOfClass:[self.registerAPIManager class]])
    {
        NSDictionary * dict = [manager fetchDataWithReformer:nil];
        NSString * string = dict[@"data"];
         UserModel *user=[manager fetchDataWithReformer:self.userReformer];
         [UserModel save:user];
        
         [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    if([manager isKindOfClass:[self.getCodeAPIManager class]])
    {
        [self.view makeToast:@"获取验证码失败" duration:3.0f position:CSToastPositionCenter];
    }
    else if([manager isKindOfClass:[self.verCodeAPIManager class]])
    {
        [self.view makeToast:@"验证码错误" duration:3.0f position:CSToastPositionCenter];
    }
    else if ([manager isKindOfClass:[self.registerAPIManager class]]) {
        [self.view makeToast:@"注册失败！" duration:3.0f position:CSToastPositionCenter];

    }
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    //验证码
    if ([manager isKindOfClass:[self.getCodeAPIManager class]]) {
        return @{
                 @"phone":self.telTextfield.text
                 };
    }
    else if([manager isKindOfClass:[self.verCodeAPIManager class]]){
        return @{
                 
                 @"phone":self.telTextfield.text,
                 @"code":self.codeTextfield.text
                 
                 };
    }else
    {
        return @{
                 @"phone":self.telTextfield.text,
                 @"password":self.passWordTextfield.text
                 };
    }
    
    
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
        textField.placeholder = @"用户昵称";
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
        button.titleLabel.font = H4;
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        [button addTarget:self action:@selector(gotoCode:) forControlEvents:UIControlEventTouchUpInside];
        
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
        [button setBackgroundImage:[UIImage imageNamed:@"login_select"]forState:UIControlStateNormal];
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
-(LDAPIBaseManager *)getCodeAPIManager
{
    if (_getCodeAPIManager == nil) {
        _getCodeAPIManager = [GetCodeAPIManager sharedInstance];
        _getCodeAPIManager.delegate = self;
        _getCodeAPIManager.paramSource = self;
    }
    return _getCodeAPIManager;
}
-(LDAPIBaseManager *)registerAPIManager
{
    if (_registerAPIManager == nil) {
        _registerAPIManager = [RegisterAPIManager sharedInstance];
        _registerAPIManager.delegate = self;
        _registerAPIManager.paramSource = self;
    }
    return _registerAPIManager;
}
-(LDAPIBaseManager *)verCodeAPIManager
{
    if (_verCodeAPIManager == nil) {
        _verCodeAPIManager = [VerifyCodeAPIManager sharedInstance];
        _verCodeAPIManager.delegate = self;
        _verCodeAPIManager.paramSource = self;
    }
    return _verCodeAPIManager;
}
- (id<ReformerProtocol>) userReformer{
    
    if (!_userReformer) {
        _userReformer=[[UserReformer alloc] init];
    }
    return _userReformer;
}

@end
