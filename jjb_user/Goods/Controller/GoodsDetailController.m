//
//  GoodsDetailController.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsDetailController.h"
#import "HMSegmentedControl.h"
#import "GoodsDetailHeader.h"
#import "ActivityDetailCell.h"
#import "GoodsParameterCell.h"
#import "GoodsDetailAPIManager.h"
#import "GoodsDetailReformer.h"
#import "OrdersDetailController.h"

@interface GoodsDetailController ()<UITableViewDataSource,UITableViewDelegate,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) GoodsDetailHeader *headerView;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) LDAPIBaseManager *GoodsDetailAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> GoodsDetailReformer;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableDictionary *dataDic;

@end

@implementation GoodsDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.line];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.priceLabel];
    [self.bottomView addSubview:self.payBtn];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
        
        make.height.equalTo(@60);
        make.left.right.bottom.equalTo(@0);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.left.equalTo(@20);
        make.centerY.equalTo(_bottomView.mas_centerY);
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
- (void)tabbarControllChangeValue:(HMSegmentedControl *)change {

    
}

- (void)payBtnClick:(UIButton *)click {

    OrdersDetailController *orderDetail = [[OrdersDetailController alloc] init];
    [self.navigationController pushViewController:orderDetail animated:YES];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        return 1;
    }else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_tabbarControl.selectedSegmentIndex == 0) {
        //商品详情
        ActivityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailCell" forIndexPath:indexPath];
        return cell;
    }else {
        GoodsParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsParameterCell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_tabbarControl.selectedSegmentIndex == 0) {
        return Screen_Height - 304;
    }else {
        return 64;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.tabbarControl;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[GoodsDetailAPIManager class]]) {
        self.dataDic=[manager fetchDataWithReformer:self.GoodsDetailReformer];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[GoodsDetailAPIManager class]]) {
        return @{};
    }
    else{
        return @{};
    }
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
//- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
//    
//}

#pragma -
#pragma mark - getters and setters
- (GoodsDetailHeader *)headerView {
    if (!_headerView) {
        _headerView = [[GoodsDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 260)];
        _headerView.backgroundColor=COLOR_WHITE;
    }
    return _headerView;
}

- (HMSegmentedControl *)tabbarControl {
    
    if (!_tabbarControl) {
        _tabbarControl=[[HMSegmentedControl alloc] initWithSectionTitles:@[@"商品详情",@"商品参数"]];
        _tabbarControl.selectionIndicatorColor=COLOR_ORANGE;
        _tabbarControl.titleTextAttributes=@{NSForegroundColorAttributeName:COLOR_GRAY,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation=HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight=2.0f;
        [_tabbarControl addTarget:self action:@selector(tabbarControllChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabbarControl;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[GoodsParameterCell class] forCellReuseIdentifier:@"GoodsParameterCell"];
        [_tableView registerClass:[ActivityDetailCell class] forCellReuseIdentifier:@"ActivityDetailCell"];
    }
    return _tableView;
}

- (UIView *)bottomView {

    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UILabel *)priceLabel {

    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = COLOR_ORANGE;
        _priceLabel.font = H1;
        _priceLabel.text = @"￥128";
    }
    return _priceLabel;
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

- (LDAPIBaseManager *)GoodsDetailAPIManager {
    if (_GoodsDetailAPIManager == nil) {
        _GoodsDetailAPIManager = [GoodsDetailAPIManager  sharedInstance];
        _GoodsDetailAPIManager.delegate=self;
        _GoodsDetailAPIManager.paramSource=self;
    }
    return _GoodsDetailAPIManager;
}

- (id<ReformerProtocol>) GoodsDetailReformer{
    
    if (!_GoodsDetailReformer) {
        _GoodsDetailReformer=[[GoodsDetailReformer alloc] init];
    }
    return _GoodsDetailReformer;
}

- (NSMutableArray *)dataArr {

    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableDictionary *)dataDic {

    if (!_dataDic) {
        
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return _dataDic;
}

@end