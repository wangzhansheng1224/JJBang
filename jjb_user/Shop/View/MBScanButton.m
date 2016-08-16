//
//  MBScanButton.m
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBScanButton.h"

@implementation MBScanButton

#pragma -
#pragma mark - life cycle
-(instancetype)initWithImage:(NSString *)image
{
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    }
    return self;
}


-(void)addScanViewControllerBlock:(ScanButtonBlock)block
{
    _block = block;
    [self addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ButtonClick:(UIButton *)button
{
    _block(button);
}
@end
