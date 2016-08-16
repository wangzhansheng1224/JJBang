//
//  RechargeWeChatAndAliView.h
//  jjb_user
//
//  Created by Maybe on 16/8/11.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RechargeWeChatAndAliCell;
typedef void (^SelectButtonBlock)(RechargeWeChatAndAliCell * sender);
@interface RechargeWeChatAndAliCell : UIView
-(instancetype)initWithImage:(UIImage *)iconImage title:(NSString *)title;
-(void)selectButton:(SelectButtonBlock)block;


@end
