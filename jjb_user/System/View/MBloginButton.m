//
//  MBloginButton.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBloginButton.h"
#import "UIView+MBFrame.h"
/**
 *  自定义登录按钮
 */
@implementation MBloginButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片
    self.imageView.Y= 0;
    self.imageView.centerX = self.width * 0.5;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.Y = self.height - self.titleLabel.height;
    self.titleLabel.centerX = self.width * 0.5;

}

@end
