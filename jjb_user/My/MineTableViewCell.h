//
//  MineTableViewCell.h
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"

@interface MineTableViewCell : UITableViewCell


- (void)refreshCellWithModel:(MineModel *)model;

@end
