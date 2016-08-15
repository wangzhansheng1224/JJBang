//
//  OSSManager.h
//  jjb_user
//
//  Created by Aimee on 16/8/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImgModel.h"

typedef void (^OSSManagerUploadBlock)(BOOL status, NSString* alocalPathStr, NSString* aSubStr, NSString* resourceURLStr);

typedef void (^OSSManagerMutiUploadBlock)();

@interface OSSManager : NSObject
+ (instancetype)shareInstance;

- (NSString*)currentTimeByJava;

- (void)uploadFile:(ImgModel*)model withTargetSubPath:(NSString*)aSubStr withBlock:(OSSManagerUploadBlock)ossManagerUploadBlock;

- (void)uploadFiles:(NSArray*)imgArr withTargetSubPath:(NSString*)aSubStr withBlock:(OSSManagerMutiUploadBlock)ossManagerMutiUploadBlock;
@end
