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
    
    [self.detailAPIManager loadData];
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
    StoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:StoreDetailCellIdentifier forIndexPath:indexPath];
  
//        TeacherDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:TeacherDetailCellIdentifier forIndexPath:indexPath];
//        [cell configWithData:self.detailDic];
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return Screen_Height-204-44;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.tabbarControl;
}


#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[StoreDetailInfoAPIManager class]]) {
        return @{
                 @"shop_id":@(self.storeID)
                 };
    }
    return nil;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
//    
//    if ([manager isKindOfClass:[ActivityDetailAPIManager class]]) {
//        self.storeDetailDictionary=[manager fetchDataWithReformer:self.detailReformer];
//        self.title=_detailData[kActivityDetailTitle];
//        [self.headerView configWithData:_detailData];
//        [self.tableView reloadData];
//    }
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}



#pragma -
#pragma mark - getters and setters
//- (ActivityDetailHeader *) headerView{
//    if (!_headerView) {
//        _headerView=[[ActivityDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 273)];
//        _headerView.backgroundColor=COLOR_WHITE;
//    }
//    return _headerView;
//}
//
- (HMSegmentedControl *) tabbarControl
{
    
    if (!_tabbarControl) {
        _tabbarControl=[[HMSegmentedControl alloc] initWithSectionTitles:@[@"活动详情",@"报名信息"]];
        _tabbarControl.selectionIndicatorColor=COLOR_ORANGE;
        _tabbarControl.titleTextAttributes=@{NSForegroundColorAttributeName:COLOR_GRAY,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation=HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight=2.0f;
        [_tabbarControl addTarget:self action:@selector(tabbarControllChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabbarControl;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        [_tableView registerClass:[ActivityDetailCell class] forCellReuseIdentifier:@"ActivityDetailCell"];
//        [_tableView registerClass:[ActivityRegistrationCell class] forCellReuseIdentifier:@"ActivityRegistrationCell"];
    }
    return _tableView;
}

//- (NSMutableArray *)arrRegistrationData {

//    if (!_arrRegistrationData) {
//        
//        _arrRegistrationData = [[NSMutableArray alloc] init];
//    }
//    return _arrRegistrationData;
//}

//- (NSMutableArray *)array_data {

//    if (!_array_data) {
//        
//        _array_data = [[NSMutableArray alloc] init];
//    }
//    return _array_data;
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
