//
//  userModel.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "userModel.h"
#import "PathHelper.h"

static UserModel* currentUser;

@implementation UserModel

#pragma mark -
#pragma mark Private Method
+ (NSString*)getStoragePath
{
    NSString* filePath = [[PathHelper documentDirectoryPathWithName:@"User"]
                          stringByAppendingPathComponent:@"accounts"];
    return filePath;
}

+ (void)load
{
    NSString* filePath = [self getStoragePath];
    currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (void)save:(UserModel*)user
{
    NSString* filePath = [self getStoragePath];
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
    [self load];
}

#pragma mark -
#pragma mark 公共方法

+ (void)removeUser
{
    if (currentUser) {
        currentUser = nil;
        [self save:currentUser];
    }
}

+ (BOOL)isHasLogin
{
    [self load];
    if (currentUser && currentUser.userID) {
        return YES;
    }
    else {
        return NO;
    }
}
+ (UserModel*)currentUser
{
    [self load];
    return currentUser;
}

+ (UserModel*)JsonParse:(NSDictionary*)dic{
    UserModel *user=[[UserModel alloc] init];
    user.userID= ([dic objectForKey:@"id"] != [NSNull null]) && ([dic objectForKey:@"id"] != nil) ? [[dic objectForKey:@"id"] integerValue] : 0;
    user.nickName=([dic objectForKey:@"nickName"] != [NSNull null]) && ([dic objectForKey:@"nickName"] != nil) ? [dic objectForKey:@"nickName"] : @"";
    user.phone=([dic objectForKey:@"phone"] != [NSNull null]) && ([dic objectForKey:@"phone"] != nil) ? [dic objectForKey:@"phone"] : @"";
    user.sex=([dic objectForKey:@"sex"] != [NSNull null]) && ([dic objectForKey:@"sex"] != nil) ? [[dic objectForKey:@"sex"] integerValue] : 0;
    user.photo=([dic objectForKey:@"photo"] != [NSNull null]) && ([dic objectForKey:@"photo"] != nil) ? [dic objectForKey:@"photo"] : @"";
    user.signature=([dic objectForKey:@"signature"] != [NSNull null]) && ([dic objectForKey:@"signature"] != nil) ? [dic objectForKey:@"signature"] : @"";
    return user;
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
