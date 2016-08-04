//
//  otherButtonModel.m
//  jjb_user
//
//  Created by Maybe on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "otherButtonModel.h"

@implementation otherButtonModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.imageName = dict[@"imageName"];
        self.actionString = dict[@"actionSting"];
    }
    return self;
}


+(instancetype)memberWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
