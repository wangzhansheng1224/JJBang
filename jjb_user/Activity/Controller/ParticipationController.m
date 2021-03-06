//
//  ParticipationController.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ParticipationController.h"
#import "ActivityListCell.h"
#import "ParticipationAPIManager.h"
#import "ActivityListReformer.h"
#import "ActivityDetailController.h"

static NSString  *const MyActivityListCellIdentifier=@"MyActivityListCellIdentifier";

@interface ParticipationController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *participationAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> activityListReformer;
@property (nonatomic,strong) ActivityDetailController *detail;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation ParticipationController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.pageIndex=0;
    self.pageSize=10;
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    [self.participationAPIManager loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:MyActivityListCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyActivityListCellIdentifier];
    }
    [cell configWithData:_arrData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 272;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.detail.hidesBottomBarWhenPushed = YES;
    NSDictionary *item=_arrData[indexPath.row];
    self.detail.activity_id=[item[kActivityListID] integerValue];
    [self.navigationController pushViewController:self.detail animated:YES];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.activityListReformer];
    [self.arrData addObjectsFromArray:resultData];
    self.pageIndex=[self.arrData count];
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
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    if ([manager isKindOfClass:[_participationAPIManager class]]) {
        JJBLog(@"manager111 = %@",manager);

    return @{
             @"shop_id":@([ShopModel currentShop].shopID),
             @"user_id":@([UserModel currentUser].userID),
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize),
             @"isOwn":@"1"
             };

    }
    return nil;
}
#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)participationAPIManager {
    if (_participationAPIManager == nil) {
        _participationAPIManager = [ParticipationAPIManager sharedInstance];
        _participationAPIManager.delegate = self;
        _participationAPIManager.paramSource = self;
    }
    return _participationAPIManager;
}
- (id<ReformerProtocol>) activityListReformer{
    
    if (!_activityListReformer) {
        _activityListReformer=[[ActivityListReformer alloc] init];
    }
    return _activityListReformer;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - 49);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.participationAPIManager loadData];
        }];
        //判断列表数据>=10时才出现上提请求
        if (self.pageIndex >=10){
            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.participationAPIManager loadData];
            }];
        }
        [_tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:MyActivityListCellIdentifier];
        
    }
    return _tableView;
}

- (NSMutableArray *)arrData{
    
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
    
}

- (ActivityDetailController *)detail {
    
    if (!_detail) {
        
        _detail = [[ActivityDetailController alloc] init];
    }
    return _detail;
}


@end
