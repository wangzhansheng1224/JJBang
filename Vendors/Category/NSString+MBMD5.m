//
//  NSString+MBMD5.m
//  jjb_user
//
//  Created by Maybe on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "NSString+MBMD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MBMD5)
+(NSString *)md5String:(NSString *)inputString
{
    
        const char* str = [inputString UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, strlen(str), result);
        NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
        
        for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
            [ret appendFormat:@"%02X",result];
        }    
        return ret;
    
}
@end
