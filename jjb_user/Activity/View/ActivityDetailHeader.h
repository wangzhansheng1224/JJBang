//
//  ActivityDetailHeader.h
//  jjb_user
//
//  Created by Aimee on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ActivityDetailHeader : UIView

@property (nonatomic, assign) BOOL invalidate;

- (void)configWithData:(NSDictionary *)data;
@end
