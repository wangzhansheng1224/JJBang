//
//  LevelPrizeSupView.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelPrizeSupView.h"
#import "LevelPrizeView.h"

#define margin 1
#define cols 4
#define width ((Screen_Width-40 - (cols + 2) * margin) / cols)

@interface LevelPrizeSupView ()


@end

@implementation LevelPrizeSupView

-(instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        for(int i = 0;i <items.count; i++)
        {
            
            LevelPrizeView * levelPrizeButton = (LevelPrizeView *)items[i];
            levelPrizeButton.frame = CGRectMake(width*i+15,15, 30, 30);
            levelPrizeButton.selected = i;
            [self addSubview:levelPrizeButton];
            
            JJBLog(@"%@",NSStringFromCGRect(levelPrizeButton.frame));
        }

    }
    return self;
}



//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//
//    
//
//}
@end
