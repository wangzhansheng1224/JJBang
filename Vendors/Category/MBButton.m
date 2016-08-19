//
//  MBButton.m
//  jjb_user
//
//  Created by Maybe on 16/8/19.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBButton.h"

@interface MBButton ()

@property(nonatomic,copy)MBButtonBlock tempBlock;
@end
@implementation MBButton
+(MBButton *)buttonWithTitle:(NSString *)title Block:(MBButtonBlock)myBlock
{

    MBButton * button = [MBButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}



+(MBButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(MBButtonBlock)myBlock
{
    MBButton * button = [MBButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}


+(MBButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title selectTitle:(NSString *)selectTitle andBlock:(MBButtonBlock)myBlock
{
    MBButton * button = [MBButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

+(MBButton *)buttonWithFrame:(CGRect)frame normalImage:(NSString *)imageName andBlock:(MBButtonBlock)myBlock
{
    MBButton * button = [MBButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

+(MBButton *)buttonWithFrame:(CGRect)frame normalImage:(NSString *)imageName selectImage:(NSString *)selectImage andBlock:(MBButtonBlock)myBlock
{
    MBButton * button = [MBButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = myBlock;
    return button;
}

-(void)btnClick:(UIButton *)btn
{
    if (self.tempBlock) {
        self.tempBlock();
    }
}

@end
