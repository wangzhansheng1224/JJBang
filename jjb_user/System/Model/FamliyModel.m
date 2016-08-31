//
//  FamliyModel.m
//  jjb_user
//
//  Created by Aimee on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "FamliyModel.h"
#import "MemberModel.h"

@implementation FamliyModel

+ (FamliyModel*)JsonParse:(NSDictionary*)dic{
    FamliyModel *famliy=[[FamliyModel alloc] init];
    famliy.family_id= [dic[@"family_id"] integerValue];
    famliy.family_name=dic[@"family_name"];
    famliy.family_member=[[NSMutableArray alloc] init];
    NSArray *myFamliy=dic[@"familyMember"];
    for (NSDictionary *dic in myFamliy) {
        [famliy.family_member addObject:[MemberModel JsonParse:dic]];
    }
    return famliy;
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
        self.family_id=[aDecoder decodeIntegerForKey:@"family_id"];
        self.family_name=[[aDecoder decodeObjectForKey:@"family_name"] copy];
        self.family_member=[[aDecoder decodeObjectForKey:@"family_member"] copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.family_id forKey:@"family_id"];
    [aCoder encodeObject:self.family_name forKey:@"family_name"];
    [aCoder encodeObject:self.family_member forKey:@"family_member"];
}

@end
