//
//  OrdersDetailHeader.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrdersDetailHeader.h"
#import "OrdersDetailKey.h"
@interface OrdersDetailHeader ()

@property (nonatomic,strong) UILabel *ordersNumLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation OrdersDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.ordersNumLabel];
        [self addSubview:self.statusLabel];
        [self addSubview:self.line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_ordersNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(250, 16));
        make.left.equalTo(@16);
        make.top.equalTo(@16);
    }];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 14));
        make.right.equalTo(@-16);
        make.top.equalTo(@16);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@8);
        make.left.right.equalTo(@0);
        make.top.equalTo(_ordersNumLabel.mas_bottom).with.offset(16);
    }];
}

- (void)configWithData:(NSDictionary *)data
{
//    [self.ordersNumLabel setText:data[@"kOrdersDetailOrderNO"]];
    self.ordersNumLabel.text = data[kOrdersDetailOrderNO];
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)ordersNumLabel {

    if (!_ordersNumLabel) {
        
        _ordersNumLabel = [[UILabel alloc] init];
        _ordersNumLabel.text = @"订单编号：201506072921";
        _ordersNumLabel.font = H4;
        _ordersNumLabel.textColor = COLOR_GRAY;
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

- (UILabel *)line {

    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

@end
