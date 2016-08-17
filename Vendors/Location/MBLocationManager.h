//
//  MBLocationManager.h
//  jjb_user
//
//  Created by Maybe on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface MBLocationManager : NSObject

/**
 *  地理编码
 *
 *  @param address 地址
 *  @param success 成功返回pm
 *  @param failure 失败
 */
-(void)geocode:(NSString *)address success:(void(^)(CLPlacemark *pm))success failure:(void(^)())failure;

/**
 *  反地理编码
 *
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param success   成功block
 *  @param failure   失败block
 */

-(void)reverseGeoCodeWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude success:(void(^)(NSString * adress))success failure:(void(^)())failure;



@end
