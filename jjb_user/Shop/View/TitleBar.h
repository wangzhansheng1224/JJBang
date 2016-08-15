//
//  TitleBar.h
//  jjb_user
//
//  Created by Aimee on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleBar;
typedef void(^MoreButtonClickBlock)(TitleBar* sender);

@interface TitleBar : UIView
-(id) initWithTitle:(NSString*)title;
-(void) moreButtonClick:(MoreButtonClickBlock) block;
@end
