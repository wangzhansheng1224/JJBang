//
//  ClerkDetailCell.h
//  jjb_user
//
//  Created by Maybe on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^backHeightBlock)(CGFloat height);
@interface ClerkDetailCell : UITableViewCell
-(void)configWithNoteData:(NSDictionary *)data block:(backHeightBlock)backBlock;
@end
