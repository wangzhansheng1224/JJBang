//
//  GoodsListController.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsListController.h"
#import "GoodsListCell.h"
#import "GoodsListAPIManager.h"
#import "GoodsListReformer.h"
#import "GoodsDetailController.h"

static NSString  *const GoodsListCellIdentifier=@"GoodsListCellIdentifier";

@interface GoodsListController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) LDAPIBaseManager *GoodsListAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> GoodsListReformer;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation GoodsListController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"商品列表";
    self.view.backgroundColor = COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.pageSize=20;
    self.pageIndex=0;
    [self layoutPageSubviews];
    [self.GoodsListAPIManager loadData];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height - 64));
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
}


#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsListCellIdentifier forIndexPath:indexPath];
    [cell configWithData:self.dataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 107;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailController* detail= [[GoodsDetailController alloc] init];
    detail.goodsID=[self.dataArr[indexPath.row][kGoodsListID] integerValue];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.GoodsListReformer];
    [self.dataArr addObjectsFromArray:resultData];
    self.pageIndex=[self.dataArr count];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"shop_id":[[NSUserDefaults standardUserDefaults]objectForKey:@"currenShopID"],
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}


#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArr removeAllObjects];
            self.pageIndex=0;
            [self.GoodsListAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{            [self.GoodsListAPIManager loadData];
        }];
        
        [_tableView registerClass:[GoodsListCell class] forCellReuseIdentifier:GoodsListCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (LDAPIBaseManager *)GoodsListAPIManager {
    if (_GoodsListAPIManager == nil) {
        _GoodsListAPIManager = [GoodsListAPIManager  sharedInstance];
        _GoodsListAPIManager.delegate=self;
        _GoodsListAPIManager.paramSource=self;
    }
    return _GoodsListAPIManager;
}

- (id<ReformerProtocol>) GoodsListReformer{
    
    if (!_GoodsListReformer) {
        _GoodsListReformer=[[GoodsListReformer alloc] init];
    }
    return _GoodsListReformer;
}


@end
