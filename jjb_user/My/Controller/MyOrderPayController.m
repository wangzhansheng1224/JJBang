//
//  MyOrderPayController.m
//  jjb_user
//
//  Created by Check on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderPayController.h"
#import "MyOrderPayCell.h"
#import "MyOrderPayReformer.h"
#import "MyOrderAPIManager.h"

@interface MyOrderPayController () <UITableViewDataSource, UITableViewDelegate,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) MyOrderAPIManager *myOrderPayAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> myOrderPayReformer;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,assign) int index;
@property (nonatomic,strong) NSArray * arr_title;
@property (nonatomic,strong) NSMutableArray * arr_button;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MyOrderPayController
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageSize=10;
    self.pageIndex=0;
    [self.view addSubview:self.tableView];
    [self createHeaderViewButton];
    [self layoutPageSubviews];
    [self.myOrderPayAPIManager loadData];
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.left.equalTo(@0);
    }];
}

- (void)createHeaderViewButton {
    for (int i = 0; i < self.arr_title.count; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * Screen_Width/4.0, 0, Screen_Width/4.0, 50)];
        button.tag = 2000 + i;
        [button setTitle:self.arr_title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_ORANGE forState:UIControlStateSelected];
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
        [self.arr_button addObject:button];
    }
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView addSubview:self.line];
}

#pragma -
#pragma mark - 点击事件
- (void)titleBtnClick:(UIButton *)button {
    
    NSLog(@"-------");
    self.index = (int)button.tag - 2000;
    for (int i = 0; i < self.arr_button.count; i++) {
        UIButton * btn = (UIButton *)self.arr_button[i];
        if (self.index == i) {
            btn.selected = YES;
        }else {
            btn.selected = NO;
        }
    }
    NSLog(@"%d",self.index);
    float contentOffset = self.index * Screen_Width / self.arr_title.count;
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(contentOffset, 48, Screen_Width/4.0, 2);
    }];
    [self.dataArr removeAllObjects];
    self.pageIndex=0;
    [self.myOrderPayAPIManager loadData];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyOrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderPayCellIdentifier"];
    if (!cell) {
        cell = [[MyOrderPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyOrderPayCellIdentifier"];
    }
    [cell configWithData:self.dataArr[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 56 + Screen_Width/3.0;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.myOrderPayReformer];
    NSLog(@"%@+++++",resultData);
    [self.dataArr addObjectsFromArray:resultData];
    self.pageIndex=[self.dataArr count];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
     if ([manager isKindOfClass:[MyOrderAPIManager class]]) {
    self.myOrderPayAPIManager.methodName=[NSString stringWithFormat:@"gateway/orderList/%d/%@/%@/%@",self.index,@([UserModel currentUser].userID),@(self.pageIndex),@(self.pageSize)];
     }
    return nil;
}

#pragma -
#pragma mark - getters and setters
- (MyOrderAPIManager *)myOrderPayAPIManager {
    if (_myOrderPayAPIManager == nil) {
        _myOrderPayAPIManager = [MyOrderAPIManager  sharedInstance];
        _myOrderPayAPIManager.delegate=self;
        _myOrderPayAPIManager.paramSource=self;
    }
    return _myOrderPayAPIManager;
}
- (id<ReformerProtocol>)myOrderPayReformer {
    
    if (!_myOrderPayReformer) {
        _myOrderPayReformer=[[MyOrderPayReformer alloc] init];
    }
    return _myOrderPayReformer;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[MyOrderPayCell class] forCellReuseIdentifier:@"MyOrderPayCellIdentifier"];
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArr removeAllObjects];
            self.pageIndex=0;
            [self.myOrderPayAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.myOrderPayAPIManager loadData];
        }];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44.0;
    }
    return _tableView;
}
- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
    }
    return _headerView;
}
- (UILabel *)line {
    
    if (!_line) {
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, Screen_Width/4.0, 2)];
        _line.backgroundColor = COLOR_ORANGE;
    }
    return _line;
}
- (NSArray *)arr_title {
    
    if (!_arr_title) {
        _arr_title = [[NSArray alloc] initWithObjects:@"待付款", @"已付款", @"退款", @"全部订单", nil];
    }
    return _arr_title;
}
- (NSMutableArray *)arr_button {
    
    if (!_arr_button) {
        _arr_button = [[NSMutableArray alloc] init];
    }
    return _arr_button;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
