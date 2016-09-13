//
//  MemberModel.h
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* photo;
@property (nonatomic,assign) NSInteger role;

+ (MemberModel*)JsonParse:(NSDictionary*)dic;
@end
