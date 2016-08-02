//
//  MBAdItem.h
//  jjb_user
//
//  Created by Maybe on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBAdItem : NSObject
/**
 *  图片地址
 */
@property(nonatomic,strong) NSString * pictureUrl;
/**
 *  点击广告跳转的界面
 */
@property(nonatomic,strong) NSString * targetUrl;
/**
 *  图片的宽度
 */
@property(nonatomic,assign) CGFloat * pWeight;
/**
 *  图片的高度
 */
@property(nonatomic,assign) CGFloat * pHeight;
@end
