//
//  MBWeChatPayMaager.m
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBWeChatPayManger.h"
#import "payRequsestHandler.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "constantPay.h"
#import "NSString+MBMD5.h"
@implementation MBWeChatPayManger
+(void)wxPayWithOrderID:(NSString *)orderID orderTitle:(NSString *)orderString amout:(NSString *)amout
{
    NSString * priceString = [NSString stringWithFormat:@"%.f",amout.floatValue * 100];
    if (priceString.floatValue <= 0) {
        return;
    }
    //创建支付签名对象
    payRequsestHandler * req = [payRequsestHandler alloc];
    //创建支付签名对象
    [req init:WeChatAppID mch_id:WeChatPartnerID];
    //设置秘钥
    [req setKey:WeChatPrivateKey];
    //获取到实际调取微信支付的参数，在app调取
    NSMutableDictionary * dict = [req sendPay_demo:orderID title:orderString price:priceString];
    if (dict == nil) {
        //错误提示
        NSString * debug = [req getDebugifo];
        [self alert:@"错误提示" msg:debug];
    }else
    {
        NSMutableString * stamp = [dict objectForKey:@"timestamp"];
        PayReq * req = [[PayReq alloc]init];
        req.openID        = [dict objectForKey:@"appid"];
        req.partnerId     = [dict objectForKey:@"partnerid"];
        req.prepayId      = [dict objectForKey:@"prepayid"];
        req.nonceStr      = [dict objectForKey:@"noncestr"];
        req.timeStamp     = stamp.intValue;
        BOOL status = [WXApi sendReq:req];
    
    }
    
    
    
    
    
}
+(void )wxPayWithInfoDictionary:(NSDictionary *)paramDict
{
    if(![WXApi isWXAppInstalled])
    {
//        JJBLog(@"没有安装微信");
        [self alert:@"提示" msg:@"没有安装微信"];
        return ;
    }else if (![WXApi isWXAppSupportApi])
    {
        [self alert:@"提示" msg:@"不支持微信支付"];
        return ;
    }
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = WeChatPartnerID;
    req.prepayId = paramDict[@"prepayid"]; //订单号
    req.nonceStr = paramDict[@"order"];    //用后台返回的32位订单号做随机码
    //                req.nonceStr = [self genNonceStr];
    req.timeStamp = [paramDict[@"timestamp"] intValue];
    req.package = @"Sign=WXPay";
    
    NSLog(@"%@--%@--%@--%d--%@",req.partnerId,req.prepayId,req.nonceStr,req.timeStamp,req.package);
    NSString * signString =[self createMD5SingForPayWithAppID:WeChatAppID partnerid:WeChatPartnerID prepayid:req.prepayId package:@"Sign=WXPay" noncestr:req.nonceStr timestamp:req.timeStamp];
    
    req.sign = signString;
    
    [WXApi sendReq:req];


}
#pragma mark -  微信支付本地签名
                            //创建发起支付时的sign签名
+(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:noncestr_key forKey:@"noncestr"];//随机字符串
    [signParams setObject:package_key forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:partnerid_key forKey:@"partnerid"];//商户账号
    [signParams setObject:prepayid_key forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:[NSString stringWithFormat:@"%u",timestamp_key] forKey:@"timestamp"];//时间戳
    
    //    NSMutableString *contentString  =[NSMutableString string];
    // 排序, 因为微信规定 ---> 参数名ASCII码从小到大排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //生成 ---> 微信规定的签名格式
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    // 拼接API密钥
    NSString *result = [NSString stringWithFormat:@"%@&key=%@", signString, @"1qazWSX3edcRFV5tgbYHN7ujmIK9ol0p"];
    // 打印检查
    NSLog(@"result = %@", result);
    // md5加密
    NSString *signMD5 = [NSString md5String:result];
    // 微信规定签名英文大写
    signMD5 = signMD5.uppercaseString;
    // 打印检查
    NSLog(@"signMD5 = %@", signMD5);
    return signMD5;
}


+(void)alert:(NSString *)title msg:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
