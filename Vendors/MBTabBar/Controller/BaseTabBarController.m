//
//  BaseTabBarController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBar.h"
#import "ShopController.h"
#import "GrowingTreeController.h"
#import "ActivityController.h"
#import "MyController.h"
#import "BaseNavigationController.h"
#import "UIImage+image.h"
@interface BaseTabBarController ()<MBTabBarDelegate>

@property(nonatomic,strong) NSMutableArray * items;
@end



@implementation BaseTabBarController
#pragma mark
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCustomTabBar];
    
    [self setUpAllChildControllers];
    
}


#pragma mark
#pragma mark - private methods
//修改tabbar里面的属性
-(void)setCustomTabBar
{
//    UITabBarItem * item = [UITabBarItem appearance];
//
//    NSMutableDictionary * normalAttrs = [NSMutableDictionary dictionary];
//    
//    normalAttrs[NSFontAttributeName] = H5;
//    normalAttrs[NSForegroundColorAttributeName] = COLOR_GRAY;
//    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    
//    NSMutableDictionary * selectAttrs = [NSMutableDictionary dictionary];
//    selectAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
//    //取消tabbar的半透明效果
//    [UITabBar appearance].translucent = NO;
  }


//添加所有子控制器
-(void)setUpAllChildControllers
{
    //首页界面
    ShopController * shopVC = [[ShopController alloc]init];
    [self setUpOneChildController:shopVC image:[UIImage imageNamed:@"tab_index_normal"] clickImage:[UIImage imageNamed:@"tab_index_selected"] title:@"首页"];
    
    /**
     成长界面
     */
    GrowingTreeController * growingTreeVC = [[GrowingTreeController alloc]init];
    [self setUpOneChildController:growingTreeVC image:[UIImage imageNamed:@"tab_growingtree_normal"] clickImage:[UIImage imageNamed:@"tab_growingtree_selected"] title:@"成长"];
    /**
     *  活动界面
     */
    ActivityController * activityVC = [[ActivityController alloc]init];
    [self setUpOneChildController:activityVC image:[UIImage imageNamed:@"tab_activity_normal"] clickImage:[UIImage imageNamed:@"tab_activity_selected"] title:@"活动"];
    
    //个人中心界面
    
    MyController * myVC = [[MyController alloc]init];
    [self setUpOneChildController:myVC image:[UIImage imageNamed:@"tab_my_normal"] clickImage:[UIImage imageNamed:@"tab_my_selected"] title:@"个人"];
    
}

//添加子控制器，并设置响对应的内容
-(void)setUpOneChildController:(UIViewController *)vc image:(UIImage *)norImage clickImage:(UIImage*)selImage title:(NSString *)titleString
{
    BaseNavigationController * Nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:Nav];
    
    //设置导航条
    vc.title = titleString;
    vc.tabBarItem.image = norImage;
//    //返回一张未被渲染的图片
//    vc.tabBarItem.selectedImage =  [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
}

#pragma mark
#pragma mark - setter--getter
-(NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
