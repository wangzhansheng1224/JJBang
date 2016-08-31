//
//  MBGuideTool.m
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

/**
 *  版本选择
 */
#import "MBGuideTool.h"
#import "MBNSUserDefaultsTool.h"
#import "BaseTabBarController.h"
#import "MBNewFeatureController.h"


#define MBVersion @"version"
#ifdef DEBUG

#endif
@implementation MBGuideTool
+(void)selectRootViewController:(UIWindow *)window
{
    //当前版本与上一版本比较
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSString * lastVersion = [MBNSUserDefaultsTool objectForKey:MBVersion];
    if ([currentVersion isEqualToString:lastVersion]) {
        //没有新版本
        //设置窗口根控制器
        UITabBarController * tabBarController = [[BaseTabBarController alloc]init];
        window.rootViewController = tabBarController;
        
        /**
         测试
         */
//        MBNewFeatureController * newFeatureController = [[MBNewFeatureController alloc]init];
//        window.rootViewController = newFeatureController;
//        [MBNSUserDefaultsTool setObject:currentVersion forKey:MBVersion];
        
        
        [window makeKeyAndVisible];
    }
    else
    {
    
        //有新版本
        MBNewFeatureController * newFeatureController = [[MBNewFeatureController alloc]init];
        window.rootViewController = newFeatureController;
        [MBNSUserDefaultsTool setObject:currentVersion forKey:MBVersion];
        [window makeKeyAndVisible];
        
    }
}
@end
