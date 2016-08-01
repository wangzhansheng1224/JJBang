//
//  UIColor+MBHex.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UIColor+MBHex.h"

@implementation UIColor (MBHex)
+(UIColor *)colorWithHexString:(NSString *)stringColor
{
    return [self colorWithHexString:stringColor alpha:1.0f];
}

+(UIColor *)colorWithHexString:(NSString *)stringColor alpha:(CGFloat)alpha
{
    NSString * cString = [stringColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (cString.length < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [stringColor substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [stringColor substringFromIndex:1];
    }
    if (cString.length != 6) {
        return [UIColor clearColor];
    }
    NSRange range = NSMakeRange(0, 2);
    //r
    NSString * rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString * gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString * bString = [cString substringWithRange:range];
    unsigned int r , g ,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return  [UIColor colorWithRed:((float)r/255.0) green:((float)g/255.0) blue:((float)b/255.0) alpha:alpha];
    
}

@end
