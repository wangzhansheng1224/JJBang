//
//  MBAliPayManger.h
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBAliPayManger : NSObject

+(void)aliPayWithParamDictonary:(NSDictionary *)paramDictonary callbackConfig:(void(^)(NSString * config))config;
@end
