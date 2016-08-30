//
//  QAlert.h
//  jjb_user
//
//  Created by Check on 16/8/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QAlert : NSObject

+ (void)showAlertWithController:(UIViewController *)ctrView andTitle:(NSString *)title andMessage:(NSString *)message andTime:(NSTimeInterval)time;

@end
