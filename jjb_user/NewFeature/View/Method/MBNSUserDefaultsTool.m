//
//  MBNSUserDefaultsTool.m
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

//对NSUserDefaults存取封装
#import "MBNSUserDefaultsTool.h"

@implementation MBNSUserDefaultsTool
+(id)objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+(void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
}
@end
