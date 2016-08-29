//
//  MyOrderPayCell.m
//  jjb_user
//
//  Created by Check on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderPayCell.h"
#import "MyOrderPayKey.h"
#import "OrdersDetailController.h"

@interface MyOrderPayCell ()

@property (nonatomic,strong) UILabel *orderNo;
@property (nonatomic,strong) UIImageView *orderImageV;
@property (nonatomic,strong) UILabel *orderTitleLabel;
@property (nonatomic,strong) UILabel *orderPriceLabel;
@property (nonatomic,strong) UILabel *orderTimeLabel;
@property (nonatomic,strong) UILabel *orderStatusLabel;
//@property (nonatomic,strong) UIButton *orderPayBtn;
@property (nonatomic,strong) UILabel *topLine;
@property (nonatomic,strong) UILabel *bottomLine;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,copy) NSString *orderId;

@end

@implementation MyOrderPayCell

#pragma
#pragma mark - lefe cycle

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.orderNo];
        [self.contentView addSubview:self.orderStatusLabel];
        [self.contentView addSubview:self.topLine];
        [self.contentView addSubview:self.orderImageV];
        [self.contentView addSubview:self.orderTitleLabel];
        [self.contentView addSubview:self.orderPriceLabel];
        [self.contentView addSubview:self.orderTimeLabel];
        [self.contentView addSubview:self.bottomLine];
        [self.contentView addSubview:self.orderPayBtn];
        [self.contentView addSubview:self.line];
        [self addSubviewConstraint];
    }
    return self;
}

#pragma
#pragma mark - private methods
-(void)addSubviewConstraint
{
    [self.orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.mas_equalTo(_orderStatusLabel.mas_left);
        make.height.mas_equalTo(14);
        
    }];
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderNo.mas_centerY);
        make.right.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(80, 14));
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNo.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@1);
        make.left.right.equalTo(@0);
    }];
    [self.orderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.topLine.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2.0,Screen_Width/3.0));
    }];
    [self.orderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLine.mas_bottom).offset(20);
        make.left.equalTo(_orderImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@17);
    }];
    [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderTitleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(_orderImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@14);
    }];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderPriceLabel.mas_bottom).with.offset(10);
        make.left.equalTo(_orderImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@14);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderTimeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(_orderImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@1);
    }];
    [self.orderPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom).with.offset(10);
        make.right.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderImageV.mas_bottom).with.offset(10);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(@1);
    }];
}

#pragma -
#pragma mark - private methods
- (void)configWithData:(NSDictionary *)data
{
    
    self.orderId = data[kMyOrderPayId];
    NSLog(@"%@+++",data);
    NSNumber * type = data[kMyOrderPayOrderStatus];
    if ([type intValue] == 0) {
        self.orderPayBtn.userInteractionEnabled = YES;
        _orderPayBtn.backgroundColor = COLOR_ORANGE;
        [_orderPayBtn setTitle:@"待付款" forState:UIControlStateNormal];
    }else if ([type intValue] == 1) {
        self.orderPayBtn.userInteractionEnabled = NO;
        _orderPayBtn.backgroundColor = COLOR_GRAY;
        [_orderPayBtn setTitle:@"已付款" forState:UIControlStateNormal];
    }else if ([type intValue] == 2) {
        self.orderPayBtn.userInteractionEnabled = NO;
        _orderPayBtn.backgroundColor = COLOR_GRAY;
        [_orderPayBtn setTitle:@"已退款" forState:UIControlStateNormal];
    }
    self.orderNo.text = [NSString stringWithFormat:@"订单号 %@",data[kMyOrderPayOrderNo]];
//    self.orderStatusLabel.text = data[kMyOrderPayOrderStatus];
    [self.orderImageV sd_setImageWithURL:[NSURL initWithImageURL:data[kMyOrderPayOrderImage] Width:Screen_Width/2.0 Height:Screen_Width/3.0]  placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.orderTitleLabel.text = data[kMyOrderPayOrderName];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"￥%@",data[kMyOrderPayOrderPrice]];
    self.orderTimeLabel.text = data[kMyOrderPayOrderCTime];
}

#pragma -
#pragma mark - event respond
- (void)orderPayBtnClick {

    [self makeToastActivity:CSToastPositionCenter];
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
    if (controller==nil) {
        OrdersDetailController *detail = [[OrdersDetailController alloc] init];
        detail.orderNo = self.orderId;
        [navController pushViewController:detail animated:YES];
    } else{
        [navController pushViewController:controller animated:YES];
    }
    [self hideToastActivity];
}

#pragma
#pragma mark - getter and setter
- (UILabel *)orderNo {
    if (!_orderNo) {
        _orderNo = [[UILabel alloc] init];
        _orderNo.text = @"订单号 2020202020202";
        _orderNo.textColor = COLOR_GRAY;
        _orderNo.font = H3;
    }
    return _orderNo;
}
- (UILabel *)orderStatusLabel {
    if (!_orderStatusLabel) {
        _orderStatusLabel = [[UILabel alloc] init];
        _orderStatusLabel.text = @"报名成功";
        _orderStatusLabel.textAlignment = NSTextAlignmentRight;
        _orderStatusLabel.textColor = COLOR_ORANGE;
        _orderStatusLabel.font = H3;
    }
    return _orderStatusLabel;
}
- (UILabel *)topLine {

    if (!_topLine) {
        _topLine = [[UILabel alloc] init];
        _topLine.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _topLine;
}
- (UIImageView *)orderImageV
{
    if (!_orderImageV) {
        _orderImageV = [[UIImageView alloc]init];
        _orderImageV.image = [UIImage imageNamed:@"img_default"];
    }
    return _orderImageV;
}
- (UILabel *)orderTitleLabel {
    if (!_orderTitleLabel) {
        _orderTitleLabel = [[UILabel alloc] init];
        _orderTitleLabel.text = @"少儿美术";
        _orderTitleLabel.textColor = COLOR_DARK_GRAY;
        _orderTitleLabel.font = H2;
    }
    return _orderTitleLabel;
}
- (UILabel *)orderPriceLabel {
    if (!_orderPriceLabel) {
        _orderPriceLabel = [[UILabel alloc] init];
        _orderPriceLabel.text = @"￥3000";
        _orderPriceLabel.textColor = COLOR_ORANGE;
        _orderPriceLabel.font = H3;
    }
    return _orderPriceLabel;
}
- (UILabel *)orderTimeLabel {
    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.text = @"2016-08-25 14:39:21";
        _orderTimeLabel.textColor = COLOR_GRAY;
        _orderTimeLabel.font = H4;
    }
    return _orderTimeLabel;
}
- (UILabel *)bottomLine {
    
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _bottomLine;
}
- (UIButton *)orderPayBtn {
    if (!_orderPayBtn) {
        _orderPayBtn = [[UIButton alloc] init];
        _orderPayBtn.layer.cornerRadius = 3.0;
        _orderPayBtn.clipsToBounds = YES;
        [_orderPayBtn addTarget:self action:@selector(orderPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderPayBtn;
}
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

@end