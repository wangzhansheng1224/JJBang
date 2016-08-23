//
//  userModel.h
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger userID;
@property (nonatomic,strong) NSString* nickName;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,strong) NSString* photo;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,strong) NSString* signature;
@property (nonatomic,strong) NSString* balance;
@property (nonatomic,strong) NSString* totalBalance;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,strong) NSArray* myFamily;


+ (UserModel *)currentUser;
+ (void)save:(UserModel *)user;
+ (void)removeUser;
+(BOOL) isHasLogin;
+ (UserModel*)JsonParse:(NSDictionary*)dic;
@end
