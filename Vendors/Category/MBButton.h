//
//  MBButton.h
//  jjb_user
//
//  Created by Maybe on 16/8/19.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MBButtonBlock)();

@interface MBButton : UIButton


+(MBButton *)buttonWithTitle:(NSString *)title Block:(MBButtonBlock)myBlock;



+(MBButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(MBButtonBlock)myBlock;


+(MBButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title selectTitle:(NSString *)selectTitle andBlock:(MBButtonBlock)myBlock;

+(MBButton *)buttonWithFrame:(CGRect)frame normalImage:(NSString *)imageName andBlock:(MBButtonBlock)myBlock;

+(MBButton *)buttonWithFrame:(CGRect)frame normalImage:(NSString *)imageName selectImage:(NSString *)selectImage andBlock:(MBButtonBlock)myBlock;
@end
