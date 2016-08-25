//
//  ShopModel.h
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger shopID;
@property (nonatomic,strong) NSString* shopName;

+ (ShopModel*)JsonParse:(NSDictionary*)dic;
+ (ShopModel *)currentShop;
+ (void)save:(ShopModel *)shop;
@end
