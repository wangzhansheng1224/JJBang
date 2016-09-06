//
//  LevelPrizeSupView.h
//  jjb_user
//
//  Created by Maybe on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LevelPrizeView;

typedef void(^changeFrameBlock)(CGFloat changeFrameX);
@interface LevelPrizeSupView : UIView


-(instancetype)initWithItems:(NSArray *)items block:(changeFrameBlock)block;
//-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;
@property(nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) LevelPrizeView * levelPrizeButton;


@end
