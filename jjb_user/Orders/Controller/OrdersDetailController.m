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
@property (nonatomic,strong) UIView *sectionView;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UIImageView *arrowImageV;

@end

@implementation OrdersDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"订单详情";
    [self.view addSubview:self.tableView];
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.line];
    [self.view addSubview:self.bottomView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.sectionView addSubview:self.locationLabel];
    [self.sectionView addSubview:self.arrowImageV];
    [self layoutPageSubviews];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
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
        make.top.equalTo(@0);
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 16));
        make.top.equalTo(@8);
        make.left.equalTo(@16);
    }];
    [_arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.top.equalTo(@8);
        make.right.equalTo(@-16);
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

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    OrdersDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersDetailCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[OrdersDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrdersDetailCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 95;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 32;
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
        [_tableView registerClass:[OrdersDetailCell class] forCellReuseIdentifier:@"OrdersDetailCell"];
    }
    return _tableView;
}

- (OrdersDetailHeader *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[OrdersDetailHeader alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 54))];
        _headerView.backgroundColor = COLOR_WHITE;
    }
    return _headerView;
}

- (OrdersDetailFooter *)footerView {
    
    if (!_footerView) {
        
        _footerView = [[OrdersDetailFooter alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 68))];
        _footerView.backgroundColor = COLOR_WHITE;
    }
    return _footerView;
}

- (UIView *)bottomView {

    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = COLOR_WHITE;
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

- (UIView *)sectionView {

    if (!_sectionView) {
        
        _sectionView = [[UIView alloc] init];
        _sectionView.backgroundColor = COLOR_WHITE;
    }
    return _sectionView;
}

- (UILabel *)locationLabel {

    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.text = @"望京店";
        _locationLabel.textColor = COLOR_GRAY;
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.font = H3;
    }
    return _locationLabel;
}

- (UIImageView *)arrowImageV {

    if (!_arrowImageV) {
        
        _arrowImageV = [[UIImageView alloc] init];
        _arrowImageV.backgroundColor = JJBRandomColor;
    }
    return _arrowImageV;
}

@end