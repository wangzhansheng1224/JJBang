//
//  AppDelegate.m
//  jjb_user
//
//  Created by Aimee on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "MBGuideTool.h"
#import "MBAdViewController.h"
#import "WXApi.h"

const static NSString *GAODEAPIKey = @"971d2c7badeca69b622d264bc7eeee47";
@interface AppDelegate ()<WXApiDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window =  [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:COLOR_ORANGE];
    //设置导航栏为不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    //TabBar选中图标的颜色,默认是蓝色
    [[UITabBar appearance] setTintColor:COLOR_ORANGE];
    //设置tabbar为不透明
    [UITabBar appearance].translucent = NO;
    //设置表格的背景色
    [[UITableView appearance] setBackgroundColor:COLOR_LIGHT_GRAY];
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleNone];
    //设置通用按钮样式
    
//    [[UIButton appearance] setBackgroundColor:COLOR_ORANGE];
//    [[UIButton appearance] setTintColor:COLOR_WHITE];
//    
//    [[UIBarButtonItem appearance] setTintColor:COLOR_WHITE];
//    BaseTabBarController * tabBarVC = [[BaseTabBarController alloc]init];
//    self.window.rootViewController = tabBarVC;
//    [self.window makeKeyAndVisible];
    //判断是否有新特性
    [MBGuideTool selectRootViewController:self.window];
//    MBAdViewController * tab = [[MBAdViewController alloc]init];
//    self.window.rootViewController = tab;
//    [self.window makeKeyAndVisible];
    
    /**
     *  注册微信支付
     */
    [WXApi registerApp:@"wx8775f0d9d378c50e"];
    
    return YES;
}

- (void)onResp:(BaseResp *)resp {
if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [[[CTMediator sharedInstance] performActionWithUrl:url completion:nil] boolValue];

}



-(UINavigationController *)navController{
        UITabBarController * tabControler = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController ;
      return  (UINavigationController *)[tabControler selectedViewController];
}

@end
