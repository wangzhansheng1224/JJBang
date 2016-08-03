//
//  UIImage+image.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+(instancetype)imageNamedWithOriganlMode:(NSString *)imageName
{
    //加载原始视图，返回未渲染的图片
    UIImage * selectImage = [UIImage imageNamed:imageName];
    UIImage * OriganImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return OriganImage;
}
@end
