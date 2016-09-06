//
//  LevelPrizeSupView.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelPrizeSupView.h"
#import "LevelPrizeView.h"

@interface LevelPrizeSupView ()
@property(nonatomic,copy) changeFrameBlock changeFrameBlock;
@end

@implementation LevelPrizeSupView

-(instancetype)initWithItems:(NSArray *)items block:(changeFrameBlock)block;
{
    self = [super init];
    self.changeFrameBlock = block;
    if (self) {
        for(int i = 0;i <items.count; i++)
        {
            CGFloat width = 30;
            int cols = 4;
            CGFloat margin = (Screen_Width - 60 - cols * width) / (cols+1);
            
            _levelPrizeButton = (LevelPrizeView *)items[i];
            _levelPrizeButton.frame = CGRectMake((width+margin)*i+margin,15, 30, 30);
            self.selectIndex = _levelPrizeButton.tag;
            [self addSubview:_levelPrizeButton];
        }
        NSInteger level = [UserModel currentUser].level;

        for (int j = 0; j<=level; j++) {
            UIButton * button = (LevelPrizeView *)items[j];
            button.selected = YES;
            
            if(j==level)
            {
            
            CGFloat X = button.centerX+30;
            block(X);
            }

        }

    }
    return self;
}



@end
