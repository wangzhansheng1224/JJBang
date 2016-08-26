//
//  UIImageView+MB.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UIImageView+MB.h"
#import "UIImage+MB.h"
@implementation UIImageView (MB)
-(void)setHeader:(NSString *)url
{
    //设置站位图片
    UIImage * placeholder = [[UIImage imageNamed:@"img_default"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image== nil) {
            return ;
        }
        self.image = [image circleImage];
    }];
}

@end
