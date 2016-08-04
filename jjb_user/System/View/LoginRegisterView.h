//
//  LoginRegisterView.h
//  jjb_user
//
//  Created by Maybe on 16/8/4.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginRegisterView : UITextField

/**
 *  搭建注册界面，根据不同的界面，相对隐藏对应的控件
 */

//登陆
+(instancetype)loginView;

//注册
+(instancetype)registerView;

//忘记密码
+(instancetype)forgetPassWordView;

@end
