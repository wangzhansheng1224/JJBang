//
//  AIFLogConfig.m
//  AIFLogTrackCenter
//
//  Created by Softwind.Tang on 14-5-15.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import "LDLoggerConfiguration.h"
#import "LDServiceFactory.h"

@implementation LDLoggerConfiguration

- (void)config {

  self.channelID = [LDAppContext sharedInstance].channelID;
  self.appKey = @"appKey";
  self.logAppName = [LDAppContext sharedInstance].appName;
  self.serviceType = kLDServiceJJBUser;
  self.sendLogMethod = @"admin.writeAppLog";
  self.sendActionMethod = @"admin.recordaction";
  self.sendLogKey = @"data";
  self.sendActionKey = @"action_note";
}

@end
