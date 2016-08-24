//
//  MBLocation.m
//  jjb_user
//
//  Created by Maybe on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MBLocation.h"
#import "single.h"

@interface MBLocation ()
@property(nonatomic,strong) CLGeocoder * geocoder;

@end
@implementation MBLocation
SingleM(MBLocation);

#pragma -
#pragma mark - private methods
//取得定位授权
-(void)getAuthorization
{
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                break;
            case kCLAuthorizationStatusNotDetermined:
                [self.locationManager requestWhenInUseAuthorization];
                break;
            case kCLAuthorizationStatusDenied:
                [self alertOpenLocationSwitch:@"提示" messgae:@"请在隐私设置中打开定位"];
                break;
            default:
                
                break;
        }
    }
}
-(void)alertOpenLocationSwitch:(NSString *)title messgae:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)startLocation
{
    [self.locationManager startUpdatingLocation];
    [self getAuthorization];
}
- (void)getCurrentLocation:(ResultBlock)block
{
    // 记录代码块
    self.resultBlock = block;
    
    // 获取用户位置信息
    if([CLLocationManager locationServicesEnabled])
    {
        [self getAuthorization];
        [self.locationManager startUpdatingLocation];
    }else
    {
        self.resultBlock(nil);
    }
}
#pragma -
#pragma mark  - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    
    CLLocation * location = [locations lastObject];
    CLLocationCoordinate2D coordnate = location.coordinate;
    self.longitude = coordnate.longitude; //经度
    self.latitude = coordnate.latitude;  //纬度
    NSDictionary * infoDict = @{
                            @"longitude":@(self.longitude),
                            @"latitude":@(self.latitude)
                            };
    self.resultBlock(infoDict);

    JJBLog(@"经度=%lf纬度=%lf",self.longitude,self.latitude);
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            JJBLog(@"%@",error.description);
        }
        else
        {
            if ([placemarks count]>0) {
                CLPlacemark * pm = [placemarks firstObject];
                //获取城市
                NSString * city = pm.addressDictionary[@"City"];
                NSString * subLocality = pm.addressDictionary[@"SubLocality"];
                NSString * street = pm.addressDictionary[@"Street"];
                NSString * address = [NSString stringWithFormat:@"%@%@%@",city,subLocality,street];
                
//                NSDictionary * infoDict = @{
//                                            @"city":city,
//                                            @"address":address,
//                                            @"longitude":@(self.longitude),
//                                            @"latitude":@(self.latitude)
//                                            };
//                JJBLog(@"定位的城市%@",infoDict);
                self.resultBlock(infoDict);
            }else if([placemarks count] == 0 )
            {
                [self alertOpenLocationSwitch:@"提示" messgae:@"定位城市失败"];
            }
        }
    }];
    
    
    
    [self.locationManager stopUpdatingLocation];
    
}

#pragma -
#pragma mark - getter and setter
-(CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000;//(1000米定位一次)
    }
    return _locationManager;
}
-(CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(NSString *)city
{
    if (_city == nil) {
        _city = [[NSString alloc]init];
    }
    return _city;
}

-(NSString *)address
{
    if (_address == nil) {
        _address = [[NSString alloc]init];
    }
    return _address;
}

@end
