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

+(void)aliPayWithParamDictonary:(NSDictionary *)paramDictonary
{
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
    
    
    // //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
        
    }

    
}
@end
