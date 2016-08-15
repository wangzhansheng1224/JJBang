//
//  OSSManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OSSManager.h"
#import <AliyunOSSiOS/OSSService.h>
#import "ImgModel.h"


#define OSSBucketName @"jiajiabang"
#define OSSAccessKey @"ukZxh4uCD6VWvwd2"
#define OSSScrectKey @"H6NsydEk5SJUXb3pWYyj48etiWUgeq"
@interface OSSManager()
@property (nonatomic,strong) OSSClient* client;
@end

static OSSManager* ossManager;
@implementation OSSManager
#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype)shareInstance
{
    static dispatch_once_t OSSManager;
    dispatch_once(&OSSManager, ^{
        ossManager = [[self alloc] init];
    });
    return ossManager;
}

-(instancetype) init
{
    self=[super init];
    if (self) {
        NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
        // 由阿里云颁发的AccessKeyId/AccessKeySecret构造一个CredentialProvider。
        // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的访问控制章节。
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:OSSAccessKey secretKey:OSSScrectKey];
        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    }
    return self;
}


- (NSString*)currentTimeByJava
{
    NSDate* date = [NSDate date];
    
    NSTimeInterval aInterval = [date timeIntervalSince1970];
    
    long long java = (long long)(aInterval * 1000);
    
    return [NSString stringWithFormat:@"%lld", java];
}

- (void)uploadFile:(ImgModel*) model withTargetSubPath:(NSString*)aSubStr withBlock:(OSSManagerUploadBlock)ossManagerUploadBlock{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    NSString* fileType = [model.imgpath pathExtension];
    NSDate* now = [NSDate date];
    NSString* targetStr = [NSString stringWithFormat:@"%@/%ld/%ld/%@.%@", aSubStr, (long)[now year], (long)[now month], [self currentTimeByJava], fileType];
    // required fields
    put.bucketName = OSSBucketName;
    put.objectKey = targetStr;
    put.uploadingFileURL = [NSURL fileURLWithPath:model.imgpath];
    
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    put.contentType = fileType;
    put.contentMd5 = @"";
    put.contentEncoding = @"";
    put.contentDisposition = @"";
    put.callbackParam=@{};
    
    OSSTask * putTask = [_client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            ossManagerUploadBlock(YES, model.imgpath, aSubStr, put.objectKey);
        } else {
            ossManagerUploadBlock(NO, model.imgpath, aSubStr, put.objectKey);
        }
        return nil;
    }];
}

- (void)uploadFiles:(NSArray*)imgArr withTargetSubPath:(NSString*)aSubStr withBlock:(OSSManagerMutiUploadBlock)ossManagerMutiUploadBlock
{
    __block NSInteger imgCount = 0;
    
    NSLock *theLock = [[NSLock alloc] init];
    for (ImgModel* model in imgArr) {
        [theLock lock];
        [self uploadFile:model
       withTargetSubPath:aSubStr
               withBlock:^(BOOL status, NSString* alocalPathStr, NSString* aSubStr, NSString* resourceURLStr) {
                   [theLock unlock];
                   imgCount++;
                   model.status=status;
                   model.imagename = resourceURLStr;
                   if (imgCount == [imgArr count]) {
                       ossManagerMutiUploadBlock();
                   }

               }];
    }
}


@end
