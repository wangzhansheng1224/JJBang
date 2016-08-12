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
    NSString * strPrePayID = [dictData objectForKey:@"prepayid"];
    NSString * strOrder = [dictData objectForKey:@"order"];
    NSString * strTimestamp = [dictData objectForKey:@"timestamp"];
    self.prepayID = strPrePayID;
    self.order = strOrder;
    self.timeStamp = strTimestamp;
    
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
    NSDictionary * dict = @{@"user_id":@([UserModel currentUser].userID),@"boby":@"余额充值",@"total_fee":@"10"};
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
    NSString * backString = [self jumpToBizPay];
    if (![backString isEqualToString:@""]) {
        JJBLog(@"%@",backString);
    }
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
    
    NSString *urlString   = @"http://115.29.221.199:8081/sys/rest/gateway/0/unifiedorder";
//    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
   
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
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
                req.prepayId = self.order;
                req.nonceStr = self.prepayID;
                req.timeStamp = [self.timeStamp intValue];
                req.package = @"Sign=WXPay";
                
                NSString * signString =[self createMD5SingForPayWithAppID:@"wx8775f0d9d378c50e" partnerid:@"1374304702" prepayid:self.order package:@"Sign=WXPay" noncestr:self.prepayID timestamp:[self.timeStamp intValue]];
                req.sign = signString;
                
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }

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
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段  API 密钥
    [contentString appendFormat:@"key=%@", @"商户密钥"];
//    NSString *result = [NSString ];
   NSString *result =  [NSString md5String:contentString];
    //md5加密
    return result;
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
