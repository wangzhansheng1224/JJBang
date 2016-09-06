//
//  MySettingDetailController.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MySettingDetailController.h"
#import "changeMyInfoAPIManager.h"
@interface MySettingDetailController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) UIView * view_bg;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) UIButton * button;
@property(nonatomic,strong) LDAPIBaseManager * changeInfoAPIManager;
//请求类型
@property(nonatomic,copy) NSString * type;
@end

@implementation MySettingDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)createTextField {
    _view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 15, Screen_Width, 40)];
    _view_bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view_bg];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, Screen_Width - 40, 40)];
    [_view_bg addSubview:_textField];
}

- (void)createPassWord {
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 134, Screen_Width, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    UITextField * passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, Screen_Width - 40, 50)];
    passwordField.placeholder = @"请再次输入密码";
    [bgView addSubview:passwordField];
}
- (void)createButton {
    _button = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_view_bg.frame) + 20, Screen_Width - 100, 44)];
    _button.backgroundColor = [UIColor orangeColor];
    [_button.layer setMasksToBounds:YES];
    [_button.layer setCornerRadius:5.0];
    [_button setTitle:@"保存" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}
-(void)navigationRightBtn{
    UIBarButtonItem * rightButton = [UIBarButtonItem itmeWithNormalImage:nil high:nil target:self action:@selector(barButtonClick:) norColor:[UIColor whiteColor] highColor:[UIColor blackColor] title:@"保存"];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)buttonClick:(UIButton *)btn {
    self.block(_textField.text);
    self.type = @"nickname";
    
    [self.changeInfoAPIManager loadData];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)barButtonClick:(UIButton *)btn
{
    self.block(_textField.text);
    self.type = @"signature";
    [self.changeInfoAPIManager loadData];
    }
- (void)setName:(NSString *)name {
    self.navigationItem.title = @"修改昵称";
    [self createTextField];
    [self createButton];
    UILabel * leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    leftLab.textAlignment = NSTextAlignmentCenter;
    leftLab.textColor = [UIColor grayColor];
    leftLab.text = name;
    _textField.leftView = leftLab;
    _textField.leftViewMode = UITextFieldViewModeAlways;    
}
- (void)setSign:(NSString *)sign {
    self.navigationItem.title = @"修改签名";
    [self createTextField];
    [self navigationRightBtn];
}
- (void)setPassword:(NSString *)password {
    self.navigationItem.title = @"修改密码";
    [self  createTextField];
    _textField.placeholder = @"请输入密码";
    [self createPassWord];
    [self createButton];
    _button.frame = CGRectMake(50, 204, Screen_Width - 100, 50);
}
- (void)setPhoneNum:(NSString *)phoneNum {
    self.navigationItem.title = @"修改手机";
    [self  createTextField];
    [self createButton];
}
- (void)setWeixinNum:(NSString *)weixinNum {
    self.navigationItem.title = @"修改微信";
    [self  createTextField];
    [self createButton];
}
- (void)setQqNum:(NSString *)qqNum {
    self.navigationItem.title = @"修改QQ";
    [self  createTextField];
    [self createButton];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([self.type isEqualToString:@"nickname"]) {
        UIView * view =   [self.view toastViewForMessage:@"修改昵称成功" title:nil image:nil style:nil];
        [self.view showToast:view duration:1.0f position:CSToastPositionCenter completion:^(BOOL didTap) {
            [self.navigationController popViewControllerAnimated:YES];

        }];

        [UserModel currentUser].nickName = self.textField.text;
        [UserModel save:[UserModel currentUser]];
    }else
    {
        [UserModel currentUser].signature = self.textField.text;
        [UserModel save:[UserModel currentUser]];

        UIView * view =   [self.view toastViewForMessage:@"修改个性签名成功" title:nil image:nil style:nil];
        [self.view showToast:view duration:1.0f position:CSToastPositionCenter completion:^(BOOL didTap) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }];

    }
    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    NSDictionary * dict =[manager fetchDataWithReformer:nil];
    NSString * string = dict[@"message"];
    [self.view makeToast:string duration:1.0f position:CSToastPositionCenter];
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    
    
    return @{
             @"user_id" :@([UserModel currentUser].userID),
             self.type:self.textField.text
             
             };
}




#pragma -
#pragma mark - getter and setter
-(LDAPIBaseManager *)changeInfoAPIManager
{
    if (_changeInfoAPIManager == nil) {
        _changeInfoAPIManager = [changeMyInfoAPIManager sharedInstance];
        _changeInfoAPIManager.delegate = self;
        _changeInfoAPIManager.paramSource = self;
    }
    return _changeInfoAPIManager;
}

@end
