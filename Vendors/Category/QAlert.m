//
//  QAlert.m
//  jjb_user
//
//  Created by Check on 16/8/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "QAlert.h"

@implementation QAlert

+ (void)showAlertWithController:(UIViewController *)ctrView andTitle:(NSString *)title andMessage:(NSString *)message andTime:(NSTimeInterval)time{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    [ctrView presentViewController:alert animated:YES completion:nil];
    
    
    //    [ELNAlert performSelector:@selector(dismissWithAlert:) withObject:alert afterDelay:time];
    [self performSelector:@selector(dismissWithAlert:) withObject:alert afterDelay:time];
}

+ (void)dismissWithAlert:(UIAlertController *)alert{
    
    
    [alert dismissViewControllerAnimated:YES completion:nil];
}

@end
