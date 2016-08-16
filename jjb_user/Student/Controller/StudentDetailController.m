//
//  StudentDetailController.m
//  jjb_user    学员详情
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailController.h"
#import "GrowingCell.h"
#import "StudentDetailHeader.h"
#import "MBStarCouseCell.h"
#import "MyGrowingAPIManager.h"
#import "GrowingTreeListReformer.h"
#import "ShopIndexReformer.h"
#import "ShopIndexAPIManager.h"

@interface StudentDetailController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) StudentDetailHeader *headerView;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) LDAPIBaseManager *MyGrowingAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> shopIndexReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *courseDataArr;
@property (nonatomic,strong) NSMutableArray *GrowingTreeDataArr;
@property(nonatomic,strong) NSDictionary *dataDic;

@end

@implementation StudentDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学员详情";
    self.pageIndex=0;
    self.pageSize=20;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self loadData];
}

-(void) loadData{
    if(self.tabbarControl.selectedSegmentIndex==0)
    {
        [self.MyGrowingAPIManager loadData];
        
    } else {
        
        [self.shopIndexAPIManager loadData];
    }
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

    if (_tabbarControl.selectedSegmentIndex == 0) {
        
        return self.GrowingTreeDataArr.count;
    } else {
        NSArray* arrData=self.dataDic[kShopIndexCourseList];
        return [arrData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_tabbarControl.selectedSegmentIndex == 0) {
        
        GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GrowingCellIdentifier" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GrowingCellIdentifier"];
        }
        
        NSDictionary * dic = self.GrowingTreeDataArr[indexPath.row];
        [cell configWithData:dic];
        return cell;
    }   else {
        
        MBStarCouseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MBStarCouseCellIdentifier" forIndexPath:indexPath];
        [cell configWithData:self.dataDic[kShopIndexCourseList][indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        
        NSDictionary * dic = self.GrowingTreeDataArr[indexPath.row];
        self.imageArr = dic[kGrowingTreeListImages];
        
        CGSize size = [dic[kGrowingTreeListContent] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H2} context:nil].size;
        
        float height = size.height;
        
        if ([dic[kGrowingTreeListContent] length] <= 0) {
            
            height = 0;
        }
        
        if (self.imageArr.count == 0) {
            
            return 92 + height;
            
        }else {
            return (self.imageArr.count+2)/3 *85 +92 + height;
        }
    } else {
        
        return Screen_Width/3.0f;
    }
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
    
    if ([manager isKindOfClass:[MyGrowingAPIManager class]]) {
        NSArray *resultData = [manager fetchDataWithReformer:self.growingTreeListReformer];
        [self.GrowingTreeDataArr addObjectsFromArray:resultData];
        self.pageIndex=[self.GrowingTreeDataArr count];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }else {
    
        self.dataDic = [manager fetchDataWithReformer:self.shopIndexReformer];
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
    
    if ([manager isKindOfClass:[MyGrowingAPIManager class]]) {
        return @{
                 @"user_id":@"4",
                 @"start":@(self.pageIndex),
                 @"count":@(self.pageSize)
                 };
    }
    else{
        return @{@"lng":@"117.10",@"lat":@"40.13",@"shopId":@"2"};
    }
}

#pragma -
#pragma mark - event response
- (void)tabBarControlChangeValue:(id)sender{
    if (self.tabbarControl.selectedSegmentIndex==1) {
        [self.courseDataArr removeAllObjects];
        self.pageIndex=0;
        [self loadData];
    }
    [self.tableView reloadData];
}

#pragma -
#pragma mark - getters and setters
- (HMSegmentedControl *)tabbarControl {

    if (!_tabbarControl) {
        
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"我的成长",@"我的课程"]];
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
            [self.GrowingTreeDataArr removeAllObjects];
            [self.courseDataArr removeAllObjects];
            self.pageIndex=0;
            [self.MyGrowingAPIManager loadData];
            [self.shopIndexAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.MyGrowingAPIManager loadData];
            [self.shopIndexAPIManager loadData];
        }];
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:@"GrowingCellIdentifier"];
        [_tableView registerClass:[MBStarCouseCell class] forCellReuseIdentifier:@"MBStarCouseCellIdentifier"];
    }
    return _tableView;
}

- (NSMutableArray *)GrowingTreeDataArr {

    if (!_GrowingTreeDataArr) {
        
        _GrowingTreeDataArr = [[NSMutableArray alloc] init];
    }
    return _GrowingTreeDataArr;
}

- (StudentDetailHeader *)headerView {

    if (!_headerView) {
        
        _headerView = [[StudentDetailHeader alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 202))];
        _headerView.backgroundColor = COLOR_WHITE;
    }
    return _headerView;
}

- (LDAPIBaseManager *)MyGrowingAPIManager {
    if (_MyGrowingAPIManager == nil) {
        _MyGrowingAPIManager = [MyGrowingAPIManager sharedInstance];
        _MyGrowingAPIManager.delegate=self;
        _MyGrowingAPIManager.paramSource=self;
    }
    return _MyGrowingAPIManager;
}

- (id<ReformerProtocol>) growingTreeListReformer{
    
    if (!_growingTreeListReformer) {
        _growingTreeListReformer=[[GrowingTreeListReformer alloc] init];
    }
    return _growingTreeListReformer;
}

- (LDAPIBaseManager *)shopIndexAPIManager {
    if (_shopIndexAPIManager == nil) {
        _shopIndexAPIManager = [ShopIndexAPIManager  sharedInstance];
        _shopIndexAPIManager.delegate=self;
        _shopIndexAPIManager.paramSource=self;
    }
    return _shopIndexAPIManager;
}

-(id<ReformerProtocol>) shopIndexReformer
{
    if (!_shopIndexReformer) {
        _shopIndexReformer=[[ShopIndexReformer alloc] init];
    }
    return _shopIndexReformer;
}

- (NSMutableArray *)courseDataArr {
    
    if (!_courseDataArr) {
        
        _courseDataArr = [[NSMutableArray alloc] init];
    }
    return _courseDataArr;
}

-(NSDictionary *) dataDic{
    if (!_dataDic) {
        _dataDic=[[NSDictionary alloc] init];
    }
    return _dataDic;
}

@end
