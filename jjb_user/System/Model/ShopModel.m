//
//  ShopModel.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopModel.h"
#import "PathHelper.h"

static ShopModel* currentShop;
@implementation ShopModel

+ (ShopModel*)JsonParse:(NSDictionary*)dic{
    ShopModel *shop=[[ShopModel alloc] init];
    shop.shopID= [dic[@"id"] integerValue];
    shop.shopName=dic[@"name"];
    return shop;
}

#pragma mark -
#pragma mark Private Method
+ (NSString*)getStoragePath
{
    NSString* filePath = [[PathHelper documentDirectoryPathWithName:@"Shop"]
                          stringByAppendingPathComponent:@"CurrentShop"];
    return filePath;
}

+ (void)load
{
    NSString* filePath = [self getStoragePath];
    currentShop = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (void)save:(ShopModel*)shop
{
    NSString* filePath = [self getStoragePath];
    [NSKeyedArchiver archiveRootObject:shop toFile:filePath];
    [self load];
}

+ (ShopModel*)currentShop
{
    if (!currentShop) {
        [self load];
    }
    return currentShop;
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
        self.shopID=[aDecoder decodeIntegerForKey:@"shopID"];
        self.shopName=[[aDecoder decodeObjectForKey:@"shopName"] copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.shopID forKey:@"shopID"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
}

@end
