//
//  MBNSUserDefaultsTool.h
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBNSUserDefaultsTool : NSObject

+(id)objectForKey:(NSString *)defaultName;
+(void)setObject:(id)value forKey:(NSString *)defaultName;
@end
