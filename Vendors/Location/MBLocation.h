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

typedef void (^LocationBlock)(NSDictionary *dic);

@interface MBLocation : NSObject<CLLocationManagerDelegate>
SingleH(MBLocation);
@property(nonatomic,strong) CLLocationManager * locationManager;
@property(nonatomic,assign) double longitude; //经度
@property(nonatomic,assign) double latitude; //纬度

-(void)startLocation; // 开始定位

-(void)reverseGeoCodesuccess:(void(^)(NSDictionary * adress))success failure:(void(^)())failure;
-(void) locationSuccess:(LocationBlock) block;
@end
