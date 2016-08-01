//
//  BaseTabBar.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "BaseTabBar.h"

@interface BaseTabBar ()

@property(nonatomic,weak) UIButton * selectBtn;  //点击按钮

@end
@implementation BaseTabBar


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    }
    return self;
}

//设置位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.subviews;
    CGFloat btnW = self.frame.size.width / count;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    for(int i = 0 ; i <count ;i++)
    {
        UIButton * btn = self.subviews[i];
        btnX = i* btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}
-(void)btnClick:(UIButton *)btn
{
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [_delegate tabBar:self didClickBtn:btn.tag];
    }
    
}
#pragma mark -
#pragma mark setter-- getter
-(void)setTabBarItems:(NSArray *)tabBarItems
{
    _tabBarItems = tabBarItems;
    for (UITabBarItem * item in tabBarItems) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:item.image forState:UIControlStateNormal];
        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = self.subviews.count;
        if (self.subviews.count == 0) {
            [self btnClick:btn];
        }
        [self addSubview:btn];
    }
    
}
@end
