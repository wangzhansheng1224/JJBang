//
//  UIImage+MB.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UIImage+MB.h"

@implementation UIImage (MB)
-(instancetype)circleImage
{
    //开启
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = {CGPointZero,self.size};
    CGContextAddEllipseInRect(context, rect);
    //裁剪
    CGContextClip(context);
    [self drawInRect:rect];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭
    UIGraphicsEndImageContext();
    return image;
}
@end
