//
//  UIColor+MBHex.h
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>
/**
 *  此分类用来转化色值
 */
@interface UIColor (MBHex)
+(UIColor *)colorWithHexString:(NSString *)stringColor;

//识别16进制的颜色0X123456 #123456
+(UIColor *)colorWithHexString:(NSString *)stringColor alpha:(CGFloat)alpha;
@end
