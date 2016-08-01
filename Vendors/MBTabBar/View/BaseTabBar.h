//
//  BaseTabBar.h
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTabBar;

@protocol MBTabBarDelegate <NSObject>

@optional
-(void)tabBar:(BaseTabBar *)tabBar didClickBtn:(NSInteger)index;

@end
@interface BaseTabBar : UIView

@property(nonatomic,strong) NSArray * tabBarItems;
@property(nonatomic,weak) id <MBTabBarDelegate> delegate;
@end
