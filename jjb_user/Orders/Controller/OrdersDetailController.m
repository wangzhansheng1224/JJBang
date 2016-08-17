//
//  OrdersDetailController.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrdersDetailController.h"
#import "OrdersDetailCell.h"
#import "OrdersDetailHeader.h"
#import "OrdersDetailFooter.h"

@interface OrdersDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) OrdersDetailHeader *headerView;
@property (nonatomic,strong) OrdersDetailFooter *footerView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *line;

@end

@implementation OrdersDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self.view addSubview:self.tableView];
    [self.bottomView addSubview:self.payBtn];
    [self.view addSubview:self.line];
    [self.view addSubview:self.bottomView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@60);
    }];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(120, 34));
        make.right.equalTo(@-20);
        make.centerY.equalTo(_bottomView.mas_centerY);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
        make.top.equalTo(_bottomView.mas_top).with.offset(0);
    }];
}

#pragma -
#pragma mark - event respone
- (void)payBtnClick:(UIButton *)click {

    NSLog(@"============支付=============");
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    OrdersDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersDetailCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        [_tableView registerClass:[OrdersDetailCell class] forCellReuseIdentifier:@"OrdersDetailCell"];
    }
    return _tableView;
}

- (OrdersDetailHeader *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[OrdersDetailHeader alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 46))];
        _headerView.backgroundColor = COLOR_GRAY;
    }
    return _headerView;
}

- (OrdersDetailFooter *)footerView {
    
    if (!_footerView) {
        
        _footerView = [[OrdersDetailFooter alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 68))];
        _footerView.backgroundColor = COLOR_DARK_GRAY;
    }
    return _footerView;
}

- (UIView *)bottomView {

    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UIButton *)payBtn {

    if (!_payBtn) {
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _payBtn.backgroundColor = COLOR_ORANGE;
        _payBtn.layer.cornerRadius = 2.0;
        _payBtn.clipsToBounds = YES;
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (UILabel *)line {
    
    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_GRAY;
    }
    return _line;
}


@end
