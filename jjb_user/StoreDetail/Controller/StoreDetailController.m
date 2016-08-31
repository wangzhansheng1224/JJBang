//
//  TeacherController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StoreDetailController.h"
#import "StoreDetailCell.h"
#import "StoreDetailInfoAPIManager.h"
#import "StoreDetailReformer.h"
#import "StoreDetailHeaderView.h"
#import "ShopIndexKeys.h"
static NSString  *const StoreDetailCellIdentifier=@"StoreDetailCellIdentifier";
@interface StoreDetailController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) LDAPIBaseManager *MyGrowingAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) LDAPIBaseManager *detailAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> storeDetailReformer;
@property (nonatomic,strong) StoreDetailInfoAPIManager *storeDetailInfoAPIManager;
@property (nonatomic,strong) StoreDetailHeaderView *headerView;
//@property (nonatomic,strong) StoreDetailReformer *storeDetailReformer;

@property (nonatomic,assign) NSInteger growingIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *GrowingTreeDataArr;
@property (nonatomic,strong) NSDictionary *storeDetailDictionary;
@end

@implementation StoreDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"门店详情";
    self.growingIndex=0;
    self.pageSize=20;
    [self.view addSubview:self.tableView];
    
//    self.tableView.tableHeaderView=self.headerView;
    
    [self layoutPageSubviews];
    
    [self.storeDetailInfoAPIManager loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}
#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_tabbarControl.selectedSegmentIndex == 1) {
        return self.GrowingTreeDataArr.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        StoreDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:StoreDetailCellIdentifier forIndexPath:indexPath];
//        [cell configWithData:self.detailDic];
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return Screen_Height-204-44;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.tabbarControl;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[StoreDetailInfoAPIManager class]]){
        self.storeDetailDictionary = [manager fetchDataWithReformer:self.storeDetailReformer];
        [self.headerView configWithData:_storeDetailDictionary];
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
    if ([manager isKindOfClass:[StoreDetailInfoAPIManager class]]) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        self.storeID = [[userDefault objectForKey:kShopIndexShopID] integerValue];
        return @{
                 @"shop_id":@(self.storeID)
                 };
    }
    return nil;
}

#pragma -
#pragma mark - event response
- (void)tabBarControlChangeValue:(id)sender{
    [self.tableView reloadData];
}

#pragma -
#pragma mark - getters and setters
- (HMSegmentedControl *)tabbarControl {
    
    if (!_tabbarControl) {
        
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"门店简介",@"门店优势"]];
        _tabbarControl.selectionIndicatorColor = COLOR_ORANGE;
        _tabbarControl.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_GRAY,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight = 2.0f;
        [_tabbarControl addTarget:self action:@selector(tabBarControlChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabbarControl;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (self.tabbarControl.selectedSegmentIndex==1) {
                [self.GrowingTreeDataArr removeAllObjects];
                self.growingIndex=0;
                [self.MyGrowingAPIManager loadData];
            }
            else{
                [self.detailAPIManager loadData];
            }
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (self.tabbarControl.selectedSegmentIndex==1) {
                [self.MyGrowingAPIManager loadData];
            }
            else{
                [self.detailAPIManager loadData];
            }
        }];
        [_tableView registerClass:[StoreDetailCell class] forCellReuseIdentifier:StoreDetailCellIdentifier];

    }
    return _tableView;
}

- (NSMutableArray *)GrowingTreeDataArr {
    
    if (!_GrowingTreeDataArr) {
        
        _GrowingTreeDataArr = [[NSMutableArray alloc] init];
    }
    return _GrowingTreeDataArr;
}

- (StoreDetailHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[StoreDetailHeaderView alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 194+10))];
        _headerView.backgroundColor = COLOR_WHITE;
    }
    return _headerView;
}

//- (LDAPIBaseManager *)MyGrowingAPIManager {
//    if (_MyGrowingAPIManager == nil) {
//        _MyGrowingAPIManager = [MyGrowingAPIManager sharedInstance];
//        _MyGrowingAPIManager.delegate=self;
//        _MyGrowingAPIManager.paramSource=self;
//    }
//    return _MyGrowingAPIManager;
//}
//
//- (id<ReformerProtocol>) growingTreeListReformer{
//    
//    if (!_growingTreeListReformer) {
//        _growingTreeListReformer=[[GrowingTreeListReformer alloc] init];
//    }
//    return _growingTreeListReformer;
//}


- (LDAPIBaseManager *)storeDetailInfoAPIManager {
    if (_storeDetailInfoAPIManager == nil) {
        _storeDetailInfoAPIManager = [StoreDetailInfoAPIManager  sharedInstance];
        _storeDetailInfoAPIManager.delegate=self;
        _storeDetailInfoAPIManager.paramSource=self;
    }
    return _storeDetailInfoAPIManager;
}
-(id<ReformerProtocol>)storeDetailReformer
{
    if (_storeDetailReformer == nil) {
        _storeDetailReformer = [[StoreDetailReformer alloc]init];
    }
    return _storeDetailReformer;
}
-(NSDictionary *)storeDetailDictionary
{
    if (_storeDetailDictionary == nil) {
        _storeDetailDictionary = [[NSDictionary alloc]init];
        
    }
    return _storeDetailDictionary;
}

@end
