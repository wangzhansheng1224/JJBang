//
//  MyGrowingController.m
//  jjb_user    我的成长
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyGrowingController.h"
#import "GrowingCell.h"
#import "LoginViewController.h"
#import "MyGrowingAPIManager.h"
#import "GrowingTreeListReformer.h"

static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";

@interface MyGrowingController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) LDAPIBaseManager *myGrowingAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation MyGrowingController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageIndex=0;
    self.pageSize=10;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.myGrowingAPIManager loadData];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
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
        make.height.equalTo(@(Screen_Height - 64 - 50));
    }];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:GrowingCellIdentifier forIndexPath:indexPath];
    if (_arrData.count <= 0) {
        return cell;
    }
    if (cell == nil) {
        cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GrowingCellIdentifier];
    }
    NSDictionary * dic = self.arrData[indexPath.row];
    
    [cell configWithData:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = self.arrData[indexPath.row];
    self.imageArr = dic[kGrowingTreeListImages];
    
    CGSize size = [dic[kGrowingTreeListContent] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H4} context:nil].size;
    
    float height = size.height;
    
    if ([dic[kGrowingTreeListContent] length] <= 0) {
        
        height = 0;
    }
    
    if (self.imageArr.count == 0) {
        
        return 89 + height;
        
    }else {
        return (self.imageArr.count+2)/3 *85 +93 + height;
    }
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.growingTreeListReformer];
    [self.arrData addObjectsFromArray:resultData];
    self.pageIndex=[self.arrData count];
    [self.tableView.mj_header endRefreshing];
    //判断列表数据>10时才出现上提请求
    if(self.pageIndex >= 10){
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    //判断列表数据>10时才出现上提请求
    if(self.pageIndex >= 10){
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"shop_id":@([ShopModel currentShop].shopID),
             @"user_id":@([UserModel currentUser].userID),
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.myGrowingAPIManager loadData];
        }];
        //判断列表数据>=10时才出现上提请求
        if ([self.arrData count] >=10){
            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self.myGrowingAPIManager loadData];
            }];
        }
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)arrData{
    if (!_arrData) {
        
        _arrData = [[NSMutableArray alloc] init];
    }
    return _arrData;
}

- (LDAPIBaseManager *)myGrowingAPIManager {
    if (_myGrowingAPIManager == nil) {
        _myGrowingAPIManager = [MyGrowingAPIManager  sharedInstance];
        _myGrowingAPIManager.delegate=self;
        _myGrowingAPIManager.paramSource=self;
    }
    return _myGrowingAPIManager;
}

- (id<ReformerProtocol>)growingTreeListReformer {
    
    if (!_growingTreeListReformer) {
        _growingTreeListReformer=[[GrowingTreeListReformer alloc] init];
    }
    return _growingTreeListReformer;
}


@end
