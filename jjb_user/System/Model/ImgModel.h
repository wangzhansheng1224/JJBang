//
//  ImgModel.h
//  jjb_user
//
//  Created by Aimee on 16/8/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgModel : NSObject
@property (nonatomic, strong) NSString* imagename;
@property (nonatomic, strong) NSString* imgpath;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic,assign) Boolean status;
@end
