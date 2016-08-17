//
//  OrdersDetailHeader.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrdersDetailHeader.h"

@interface OrdersDetailHeader ()

@property (nonatomic,strong) UILabel *ordersNumLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@end

@implementation OrdersDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.ordersNumLabel];
        [self addSubview:self.statusLabel];
        
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_ordersNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0, 14));
        make.left.equalTo(@16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 14));
        make.right.equalTo(@-16);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)ordersNumLabel {

    if (!_ordersNumLabel) {
        
        _ordersNumLabel = [[UILabel alloc] init];
        _ordersNumLabel.text = @"订单编号：201506072921";
        _ordersNumLabel.font = H4;
    }
    return _ordersNumLabel;
}

- (UILabel *)statusLabel {

    if (!_statusLabel) {
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"未支付";
        _statusLabel.font = H4;
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = COLOR_ORANGE;
    }
    return _statusLabel;
}

@end
