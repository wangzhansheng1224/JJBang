//
//  CTMediator+CTMediatorVideos.m
//  
//
//  Created by tongtong on 16/8/28.
//
//

#import "CTMediator+CTMediatorVideos.h"

@implementation CTMediator (CTMediatorVideos)
NSString * const kCTMediatorVideosTarget = @"Videos";
NSString * const kCTMediatorActionNativeVideosDetail = @"VideosDetail";
NSString * const kCTMediatorActionNativeVideosList = @"VideosList";

- (UIViewController *)CTMediator_VideosDetail:(NSDictionary *)params{
    return [self performTarget:kCTMediatorVideosTarget
                        action:kCTMediatorActionNativeVideosDetail
                        params:params];
}

- (UIViewController *)CTMediator_VideosList:(NSDictionary *)params{
    return [self performTarget:kCTMediatorVideosTarget
                        action:kCTMediatorActionNativeVideosList
                        params:params];
}

@end
