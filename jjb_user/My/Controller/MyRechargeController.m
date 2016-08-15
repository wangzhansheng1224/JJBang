//
//  MyRechargeController.m
//  jjb_user
//
//  Created by Maybe on 16/8/10.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//


#import "MyRechargeController.h"
#import "MyBalanceViewController.h"
#import "RechargeWeChatAndAliCell.h"
#import "RechargeWeChatAndAliView.h"
#import "WXApi.h"
#import "MyRechargeAPIManager.h"
#import "MyRechargeReformer.h"
#import "NSString+MBMD5.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
/**
 *  充值界面
 */
@interface MyRechargeController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property(nonatomic,weak) UITextField * moneyTextfield;
@property(nonatomic,weak) UILabel * nameLabel;
@property(nonatomic,weak) UIView * bjTextfieldView;
@property(nonatomic,strong) RechargeWeChatAndAliCell * cell;
@property(nonatomic,strong) RechargeWeChatAndAliView * RechargeWeChatAndAliView;
@property(nonatomic,weak) UIButton * rechargeButton;
@property(nonatomic,strong) LDAPIBaseManager * prepayIdManager;
@property(nonatomic,strong) id<ReformerProtocol> MyRecargeReformer;
@property(nonatomic,strong) NSMutableArray * arrData;
@property(nonatomic,copy) NSString * timeStamp;
@property(nonatomic,copy) NSString * prepayID;
@property(nonatomic,copy) NSString * order;

@end

static NSString * const RechargeCellIdentifier = @"rechargeIdentifier";
@implementation MyRechargeController

#pragma 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"充值";
    [self addSubViewConstraints];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma 
#pragma mark - private methods

-(void)addSubViewConstraints
{
    
    [self.bjTextfieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(70);
    }];
    
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjTextfieldView.mas_top).offset(20);
        make.left.equalTo(self.bjTextfieldView.mas_left).offset(48);
        make.bottom.equalTo(self.bjTextfieldView.mas_bottom).offset(-20);
        make.width.mas_equalTo(@35);
    }];
    
    
    [self.moneyTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
        make.right.equalTo(self.bjTextfieldView.mas_right);
        
    }];
   
    [self.RechargeWeChatAndAliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjTextfieldView.mas_bottom).offset(8);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);

    }];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RechargeWeChatAndAliView.mas_bottom).offset(21);
        make.left.equalTo(self.view.mas_left).offset(43);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
}
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary * dict = [manager fetchDataWithReformer:nil];
    
    NSDictionary * dictData = [dict objectForKey:@"data"];
//    NSString * strPrePayID = [dictData objectForKey:@"prepayid"];
    NSString * strOrder = [dictData objectForKey:@"order"];
    NSString * strTimestamp = [dictData objectForKey:@"timestamp"];
    NSString * notify_url = [dictData objectForKey:@"notify_url"];
//    self.prepayID = strPrePayID;
    self.order = strOrder;
    self.timeStamp = notify_url;
//    self.timeStamp = strTimestamp;
//    NSString * backString = [self jumpToBizPay];
    [self jumpAliPay];
//    if (![backString isEqualToString:@""]) {
//        JJBLog(@"%@",backString);
//    }

}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
//    return @{
//             @"shop_id":@"3",
//             @"user_id":@([UserModel currentUser].userID),
//             @"start":@(self.pageIndex),
//             @"count":@(self.pageSize),
//             @"isOwn":@"0"
//             };
    NSDictionary * dict = @{@"user_id":@([UserModel currentUser].userID),@"boby":@"余额充值",@"total_fee":@"0.1"};
    return dict;
                                

}


#pragma 
#pragma mark - private methods

//确认支付
-(void )gotoRecharge:(UIButton *)btn
{
    JJBLog(@"确认支付");
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    [self.prepayIdManager loadData];
    
}

-(NSString*)jumpToBizPay
{
    if(![WXApi isWXAppInstalled])
    {
        JJBLog(@"没有安装微信");
        return nil;
    }else if (![WXApi isWXAppSupportApi])
    {
        JJBLog(@"不支持微信支付");
        return nil;
    }
    
//    NSString *urlString   = @"http://115.29.221.199:8081/sys/rest/gateway/0/unifiedorder";
//    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
   
    //解析服务端返回json数据
//    NSError *error;
    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    
                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
                PayReq * req = [[PayReq alloc]init];
//      
                req.partnerId = @"1374304702";
                req.prepayId = self.prepayID;
                req.nonceStr = self.order;
//                req.nonceStr = [self genNonceStr];
                req.timeStamp = [self.timeStamp intValue];
                req.package = @"Sign=WXPay";
    
    NSLog(@"%@--%@--%@--%d--%@",req.partnerId,req.prepayId,req.nonceStr,req.timeStamp,req.package);
                NSString * signString =[self createMD5SingForPayWithAppID:@"wx8775f0d9d378c50e" partnerid:@"1374304702" prepayid:self.prepayID package:@"Sign=WXPay" noncestr:self.order timestamp:[self.timeStamp intValue]];
                req.sign = signString;
                
                [WXApi sendReq:req];
                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
//            }else{
//                return [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            return @"服务器返回错误，未获取到json对象";
//        }
//    }else{
//        return @"服务器返回错误";
    }


#pragma mark -  微信支付本地签名
//创建发起支付时的sign签名
-(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key{
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
/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [NSString md5String:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}



#pragma -
#pragma mark - AliPay

-(void)jumpAliPay
{
    
    
    
    // 以下代码, 就是支付流程
    
    /*================需要填写商户app申请的===================*/
    NSString *partner = @"2088121752646934"; // 商户ID
    NSString *seller = @"ahqcsjwhyl@163.com"; // 账号
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANcglVmjesM2xpuKtoTQkK9vVOV5QEFyxL7ZS5WQhodRkk0rrZKQxjEfniFdr1feKPBNDZAxJQfhbh9rEuPqdq7+nfNlgjU0LcZ38k4ufJ+qzAV0xrQpfyZr1+8FHEht8nBcfWg1US0z72OOBvJ3E0NirjHBEWGbLkJKdW6osZmVAgMBAAECgYByUvKLrIE09Qse5dyRQHVjhfrL6F/paCB+e+PbG+8iQotJT4jydtWcjXzvpmXkgD+pVIl8s2FGitqG/9QOIy/mXgLM3IiTMrCxiDF3DynyKshJa1hKfl3dFl25gGsvvVvA3lEiXWFPm0fdvAk9JQ5NUREY9oxWndWHQoLUcH5sEQJBAPJWD0h+PRC79gArTjCZVlIh57e4IuvtE4NeIbRreufmIs9QI7EPf8cdfv2WRnw2XZo9CzNDWo0qr8rw6X+wg0sCQQDjQcioOL9H9lNqjdG9BTxQ6fIUbQz48c9A1h/FYXJYXJUZjg2EYGUXvEZxZkjKlud+L2TFN6ExB70/b6cYOWqfAkEArvqW9Hg6bY/ak8qxHYRKgOl8X/q0NHgtg8h/O7/zsehJMDokW1/emo5guIg+gsfalFkJck1q3813u2hyoUF5uwJAROwakwpC2OxX+CTyy0TfOhr5lEBOguGzXZKTKCWZrDrH7WwrpU4m2r/7DUFcKjUCGD7/bOCmPlx+hNKz9qDTOQJBAKbl5RxUdoaX25zlyfdnLWdydbhW3G1HgXbUPLwTAro+7jtJD6PN1zdkw6pZA1Gnkumecxkc4ccy60q2yVFk+j0="; // 私钥
    /*======================================*/
    
    
    /** **************根据信息, 创建一个订单, 给支付宝, 支付*************** */
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = self.order;
    
    order.productName = @"余额充值"; // 商品名称
    order.productDescription = @"余额充值1"; // 商品描述
    order.amount = @"0.01"; // 商品价格
    
    
    // 以后这个地方, 填写的是服务器给的地址
    order.notifyURL =  self.timeStamp; //回调URL
    
    // 以下几个参数都是固定格式
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1"; // 支付类型
    order.inputCharset = @"utf-8"; // 支付编码
    order.itBPay = @"30m"; // 订单超时时长
    order.showUrl = @"m.alipay.com"; // 固定值
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"jjb_user_AliPay";
    
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
#pragma
#pragma mark - getter and setter
-(UITextField *)moneyTextfield
{
    if (_moneyTextfield == nil) {
        UITextField * textField = [[UITextField alloc]init];
        textField.placeholder = @"输入充值金额";
        textField.font = [UIFont systemFontOfSize:14];
        
        [self.bjTextfieldView addSubview:textField];
        
        _moneyTextfield = textField;
        
    }
    return _moneyTextfield;
}
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"充值";
        label.font = H2;
//        label.font = [UIFont systemFontOfSize:20];
        [label sizeToFit];
        [self.bjTextfieldView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
-(UIView *)bjTextfieldView
{
    if (_bjTextfieldView == nil) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = COLOR_WHITE;
        [self.view addSubview:view];
        _bjTextfieldView = view;
    }
    return _bjTextfieldView;
}
-(RechargeWeChatAndAliCell *)cell
{
    if (_cell == nil) {
        RechargeWeChatAndAliCell * cell = [[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"img_default"] title:@"支付宝支付"];
        [self.view addSubview:cell];
        _cell = cell;
        
    }
    return _cell;
}
-(RechargeWeChatAndAliView *)RechargeWeChatAndAliView
{
    if (_RechargeWeChatAndAliView == nil) {
        NSArray * item =@[[[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_rechargeAli"] title:@"支付宝支付"],[[RechargeWeChatAndAliCell alloc]initWithImage:[UIImage imageNamed:@"my_weChat"] title:@"微信支付"]];
        RechargeWeChatAndAliView * view = [[RechargeWeChatAndAliView alloc]initWithItems:item];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        _RechargeWeChatAndAliView = view;
    }
    return _RechargeWeChatAndAliView;
    
}
-(UIButton *)rechargeButton
{
    if (_rechargeButton == nil) {
        UIButton * buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:@"确认支付" forState:UIControlStateNormal];
        [buttton addTarget:self action:@selector(gotoRecharge:) forControlEvents:UIControlEventTouchUpInside];
        [buttton setBackgroundColor:COLOR_ORANGE];
        [buttton.layer setMasksToBounds:YES];
        [buttton.layer setCornerRadius:5.0f];
        [self.view addSubview:buttton];
        _rechargeButton = buttton;
    }
    return _rechargeButton;
}
-(LDAPIBaseManager *)prepayIdManager
{
    if (_prepayIdManager == nil) {
        _prepayIdManager = [MyRechargeAPIManager sharedInstance];
        _prepayIdManager.delegate = self;
        _prepayIdManager.paramSource = self;
    }
    return _prepayIdManager;
}
-(id<ReformerProtocol>)MyRecargeReformer
{
    if (_MyRecargeReformer == nil) {
        _MyRecargeReformer = [[MyRechargeReformer alloc]init];
    }
    return _MyRecargeReformer;
}
-(NSMutableArray *)arrData
{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
-(NSString *)prepayID
{
    if (_prepayID == nil) {
        _prepayID = [[NSString alloc]init];
    }
    return _prepayID;
}
-(NSString *)timeStamp
{
    if (_timeStamp == nil) {
        _timeStamp = [[NSString alloc]init];
    }
    return _timeStamp;
}
-(NSString *)order
{
    if (_order == nil) {
        _order = [[NSString alloc]init];
    }
    return _order;
}
@end
