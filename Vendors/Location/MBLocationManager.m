//
//  MBLocationManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface MBLocationManager ()
@property(nonatomic,strong)CLGeocoder * geocoder;

@end
@implementation MBLocationManager



//地理编码
-(void)geocode:(NSString *)address success:(void(^)(CLPlacemark *pm))success failure:(void(^)())failure
{
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure();
            }
        }
        else
        {
            //编码成功
            CLPlacemark * pm = [placemarks firstObject];
            if (success) {
                success(pm);
            }
        }
    }];
}

//反地理编码
-(void)reverseGeoCodeWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude success:(void (^)(NSString *))success failure:(void (^)())failure
{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            JJBLog(@"%@",error.description);
            if (failure) {
                failure();
            }
        }
        else
        {
            CLPlacemark * pm = [placemarks firstObject];
            if (success) {
                success(pm.name);
            }
        }
    }];
}



#pragma -
#pragma mark - getter and setter
-(CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}
@end
