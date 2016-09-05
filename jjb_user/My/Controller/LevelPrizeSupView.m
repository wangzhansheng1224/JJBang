//
//  LevelPrizeSupView.m
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelPrizeSupView.h"
#import "LevelPrizeView.h"

//#define margin 20
//#define cols 4
//#define width ((Screen_Width-40 - margin*(cols-1)) / cols)

@interface LevelPrizeSupView ()


@end

@implementation LevelPrizeSupView

-(instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        for(int i = 0;i <items.count; i++)
        {
            CGFloat width = 30;
            int cols = 4;
            CGFloat margin = (Screen_Width - 60 - cols * width) / (cols+1);
            
            LevelPrizeView * levelPrizeButton = (LevelPrizeView *)items[i];
            levelPrizeButton.frame = CGRectMake((width+margin)*i+margin,15, 30, 30);

            
            UIButton * button = (LevelPrizeView *)items[0];
            button.selected = YES;
            
            self.selectIndex = levelPrizeButton.tag;
            [self addSubview:levelPrizeButton];
                    }
        NSInteger level = [UserModel currentUser].level;

        for (int j = 0; j<=level; j++) {
            UIButton * button = (LevelPrizeView *)items[j];
            button.selected = YES;

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
