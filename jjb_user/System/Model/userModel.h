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
@property (nonatomic,assign) double balance;//余额
@property (nonatomic,assign) NSInteger level;//等级
@property (nonatomic,assign) double totalBalance;//总充值钱数
@property (nonatomic,assign) double nextBalance;//距离下一级，还需要充值多少钱
@property (nonatomic,assign) double discount;//当前优惠
@property (nonatomic,assign) double nextDiscount; //下一级优惠
@property (nonatomic,strong) NSMutableArray* myFamily;


+ (UserModel *)currentUser;
+ (void)save:(UserModel *)user;
+ (void)removeUser;
+(BOOL) isHasLogin;
+ (UserModel*)JsonParse:(NSDictionary*)dic;
@end
