//
//  GrowingCell.h
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrowingCell : UITableViewCell

@property (nonatomic,strong) UIView *view_image;

- (void)configWithData:(NSDictionary *)data;

@end
