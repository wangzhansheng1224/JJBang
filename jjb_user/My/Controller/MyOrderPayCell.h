//
//  MyOrderPayCell.h
//  jjb_user
//
//  Created by Check on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderPayCell : UITableViewCell

@property (nonatomic,strong) UIButton *orderPayBtn;

- (void)configWithData:(NSDictionary *)data;


@end
