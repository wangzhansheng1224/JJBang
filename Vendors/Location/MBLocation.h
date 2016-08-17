//
//  MBLocation.h
//  jjb_user
//
//  Created by Maybe on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "single.h"
#import <CoreLocation/CoreLocation.h>
@interface MBLocation : NSObject<CLLocationManagerDelegate>
SingleH(MBLocation);
@property(nonatomic,strong) CLLocationManager * locationManager;
@property(nonatomic,assign) double longitude; //经度
@property(nonatomic,assign) double latitude; //纬度
@property(nonatomic,copy) NSString * city ; //城市名
@property(nonatomic,copy) NSString * address ;  // 详细地址
//定位结束回调
@property(nonatomic,copy) void (^LocationBlock)(double longitude,double latitude);

-(void)getAuthorization; //授权
-(void)startLocation; // 开始定位

-(void)reverseGeoCodesuccess:(void(^)(NSDictionary * adress))success failure:(void(^)())failure;

@end
