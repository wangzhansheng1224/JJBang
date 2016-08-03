//
//  UIBarButtonItem+MBCustom.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

//封装自定义导航栏设置
#import "UIBarButtonItem+MBCustom.h"

@implementation UIBarButtonItem (MBCustom)
//高亮
+(UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:normalImage forState:UIControlStateNormal];
    [customButton setImage:highImage forState:UIControlStateHighlighted];
    [customButton sizeToFit];//根据图片大小自动计算button的大小
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:customButton];
    return item;
    
}
//选中
+(UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage target:(nullable id)target action:(nullable SEL)action
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:normalImage forState:UIControlStateNormal];
    [customButton setImage:selectImage forState:UIControlStateSelected];
    [customButton sizeToFit];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:customButton];
    return item;
}
//自定义标题，以及颜色 返回按钮
+(UIBarButtonItem *)itmeWithNormalImage:(UIImage *)normalImage high:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action norColor:(UIColor *)norColor highColor:(UIColor *)highColor title:(NSString *)title
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:normalImage forState:UIControlStateNormal];
    [customButton setImage:highImage forState:UIControlStateHighlighted];
    
    
    [customButton setTitleColor:norColor forState:UIControlStateNormal];
    [customButton setTitleColor:highColor forState:UIControlStateHighlighted];
    
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton sizeToFit];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:customButton];
    return item;
}
@end
