//
//  MBWeChatPayMaager.h
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBWeChatPayManger : NSObject
/**
 *  单一商户
 *
 *  @param orderID     支付订单号
 *  @param orderString 订单的商品描述
 *  @param amout       订单金额
 */
+(void)wxPayWithOrderID:(NSString *)orderID
             orderTitle:(NSString *)orderString
                  amout:(NSString *)amout;


+(void)wxPayWithInfoDictionary:(NSDictionary *)paramDict;

+(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key;
@end
