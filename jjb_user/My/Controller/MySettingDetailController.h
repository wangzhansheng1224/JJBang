//
//  MySettingDetailController.h
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetBlock)(NSString * content);

@interface MySettingDetailController : UIViewController

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * sign;

@property (nonatomic, copy) NSString * password;

@property (nonatomic, copy) NSString * phoneNum;

@property (nonatomic, copy) NSString * weixinNum;

@property (nonatomic, copy) NSString * qqNum;

@property (nonatomic, copy) SetBlock block;

@end
