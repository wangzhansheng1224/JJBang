//
//  MBImageStore.h
//  jjb_user
//
//  Created by Maybe on 16/9/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "single.h"

@interface MBImageStore : NSObject
SingleH(MBImageStore)

-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;


@end
