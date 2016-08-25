//
//  LevelPrizeSupView.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelPrizeSupView.h"
#import "LevelPrizeView.h"
@implementation LevelPrizeSupView

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        for(int i = 0;i < items.count; i++)
        {
            
            CGFloat a = (self.frame.size.width - (30 * 4))/5;
            JJBLog(@"%lf",a);
            JJBLog(@"%lf",self.frame.size.width);
            JJBLog(@"%@",NSStringFromCGRect(frame));
            LevelPrizeView * levelPrizeButton = (LevelPrizeView *)items[i];
            levelPrizeButton.frame = CGRectMake((i*30+a),400 , 30, 30);
            JJBLog(@"%@",NSStringFromCGRect(levelPrizeButton.frame));
            
            [self addSubview:levelPrizeButton];
        }
        
        
    }
    return self;
}

@end
