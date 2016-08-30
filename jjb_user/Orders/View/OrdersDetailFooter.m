//
//  OrdersDetailFooter.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrdersDetailFooter.h"
#import "OrdersDetailKey.h"
@interface OrdersDetailFooter ()

@property (nonatomic,strong) UILabel *label1;   //商品总额
@property (nonatomic,strong) UILabel *goodsPriceLabel;
@property (nonatomic,strong) UILabel *label2;   //打折
@property (nonatomic,strong) UILabel *discountLabel;
@property (nonatomic,strong) UILabel *label3;   //实付款
@property (nonatomic,strong) UILabel *payingLabel;
@property (nonatomic,strong) UILabel *label4;    //下单时间
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *label5;    //订单客户
@property (nonatomic,strong) UILabel *clientLabel;
@property (nonatomic,strong) UILabel *label6;    //支付人
@property (nonatomic,strong) UILabel *payerLabel;
@property (nonatomic,strong) UILabel *label7;    //为谁购买
@property (nonatomic,strong) UILabel *forLabel;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UILabel *topline;


@end

@implementation OrdersDetailFooter

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:self.label3];
        [self addSubview:self.label4];
        [self addSubview:self.goodsPriceLabel];
        [self addSubview:self.discountLabel];
        [self addSubview:self.payingLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.line];
        [self addSubview:self.topline];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(@16);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@16);
        make.top.equalTo(_label1.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(50, 14));
    }];
    [_goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@16);
        make.right.equalTo(@-16);
        make.size.mas_equalTo(CGSizeMake(100, 14));
    }];
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_goodsPriceLabel.mas_bottom).with.offset(8);
        make.right.equalTo(@-16);
        make.size.mas_equalTo(CGSizeMake(100, 14));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label2.mas_bottom).with.offset(16);
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [_payingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_line.mas_bottom).with.offset(8);
        make.right.equalTo(@-16);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_line.mas_bottom).with.offset(8);
        make.right.equalTo(_payingLabel.mas_left).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(64, 16));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_payingLabel.mas_bottom).with.offset(8);
        make.right.equalTo(@-16);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_timeLabel.mas_left).with.offset(0);
        make.centerY.equalTo(_timeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 12));
    }];
    [_topline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_goodsPriceLabel.mas_top).with.offset(-16);
        make.height.equalTo(@8);
        make.left.right.equalTo(@0);
    }];
}

- (void)configWithData:(NSDictionary *)data
{
    float price =[data[kOrdersDetailPrice] floatValue];
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"￥ %.2f",price]];
    float ZKPrice = [data[kOrdersDetailZKPrice] floatValue];
    [self.discountLabel setText:[NSString stringWithFormat:@"￥ %.2f",ZKPrice]];
    float PayPrice = [data[kOrdersDetailPayPrice] floatValue];
    [self.payingLabel setText:[NSString stringWithFormat:@"￥ %.2f",PayPrice]];
    [self.timeLabel setText:data[kOrdersDetailOrderTime]];
}

#pragma -
#pragma mark - getters and setters 
- (UILabel *)label1 {

    if (!_label1) {
        
        _label1 = [[UILabel alloc] init];
        _label1.text = @"商品总价";
        _label1.textColor = COLOR_GRAY;
        _label1.font = H4;
    }
    return _label1;
}

- (UILabel *)goodsPriceLabel {
    
    if (!_goodsPriceLabel) {
        
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.text = @"￥1080";
        _goodsPriceLabel.textColor = COLOR_ORANGE;
        _goodsPriceLabel.font = H4;
        _goodsPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _goodsPriceLabel;
}

- (UILabel *)label2 {

    if (!_label2) {
        
        _label2 = [[UILabel alloc] init];
        _label2.text = @"- 打折";
        _label2.textColor = COLOR_GRAY;
        _label2.font = H4;
    }
    return _label2;
}

- (UILabel *)discountLabel {

    if (!_discountLabel) {
        
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.text = @"￥5";
        _discountLabel.textColor = COLOR_ORANGE;
        _discountLabel.font = H4;
        _discountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _discountLabel;
}

- (UILabel *)label3 {

    if (!_label3) {
        
        _label3 = [[UILabel alloc] init];
        _label3.text = @"实付款";
        _label3.font = H3;
    }
    return _label3;
}

- (UILabel *)payingLabel {

    if (!_payingLabel) {
        
        _payingLabel = [[UILabel alloc] init];
        _payingLabel.text = @"￥1075";
        _payingLabel.textColor = COLOR_ORANGE;
        _payingLabel.font = H3;
        _payingLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payingLabel;
}

- (UILabel *)label4 {

    if (!_label4) {
        
        _label4 = [[UILabel alloc] init];
        _label4.text = @"下单时间：";
        _label4.textColor = COLOR_GRAY;
        _label4.font = H5;
    }
    return _label4;
}

- (UILabel *)timeLabel {

    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2016-08-17 16:41:07";
        _timeLabel.textColor = COLOR_GRAY;
        _timeLabel.font = H5;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)line {

    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

- (UILabel *)topline {

    if (!_topline) {
        
        _topline = [[UILabel alloc] init];
        _topline.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _topline;
}
- (UILabel *)label5 {
    
    if (!_label5) {
        
        _label5 = [[UILabel alloc] init];
        _label5.text = @"订单客户";
        _label5.font = H3;
    }
    return _label5;
}

- (UILabel *)clientLabel {
    
    if (!_clientLabel) {
        
        _clientLabel = [[UILabel alloc] init];
        _clientLabel.text = @"￥1075";
        _clientLabel.textColor = COLOR_ORANGE;
        _clientLabel.font = H3;
        _clientLabel.textAlignment = NSTextAlignmentRight;
    }
    return _clientLabel;
}
- (UILabel *)label6 {
    
    if (!_label6) {
        
        _label6 = [[UILabel alloc] init];
        _label6.text = @"支付人";
        _label6.font = H3;
    }
    return _label6;
}

- (UILabel *)payerLabel {
    
    if (!_payerLabel) {
        
        _payerLabel = [[UILabel alloc] init];
        _payerLabel.text = @"￥1075";
        _payerLabel.textColor = COLOR_ORANGE;
        _payerLabel.font = H3;
        _payerLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payerLabel;
}
- (UILabel *)label7 {
    
    if (!_label7) {
        
        _label7 = [[UILabel alloc] init];
        _label7.text = @"为谁购买";
        _label7.font = H3;
    }
    return _label7;
}

- (UILabel *)forLabel {
    
    if (!_forLabel) {
        
        _forLabel = [[UILabel alloc] init];
        _forLabel.text = @"￥1075";
        _forLabel.textColor = COLOR_ORANGE;
        _forLabel.font = H3;
        _forLabel.textAlignment = NSTextAlignmentRight;
    }
    return _forLabel;
}
@end
