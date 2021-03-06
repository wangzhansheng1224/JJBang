//
//  MBAliPayManger.m
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBAliPayManger.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "constantPay.h"
@implementation MBAliPayManger

+(void)aliPayWithParamDictonary:(NSDictionary *)paramDictonary callbackConfig:(void(^)(NSString * config))config{
    NSString *partner = AliPayPartnerID; // 商户ID
    NSString *seller = AliPaySellerID; // 账号
    NSString *privateKey = AliPayPrivateKey; // 私钥
    /*======================================*/
    
    
    /** **************根据信息, 创建一个订单, 给支付宝, 支付*************** */
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = paramDictonary[@"tradeNo"];
    
    order.productName =paramDictonary[@"productName"]; // 商品名称
    order.productDescription = paramDictonary[@"productDescription"]; // 商品描述
    order.amount = paramDictonary[@"amount"]; // 商品价格
    
    
    // 以后这个地方, 填写的是服务器给的地址
    order.notifyURL =paramDictonary[@"notifyURL"]; //回调URL
    
    // 以下几个参数都是固定格式
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1"; // 支付类型
    order.inputCharset = @"utf-8"; // 支付编码
    order.itBPay = @"30m"; // 订单超时时长
    order.showUrl = @"m.alipay.com"; // 固定值
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AliPayAppScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    if (!signedString.length) {
        JJBLog(@"支付宝签名失败");
        config(NO);
        return;
    }
    
    // //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            if ([resultDic[@"resultStatus"] intValue] == 9000) {
//                JJBLog(@"支付宝支付成功");
//                config(YES);
//            }
//        
//        }];
        [[AlipaySDK defaultService] auth_V2WithInfo:orderString
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               
    if ([resultDic[@"resultStatus"] intValue] == 9000) {
    JJBLog(@"支付宝支付成功");
    config(@"支付成功");
    }else if ([resultDic[@"resultStatus"] intValue] == 8000)
    {
           config(@"正在处理中...");
    }else if ([resultDic[@"resultStatus"] intValue] == 4000)
    {
        config(@"订单支付失败");
        
    }else if ([resultDic[@"resultStatus"] intValue] == 6001)
    {
        config(@"用户中途取消");
        
    }else if ([resultDic[@"resultStatus"] intValue] == 6002)
    {
        config(@"网络连接出错");
        
    }
                                               
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];

        
        
    }
}

@end
