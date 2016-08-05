//
//  GrowingTreeController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingTreeController.h"
#import "GrowingCell.h"
#import "IssueController.h"
#import "GrowingTreeListAPIManager.h"
#import "GrowingTreeListReformer.h"



static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";

@interface GrowingTreeController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) LDAPIBaseManager *growingTreeListAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIBarButtonItem *btn_issue;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) IssueController *issueVC;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@end

@implementation GrowingTreeController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"社区动态";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageIndex=0;
    self.pageSize=20;
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.btn_issue;
    [self layoutPageSubviews];
    [self.growingTreeListAPIManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(superView.mas_top);
                make.left.mas_equalTo(superView.mas_left);
                make.width.mas_equalTo(superView.mas_width);
                make.height.mas_equalTo(superView.mas_height);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:GrowingCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GrowingCellIdentifier];
    }
    [cell configWithData:_arrData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 210;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.growingTreeListReformer];
    [self.arrData addObjectsFromArray:resultData];
    self.pageIndex=[self.arrData count];
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
    return @{
             @"shop_id":@"1",
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - event response
- (void)itemClick {
    
    [self.navigationController pushViewController:self.issueVC animated:YES];
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.growingTreeListAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{            [self.growingTreeListAPIManager loadData];
        }];
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
    }
    return _tableView;
}

- (UIBarButtonItem *)issueBtn {

    if (!_btn_issue) {
        
        _btn_issue = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    }
    return _btn_issue;
}

- (NSMutableArray *)arrData{
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

- (IssueController *)issueVC {
    if (!_issueVC) {
        _issueVC = [[IssueController alloc] init];
    }
    return _issueVC;
}

- (LDAPIBaseManager *)growingTreeListAPIManager {
    if (_growingTreeListAPIManager == nil) {
        _growingTreeListAPIManager = [GrowingTreeListAPIManager  sharedInstance];
        _growingTreeListAPIManager.delegate=self;
        _growingTreeListAPIManager.paramSource=self;
    }
    return _growingTreeListAPIManager;
}

- (id<ReformerProtocol>) growingTreeListReformer{
    
    if (!_growingTreeListReformer) {
        _growingTreeListReformer=[[GrowingTreeListReformer alloc] init];
    }
    return _growingTreeListReformer;
}
@end
