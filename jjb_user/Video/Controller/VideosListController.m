//
//  VideosListController.m
//  jjb_user
//
//  Created by Aimee on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosListController.h"
#import "VideosListCell.h"
#import "VideosListAPIManager.h"
#import "VideosListReformer.h"
#import "VideosDetailController.h"

static NSString  *const VideosListCellIdentifier=@"VideosListCellIdentifier";

@interface VideosListController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) LDAPIBaseManager *VideosListAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> VideosListReformer;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation VideosListController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"视频列表";
    self.view.backgroundColor = COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.pageSize=10;
    self.pageIndex=0;
    [self layoutPageSubviews];
    [self.VideosListAPIManager loadData];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    
    VideosListCell *cell = [tableView dequeueReusableCellWithIdentifier:VideosListCellIdentifier forIndexPath:indexPath];
    [cell configWithData:self.dataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 290;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideosDetailController* detail= [[VideosDetailController alloc] init];
    detail.VideosID=[self.dataArr[indexPath.row][kVideosListID] integerValue];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.VideosListReformer];
    [self.dataArr addObjectsFromArray:resultData];
    self.pageIndex=[self.dataArr count];
    [self.tableView.mj_header endRefreshing];
    //判断列表数据>=10时才出现上提请求
    if (self.pageIndex >=10){
       [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    //判断列表数据>=10时才出现上提请求
    if (self.pageIndex >=10){
       [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"shop_id":@([ShopModel currentShop].shopID),
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
            [self.VideosListAPIManager loadData];
        }];
        //判断列表数据>=10时才出现上提请求
        if (self.pageIndex >=10){

            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.VideosListAPIManager loadData];
           }];
        }
        [_tableView registerClass:[VideosListCell class] forCellReuseIdentifier:VideosListCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (LDAPIBaseManager *)VideosListAPIManager {
    if (_VideosListAPIManager == nil) {
        _VideosListAPIManager = [VideosListAPIManager  sharedInstance];
        _VideosListAPIManager.delegate=self;
        _VideosListAPIManager.paramSource=self;
    }
    return _VideosListAPIManager;
}

- (id<ReformerProtocol>) VideosListReformer{
    
    if (!_VideosListReformer) {
        _VideosListReformer=[[VideosListReformer alloc] init];
    }
    return _VideosListReformer;
}


@end
