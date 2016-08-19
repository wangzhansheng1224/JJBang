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
#import "GoodsDetailCell.h"
#import "GoodsParameterCell.h"
#import "GoodsDetailAPIManager.h"
#import "GoodsDetailReformer.h"
#import "OrdersDetailController.h"
#import "MakeOrderBar.h"
#import "GoodsDetailKey.h"

@interface GoodsDetailController ()<UITableViewDataSource,UITableViewDelegate,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) GoodsDetailHeader *headerView;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MakeOrderBar *makeOrderBar;
@property (nonatomic,strong) LDAPIBaseManager *detailAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> GoodsDetailReformer;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSDictionary *dataDic;

@end

@implementation GoodsDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.makeOrderBar];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
    [self.detailAPIManager loadData];
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
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];
    [_makeOrderBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.bottom.equalTo(@0);
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
        GoodsDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailCell" forIndexPath:indexPath];
        [cell configWithData:self.dataDic];
        return cell;
    }else {
        GoodsParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsParameterCell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 32;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.tabbarControl;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[GoodsDetailAPIManager class]]) {
        self.dataDic=[manager fetchDataWithReformer:self.GoodsDetailReformer];
        [self.headerView configWithData:self.dataDic];
        [self.makeOrderBar configWithData:@{@"shopID":@1,@"OrderType":@0,@"objectID":_dataDic[kGoodsDetailID],@"price":_dataDic[kGoodsDetailPrice]}];
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
        return @{@"goods_id":@(self.goodsID)};
    }
    return @{};
}




#pragma -
#pragma mark - getters and setters
- (GoodsDetailHeader *)headerView {
    if (!_headerView) {
        _headerView = [[GoodsDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*2.0f/3.0f+50)];
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
        [_tableView registerClass:[GoodsDetailCell class] forCellReuseIdentifier:@"GoodsDetailCell"];
    }
    return _tableView;
}

- (MakeOrderBar *)makeOrderBar {

    if (!_makeOrderBar) {
        
        _makeOrderBar = [[MakeOrderBar alloc] init];
        _makeOrderBar.backgroundColor=COLOR_WHITE;
    }
    return _makeOrderBar;
}



- (LDAPIBaseManager *)detailAPIManager {
    if (_detailAPIManager == nil) {
        _detailAPIManager = [GoodsDetailAPIManager  sharedInstance];
        _detailAPIManager.delegate=self;
        _detailAPIManager.paramSource=self;
    }
    return _detailAPIManager;
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

- (NSDictionary *)dataDic {

    if (!_dataDic) {
        
        _dataDic = [[NSDictionary alloc] init];
    }
    return _dataDic;
}

@end