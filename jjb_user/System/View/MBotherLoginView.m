//
//  MBotherLoginView.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBotherLoginView.h"

@interface MBotherLoginView ()
@property(nonatomic,weak) UIButton * WeChatButton;
@property(nonatomic,weak) UIButton * QQButton;
@property(nonatomic,weak) UIButton * WeiBoButton;
@property(nonatomic,weak) UIButton * otherLoginButton;

@end
@implementation MBotherLoginView
#pragma mark
#pragma mark - life cycle
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}



#pragma mark
#pragma mark - getter and setter
//-(UIButton *)WeChatButton
//{
//    if (_WeChatButton == nil) {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setBackgroundImage:[UIImage imageNamed:@"login_other_wechat"] forState:UIControlStateNormal];
//        [self addSubview:button];
//        _WeChatButton = button;
//    }
//    return _WeChatButton;
//}
//-(UIButton *)QQButton
//{
//    if (_QQButton == nil) {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:button];
//        _QQButton = button;
//    }
//    return _QQButton;
//}
//-(UIButton *)WeiBoButton
//{
//    if (_WeiBoButton == nil) {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:button];
//        _WeiBoButton = button;
//    }
//    return _WeiBoButton;
//}


//-(instancetype)init
//{
//    UIButton * weChatButton = [];
//}
-(UIButton *)otherLoginButton
{
    if(_otherLoginButton == nil)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        _otherLoginButton = button;
    }
    return _otherLoginButton;
}
@end
