//
//  userModel.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "userModel.h"

@implementation UserModel


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self != nil){
        self.userID=[aDecoder decodeIntegerForKey:@"userID"];
        self.nickName=[[aDecoder decodeObjectForKey:@"nickName"] copy];
        self.phone=[[aDecoder decodeObjectForKey:@"phone"] copy];
        self.photo=[[aDecoder decodeObjectForKey:@"photo"] copy];
        self.sex=[aDecoder decodeIntegerForKey:@"sex"];
        self.signature=[[aDecoder decodeObjectForKey:@"signature"] copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeInteger:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.signature forKey:@"signature"];
    [aCoder encodeObject:self.myFamily forKey:@"myFamily"];
}

@end
