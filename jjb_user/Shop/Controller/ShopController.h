//
//  ShopController.h
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//
//
/**
 *  首页店铺主控制器
 */
#import <UIKit/UIKit.h>

@protocol ClassViewCellDelegat <NSObject>

//-(void)classViewCell:(Cla)

@end
@interface ShopController : UITableViewController

@property(nonatomic,strong) NSMutableArray * groupsArray;

@end
