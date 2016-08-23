//
//  MemberModel.m
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

+ (MemberModel*)JsonParse:(NSDictionary*)dic{
    MemberModel *member=[[MemberModel alloc] init];
    member.id= [dic[@"id"] integerValue];
    member.name=dic[@"name"];
    member.photo=dic[@"photo"];
    return member;
}

#pragma mark
#pragma mark-- initialization
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self != nil){
        self.id=[aDecoder decodeIntegerForKey:@"id"];
        self.name=[[aDecoder decodeObjectForKey:@"name"] copy];
        self.photo=[[aDecoder decodeObjectForKey:@"photo"] copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.id forKey:@"id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
}

@end
