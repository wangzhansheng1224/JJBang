//
//  LevelPrizeView.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelPrizeView.h"


@interface LevelPrizeView ()

@end
@implementation LevelPrizeView

#pragma -
#pragma mark - life cycle
-(instancetype)initWithImage:(NSString *)iconNormalImage selectImage:(NSString *)selectImage
{
    
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:iconNormalImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    }
    return self;
}



@end
