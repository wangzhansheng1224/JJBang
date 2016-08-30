//
//  MBTextFieldTool.h
//  jjb_user
//
//  Created by Maybe on 16/8/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBTextFieldTool : NSObject
+ (BOOL)isNumber:(NSString *)num;
+ (BOOL)isNumberOrLetter:(NSString *)num;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isBlankString:(NSString *)string;
@end
