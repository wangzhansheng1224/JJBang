//
//  ServiceFactory.h
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDService.h"

@interface LDServiceFactory : NSObject
+ (instancetype)sharedInstance;
- (LDService<LDServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
