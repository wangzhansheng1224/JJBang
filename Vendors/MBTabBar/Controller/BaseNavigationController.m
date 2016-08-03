//
//  BaseNavigationController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController
+(void)initialize
{
    //设置导航栏背景
    UINavigationBar * bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"guide_1"] forBarMetrics:UIBarMetricsDefault];
//    [bar setBackgroundColor:[UIColor colorWithRed:224.0 green:85.0 blue:35.0 alpha:1]]; //设置导航栏底部背景颜色
    [bar setBarTintColor:COLOR_ORANGE];
    //设置导航栏中间的标题
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    //导航栏字体H1大小，
    attrs[NSFontAttributeName] = H1;
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:attrs];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    //清空手势
    self.interactivePopGestureRecognizer.delegate = nil;
}
/**
 *  拦截导航控制器push进来的多有自控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置左上角按钮
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:JJBColor(251, 32, 37) forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        //让按钮的内容向左偏移20
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    JJBLog(@"%s",__func__);
    [self popViewControllerAnimated:YES];
}

@end
