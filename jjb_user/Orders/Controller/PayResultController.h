//
//  PayResultController.h
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayResultController : UIViewController
@property (nonatomic,strong) NSString* orderNo;
//用来判断支付宝支付结果
@property (nonatomic,strong) NSString * aliPayStatus;

//余额支付状态
@property(nonatomic,assign) BOOL isSuccess;
@end
