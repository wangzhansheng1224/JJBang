//
//  FamliyModel.h
//  jjb_user
//
//  Created by Aimee on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamliyModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger family_id;
@property (nonatomic,strong) NSString* family_name;
@property (nonatomic,strong) NSMutableArray* family_member;

+ (FamliyModel*)JsonParse:(NSDictionary*)dic;

@end
