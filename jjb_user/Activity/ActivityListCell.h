//
//  ActivityListCell.h
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityListCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picView;

@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *locView;

@property (nonatomic,strong) UILabel *locLabel;

@property (nonatomic,strong) UIImageView *timeView;

@property (nonatomic,strong) UILabel *timeLabel;

@end
