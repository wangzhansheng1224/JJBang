//
//  ViewControllerIntercepter.m
//  jjb_user
//
//  Created by Aimee on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ViewControllerIntercepter.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import "ActivityController.h"
#import "ActivityListController.h"
#import "ParticipationController.h"

@implementation ViewControllerIntercepter
+ (void)load
{
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
    [ViewControllerIntercepter sharedInstance];
}

/*
 
 按道理来说，这个sharedInstance单例方法是可以放在头文件的，但是对于目前这个应用来说，暂时还没有放出去的必要
 
 当业务方对这个单例产生配置需求的时候，就可以把这个函数放出去
 */
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /* 在这里做好方法拦截 */
        [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
                    [self loadView:[aspectInfo instance]];
                } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewWillAppear:animated viewController:[aspectInfo instance]];
        } error:NULL];
        
    }
    return self;
}


/*
 各位架构师们，这里就是你们可以发挥聪明才智的地方啦。
 你也可以随便找一个什么其他的UIViewController，只要加入工程中，不需要额外添加什么代码，就可以做到自动拦截了。
 
 所以在你原来的架构中，大部分封装UIViewController的基类或者其他的什么基类，都可以使用这种方法让这些基类消失。
 */
#pragma mark - fake methods
- (void)loadView:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"[%@ loadView]", [viewController class]);
}

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
//    //设置导航栏背景
//    UINavigationBar * bar = [UINavigationBar appearance];
//    [bar setBackgroundColor:COLOR_ORANGE];
//    
//    //设置导航栏中间的标题
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
//    [bar setTitleTextAttributes:attrs];
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */

//    if ([ActivityController class]==[viewController class]||[ActivityListController class]==[viewController class]||[ParticipationController class]==[viewController class]) {
//        viewController.navigationController.navigationBarHidden = YES;
//    }
//    else
//        viewController.navigationController.navigationBarHidden = NO;
}

@end
