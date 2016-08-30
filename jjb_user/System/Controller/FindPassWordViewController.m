//
//  FindPassWordViewController.m
//  jjb_user
//
//  Created by Maybe on 16/8/4.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "ReplacePassWordViewController.h"
#import "GetCodeAPIManager.h"
#import "VerifyCodeAPIManager.h"
/**
 *  找回密码控制器
 */
@interface FindPassWordViewController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>


@property(nonatomic,strong) UITextField * telTextfield;
@property(nonatomic,strong) UIButton * codeButton;
@property(nonatomic,strong) UITextField * codeTextfield;
@property(nonatomic,strong) UIButton * commitButton;
@property(nonatomic,strong) LDAPIBaseManager * getCodeAPIManager; //获取验证码
@property(nonatomic,strong) LDAPIBaseManager * verCodeAPIManager; //验证验证码
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
-(void)gotoCode:(UIButton *)btn
{
    btn.userInteractionEnabled = NO;
    btn.backgroundColor = COLOR_GRAY;
    [self createTimer];
    if(self.telTextfield.text.length != 11)
    {
        [self.view makeToast:@"请输入正确的手机号" duration:1.0f position:CSToastPositionCenter];
    }
    else
    {
        [self.getCodeAPIManager loadData];
    }
    
}
//提交
-(void)gotoReplace
{
    
    
    [self.verCodeAPIManager loadData];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    
    NSDictionary * dict = [manager fetchDataWithReformer:nil];
    JJBLog(@"返回的字典%@",dict);
    if ([manager isKindOfClass:[self.getCodeAPIManager class]]) {
//        NSDictionary * dict = [manager fetchDataWithReformer:nil];
        bool codeStatus = dict[@"data"];
        if (codeStatus) {
            [self.view makeToast:@"获取验证码成功" duration:1.0f position:CSToastPositionCenter];
        }
        else
        {
            [self.view makeToast:@"获取验证码失败" duration:1.0f position:CSToastPositionCenter];
        }
        
    }
    else if([manager isKindOfClass:[self.verCodeAPIManager class]])
    {
         BOOL string = (BOOL)dict[@"data"];
        if(string == YES)
        {
            //验证成功跳转修改密码界面
            ReplacePassWordViewController * replaceVC = [[ReplacePassWordViewController alloc]init];
            replaceVC.telString = self.telTextfield.text;
            [self.navigationController pushViewController:replaceVC animated:YES];
        }
        else
        {
            [self.view makeToast:@"验证码错误" duration:1.0f position:CSToastPositionCenter];
        }
        
    }
    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
//    [self.view makeToast:@"登录失败！" duration:3.0 position:CSToastPositionCenter];
    NSDictionary * dict = [manager fetchDataWithReformer:nil];
    NSString * messageString = dict[@"message"];
    JJBLog(@"%@",dict);

    if([manager isKindOfClass:[self.getCodeAPIManager class]])
    {
        [self.view makeToast:messageString duration:3.0f position:CSToastPositionCenter];
    }
    else if([manager isKindOfClass:[self.verCodeAPIManager class]])
    {
        [self.view makeToast:messageString duration:3.0f position:CSToastPositionCenter];
    }

}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    //验证码
    if ([manager isKindOfClass:[self.getCodeAPIManager class]]) {
        return @{
                 @"phone":self.telTextfield.text,
                 @"type":@1
                 };
    }
    else
    {
        return @{
                 @"phone":self.telTextfield.text,
                 @"code":self.codeTextfield.text
                 };
    }
    
    
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
        make.top.mas_equalTo(self.telTextfield.mas_bottom).offset(10);
        make.right.mas_equalTo(self.codeButton.mas_right);
        make.height.mas_equalTo(self.telTextfield.mas_height);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextfield.mas_bottom).offset(32);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).offset(43);
    }];
    

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
        button.titleLabel.font = H4;
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        [button addTarget:self action:@selector(gotoCode:) forControlEvents:UIControlEventTouchUpInside];
        
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

-(LDAPIBaseManager *)getCodeAPIManager
{
    if (_getCodeAPIManager == nil) {
        _getCodeAPIManager = [GetCodeAPIManager sharedInstance];
        _getCodeAPIManager.delegate = self;
        _getCodeAPIManager.paramSource = self;
    }
    return _getCodeAPIManager;

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

@end
