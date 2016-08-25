//
//  StarTeacherController.m
//  jjb_user
//
//  Created by Check on 16/8/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StarTeacherController.h"
#import "TeacherListCell.h"
#import "StarTeacherListAPIManager.h"
#import "TeacherReformer.h"
#import "TeacherController.h"

static NSString  *const StarTeacherCellIdentifier=@"StarTeacherCellIdentifier";
@interface StarTeacherController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *apiManager;
@property (nonatomic,strong) id<ReformerProtocol> starTeacherReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation StarTeacherController

#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"明星老师";
    self.pageSize=10;
    self.pageIndex=0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.apiManager loadData];
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
    
    TeacherListCell *cell = [tableView dequeueReusableCellWithIdentifier:StarTeacherCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[TeacherListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StarTeacherCellIdentifier];
    }
    [cell configWithData:self.arrData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherController *detail =[[TeacherController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.starTeacherReformer];
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
             @"shop_id":@([ShopModel currentShop].shopID),
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)apiManager {
    if (_apiManager == nil) {
        _apiManager = [StarTeacherListAPIManager  sharedInstance];
        _apiManager.delegate=self;
        _apiManager.paramSource=self;
    }
    return _apiManager;
}

- (id<ReformerProtocol>) starTeacherReformer{
    
    if (!_starTeacherReformer) {
        _starTeacherReformer=[[TeacherReformer alloc] init];
    }
    return _starTeacherReformer;
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView.mj_footer setAutomaticallyHidden:YES];
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.apiManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.apiManager loadData];
        }];
        [_tableView registerClass:[TeacherListCell class] forCellReuseIdentifier:StarTeacherCellIdentifier];
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