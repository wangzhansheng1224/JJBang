//
//  ActivityListController.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListController.h"
#import "ActivityListCell.h"
#import "ActivityListAPIManager.h"
#import "ActivityListReformer.h"
#import "ActivityDetailController.h"

static NSString  *const ActivityListCellIdentifier=@"ActivityListCellIdentifier";

@interface ActivityListController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *activityListAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> activityListReformer;
@property (nonatomic,strong) ActivityDetailController *detail;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger shopID;

@end

@implementation ActivityListController

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataActivityList:) name:@"ShopIndexShopIDNotification" object:nil];
    return self;
}
#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.pageIndex=0;
    self.pageSize=10;
    self.shopID = [ShopModel currentShop].shopID;
    [self.view addSubview:self.tableView];
    [self.activityListAPIManager loadData];
//    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"更改前的%ld",self.shopID);
    self.navigationController.navigationBarHidden = YES;
    if (self.shopID != [ShopModel currentShop].shopID) {
        [self.tableView.mj_header beginRefreshing];
        self.shopID = [ShopModel currentShop].shopID;
    }

    [self.tableView.mj_header beginRefreshing];
//    self.navigationController.navigationBarHidden = YES;
}
//刷新活动列表内容
-(void)refreshDataActivityList:(NSNotification *)notification {
        [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityListCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActivityListCellIdentifier];
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
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    [navController pushViewController:self.detail animated:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    NSString * string = change[@"new"];
//    NSString * str = change[@"old"];
}
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.activityListReformer];
    [self.arrData addObjectsFromArray:resultData];
    self.pageIndex=[self.arrData count];
    [self.tableView.mj_header endRefreshing];
    //判断列表数据>=10时才出现上提请求
    if ([self.arrData count] >=10){
       [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    //判断列表数据>=10时才出现上提请求
    if ([self.arrData count] >=10){
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    JJBLog(@"manager = %@",manager);

    if ([manager isKindOfClass:[_activityListAPIManager class]]) {
        NSLog(@"结论是大哥%ld",[ShopModel currentShop].shopID);

        return @{
                 @"shop_id":@([ShopModel currentShop].shopID),
                 @"user_id":@([UserModel currentUser].userID),
                 @"start":@(self.pageIndex),
                 @"count":@(self.pageSize),
                 @"isOwn":@"0"
                 };

    }
    return nil;
}


#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)activityListAPIManager {
    if (_activityListAPIManager == nil) {
        _activityListAPIManager = [ActivityListAPIManager  sharedInstance];
        _activityListAPIManager.delegate=self;
        _activityListAPIManager.paramSource=self;
    }
    return _activityListAPIManager;
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
            [self.activityListAPIManager loadData];
        }];
        
        //判断列表数据>=10时才出现上提请求
        if (self.pageIndex >=10){
            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.activityListAPIManager loadData];
            }];
        }
        
        [_tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:ActivityListCellIdentifier];
        
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
