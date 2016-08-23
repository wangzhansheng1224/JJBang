//
//  userModel.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UserModel.h"
#import "PathHelper.h"
#import "MemberModel.h"

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
    user.userID= [dic[@"id"] integerValue];
    user.nickName=dic[@"nickName"];
    user.phone=dic[@"phone"];
    user.sex=[dic[@"sex"] integerValue];
    user.photo=dic[@"photo"];
    user.signature=dic[@"signature"];
    user.balance=[dic[@"balance"] doubleValue];
    user.level=[dic[@"level"] integerValue];
    user.totalBalance=[dic[@"totalBalance"] doubleValue];
    user.nextBalance=[dic[@"nextBalance"] doubleValue];
    user.discount=[dic[@"discount"] doubleValue];
    user.nextDiscount=[dic[@"nextDiscount"] doubleValue];
    user.myFamily=[[NSMutableArray alloc] init];
    NSArray *myFamliy=dic[@"myFamily"];
    for (NSDictionary *dic in myFamliy) {
        [user.myFamily addObject:[MemberModel JsonParse:dic]];
    }
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
        self.myFamily=[[aDecoder decodeObjectForKey:@"myFamily"] copy];
        self.balance=[aDecoder decodeDoubleForKey:@"balance"];
        self.level=[aDecoder decodeIntegerForKey:@"level"];
        self.totalBalance=[aDecoder decodeDoubleForKey:@"totalBalance"];
        self.nextBalance=[aDecoder decodeDoubleForKey:@"nextBalance"];
        self.discount=[aDecoder decodeDoubleForKey:@"discount"];
        self.nextDiscount=[aDecoder decodeDoubleForKey:@"nextDiscount"];
    
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
    [aCoder encodeDouble:self.balance forKey:@"balance"];
    [aCoder encodeInteger:self.level forKey:@"level"];
    [aCoder encodeDouble:self.balance forKey:@"totalBalance"];
    [aCoder encodeDouble:self.balance forKey:@"nextBalance"];
    [aCoder encodeDouble:self.balance forKey:@"discount"];
    [aCoder encodeDouble:self.balance forKey:@"nextDiscount"];
}

@end
