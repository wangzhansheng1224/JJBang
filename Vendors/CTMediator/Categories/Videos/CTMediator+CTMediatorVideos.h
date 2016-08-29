//
//  CTMediator+CTMediatorVideos.h
//  
//
//  Created by tongtong on 16/8/28.
//
//

#import "CTMediator.h"

@interface CTMediator (CTMediatorVideos)
- (UIViewController *)CTMediator_VideosDetail:(NSDictionary *)params;
- (UIViewController *)CTMediator_VideosList:(NSDictionary *)params;

@end
