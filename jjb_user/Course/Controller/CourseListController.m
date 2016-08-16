//
//  CourseListController.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseListController.h"

/**
 *  课程列表
 */

#import "MBStarCouseCell.h"
#import "CourseListAPIManager.h"
#import "CourseListReformer.h"

static NSString  *const CourseListCellIdentifier=@"CourseListCellIdentifier";
@interface CourseListController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *CourseListAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> CourseListReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation CourseListController

#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"课程列表";
    self.pageSize=10;
    self.pageIndex=0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.CourseListAPIManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView=self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.bottom.equalTo(superView.mas_bottom);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBStarCouseCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseListCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MBStarCouseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CourseListCellIdentifier];
    }
    [cell configWithData:self.arrData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 148;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.CourseListReformer];
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
             @"shop_id":@(1),
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)CourseListAPIManager {
    if (_CourseListAPIManager == nil) {
        _CourseListAPIManager = [CourseListAPIManager  sharedInstance];
        _CourseListAPIManager.delegate=self;
        _CourseListAPIManager.paramSource=self;
    }
    return _CourseListAPIManager;
}

- (id<ReformerProtocol>) CourseListReformer{
    
    if (!_CourseListReformer) {
        _CourseListReformer=[[CourseListReformer alloc] init];
    }
    return _CourseListReformer;
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
            [self.CourseListAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{            [self.CourseListAPIManager loadData];
        }];
        [_tableView registerClass:[MBStarCouseCell class] forCellReuseIdentifier:CourseListCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)arrData{
    
    if (!_arrData) {
        
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

@end
