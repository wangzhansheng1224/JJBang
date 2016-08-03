//
//  UIBarButtonItem+MBCustom.h
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIBarButtonItem (MBCustom)
+(UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action;

+(UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage target:(nullable id)target action:(nullable SEL)action;

-(UIBarButtonItem *)backItmeWithNormalImage:(UIImage *)normalImage high:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action norColor:(UIColor *)norColor highColor:(UIColor *)highColor title:(NSString *)title;

@end
