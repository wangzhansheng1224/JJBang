//
//  MineHeaderView.h
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface MineHeaderView : UIView
- (void)configWithData:(UserModel *)model;
@property (nonatomic,strong) UIImageView * itemImage;

@end
