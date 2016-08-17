//
//  CourseController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseController.h"
#import "CourseDetailCell.h"
#import "ActivityRegistrationCell.h"
#import "CourseCatalogAPIManager.h"
#import "CourseRegisterListAPIManager.h"
#import "CourseDetailAPIManager.h"
#import "CourseDetailHeader.h"
#import "HMSegmentedControl.h"
#import "ActivityRegisterListReformer.h"
#import "CourseInfoReformer.h"

/**
 *  课程控制器
 */
static NSString  *const RegisterListCellIdentifier=@"RegisterListCellIdentifier";
static NSString  *const CatalogCellIdentifier=@"CatalogCellIdentifier";
@interface CourseController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LDAPIBaseManager *catalogAPIManager;
@property (nonatomic,strong) LDAPIBaseManager *detailAPIManager;
@property (nonatomic,strong) LDAPIBaseManager *signUpAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> detailReformer;
@property (nonatomic,strong) id<ReformerProtocol> registerListReformer;
@property (nonatomic,strong) id<ReformerProtocol> catalogReformer;
@property (nonatomic,strong) CourseDetailHeader *headerView;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array_data;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *arrRegistrationData;
@property (nonatomic,copy) NSDictionary *detailData;

@end

@implementation CourseController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self loadData];
}

-(void) loadData{
    
    [self.detailAPIManager loadData];
    if(self.tabbarControl.selectedSegmentIndex==0)
    {
        [self.catalogAPIManager loadData];
    } else if(self.tabbarControl.selectedSegmentIndex==1)
    {
        [self.signUpAPIManager loadData];
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
        return 10;
    } else if(_tabbarControl.selectedSegmentIndex == 1){
        return [self.arrRegistrationData count];
    } else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        //活动详情
        CourseDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:CatalogCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.detailData];
        return cell;
        
    }
    else if (_tabbarControl.selectedSegmentIndex==1) {
        //报名信息
        ActivityRegistrationCell * cell = [tableView dequeueReusableCellWithIdentifier:RegisterListCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.arrRegistrationData[indexPath.row]];
        return cell;
    } else {
        //报名信息
        ActivityRegistrationCell * cell = [tableView dequeueReusableCellWithIdentifier:RegisterListCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        return 44;
    } else if(_tabbarControl.selectedSegmentIndex == 1){
        return 80;
    } else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.tabbarControl;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[CourseDetailAPIManager class]]) {
         self.detailData=[manager fetchDataWithReformer:self.detailReformer];
         [self.headerView configWithData:_detailData];
           self.title=_detailData[kCourseName];
    }
    if ([manager isKindOfClass:[CourseCatalogAPIManager class]]) {
        self.detailData=[manager fetchDataWithReformer:self.catalogReformer];
     
        [self.tableView reloadData];
    }
    if ([manager isKindOfClass:[CourseRegisterListAPIManager class]]) {
        NSArray *resultData = [manager fetchDataWithReformer:self.registerListReformer];
        [self.arrRegistrationData addObjectsFromArray:resultData];
        self.pageIndex=[self.arrRegistrationData count];
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
        return @{
                 @"course_id":@(self.courseID)
                 };
}

#pragma -
#pragma mark - event response
- (void) tabbarControllChangeValue:(id)sender{
    if (self.tabbarControl.selectedSegmentIndex==1) {
        [self.arrRegistrationData removeAllObjects];
        self.pageIndex=0;
        [self loadData];
    }
    [self.tableView reloadData];
}

#pragma -
#pragma mark - getters and setters
- (CourseDetailHeader *) headerView{
    if (!_headerView) {
        _headerView=[[CourseDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*2/3.0+50)];
        _headerView.backgroundColor=COLOR_WHITE;
    }
    return _headerView;
}

- (HMSegmentedControl *) tabbarControl
{
    
    if (!_tabbarControl) {
        _tabbarControl=[[HMSegmentedControl alloc] initWithSectionTitles:@[@"课程详情",@"报名信息"]];
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
        
        [_tableView registerClass:[CourseDetailCell class] forCellReuseIdentifier:CatalogCellIdentifier];
        [_tableView registerClass:[ActivityRegistrationCell class] forCellReuseIdentifier:RegisterListCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)arrRegistrationData {
    
    if (!_arrRegistrationData) {
        
        _arrRegistrationData = [[NSMutableArray alloc] init];
    }
    return _arrRegistrationData;
}

- (NSMutableArray *)array_data {
    
    if (!_array_data) {
        
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (LDAPIBaseManager *)catalogAPIManager {
    if (_catalogAPIManager == nil) {
        _catalogAPIManager = [CourseCatalogAPIManager  sharedInstance];
        _catalogAPIManager.delegate=self;
        _catalogAPIManager.paramSource=self;
    }
    return _catalogAPIManager;
}

- (LDAPIBaseManager *)signUpAPIManager {
    if (_signUpAPIManager == nil) {
        _signUpAPIManager = [CourseRegisterListAPIManager  sharedInstance];
        _signUpAPIManager.delegate=self;
        _signUpAPIManager.paramSource=self;
    }
    return _signUpAPIManager;
}
- (LDAPIBaseManager *)detailAPIManager {
    if (_detailAPIManager == nil) {
        _detailAPIManager = [CourseDetailAPIManager  sharedInstance];
        _detailAPIManager.delegate=self;
        _detailAPIManager.paramSource=self;
    }
    return _detailAPIManager;
}


- (id<ReformerProtocol>) registerListReformer{
    
    if (!_registerListReformer) {
        _registerListReformer=[[ActivityRegisterListReformer alloc] init];
    }
    return _registerListReformer;
}

-(id<ReformerProtocol>) catalogReformer{
    if (!_catalogReformer) {
        _catalogReformer=[[CourseInfoReformer alloc] init];
    }
    return _catalogReformer;
}

-(id<ReformerProtocol>) detailReformer{
    if (!_detailReformer) {
        _detailReformer=[[CourseInfoReformer alloc] init];
    }
    return _detailReformer;
}

@end