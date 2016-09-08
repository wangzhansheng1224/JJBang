//
//  TeacherDetailCell.h
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backHeightBlock)(CGFloat height);
@interface TeacherDetailCell : UITableViewCell
- (void)configWithData:(NSDictionary *)data block:(backHeightBlock)backBlock;
@end
