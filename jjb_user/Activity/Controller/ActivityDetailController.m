//
//  ActivityDetailController.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailController.h"
#import "ActivityDetailCell.h"
#import "ActivityRegistrationCell.h"
#import "ActivityDetailAPIManager.h"
#import "ActivityRegisterListAPIManager.h"
#import "ActivityDetailHeader.h"
#import "HMSegmentedControl.h"
#import "ActivityRegisterListReformer.h"
#import "ActivityDetailReformer.h"

@interface ActivityDetailController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LDAPIBaseManager *detailAPIManager;
@property (nonatomic,strong) LDAPIBaseManager *signUpAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> activityRegisterListReformer;
@property (nonatomic,strong) id<ReformerProtocol> detailReformer;
@property (nonatomic,strong) ActivityDetailHeader *headerView;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array_data;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *arrRegistrationData;
@property (nonatomic,copy) NSDictionary *detailData;

@end

@implementation ActivityDetailController

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
    if(self.tabbarControl.selectedSegmentIndex==0)
    {
        [self.detailAPIManager loadData];
    } else if(self.tabbarControl.selectedSegmentIndex==1)
    {
        [self.signUpAPIManager loadData];
    }else{
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
          return 1;
      } else if(_tabbarControl.selectedSegmentIndex == 1){
          return [self.arrRegistrationData count];
      } else{
          return 10;
      }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        //活动详情
        ActivityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailCell" forIndexPath:indexPath];
        [cell configWithData:self.detailData];
        return cell;
        
    }
   else if (_tabbarControl.selectedSegmentIndex==1) {
        //报名信息
        ActivityRegistrationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityRegistrationCell" forIndexPath:indexPath];
       [cell configWithData:self.arrRegistrationData[indexPath.row]];
        return cell;
    } else {
        //报名信息
        ActivityRegistrationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityRegistrationCell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        return Screen_Height-280;
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
    
    if ([manager isKindOfClass:[ActivityDetailAPIManager class]]) {
        self.detailData=[manager fetchDataWithReformer:self.detailReformer];
        self.title=_detailData[kActivityDetailTitle];
        [self.headerView configWithData:_detailData];
        [self.tableView reloadData];
    }
    if ([manager isKindOfClass:[ActivityRegisterListAPIManager class]]) {
        NSArray *resultData = [manager fetchDataWithReformer:self.activityRegisterListReformer];
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
    
      if ([manager isKindOfClass:[ActivityDetailAPIManager class]]) {
    return @{
             @"activity_id":@(self.activity_id),
             @"user_id":@([UserModel currentUser].userID)
             };
      }
     else if ([manager isKindOfClass:[ActivityRegisterListAPIManager class]]) {
         return @{
                  @"activity_id":@(self.activity_id)
                  };
     }
    else
        return nil;
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

- (void)joinClick {

    NSLog(@"------立即报名------");
}

#pragma -
#pragma mark - getters and setters
- (ActivityDetailHeader *) headerView{
    if (!_headerView) {
        _headerView=[[ActivityDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 273)];
        _headerView.backgroundColor=COLOR_WHITE;
    }
   return _headerView;
}

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

        [_tableView registerClass:[ActivityDetailCell class] forCellReuseIdentifier:@"ActivityDetailCell"];
        [_tableView registerClass:[ActivityRegistrationCell class] forCellReuseIdentifier:@"ActivityRegistrationCell"];
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

- (LDAPIBaseManager *)detailAPIManager {
    if (_detailAPIManager == nil) {
        _detailAPIManager = [ActivityDetailAPIManager  sharedInstance];
        _detailAPIManager.delegate=self;
        _detailAPIManager.paramSource=self;
    }
    return _detailAPIManager;
}

- (LDAPIBaseManager *)signUpAPIManager {
    if (_signUpAPIManager == nil) {
        _signUpAPIManager = [ActivityRegisterListAPIManager  sharedInstance];
        _signUpAPIManager.delegate=self;
        _signUpAPIManager.paramSource=self;
    }
    return _signUpAPIManager;
}

- (id<ReformerProtocol>) activityRegisterListReformer{
    
    if (!_activityRegisterListReformer) {
        _activityRegisterListReformer=[[ActivityRegisterListReformer alloc] init];
    }
    return _activityRegisterListReformer;
}

-(id<ReformerProtocol>) detailReformer{
    if (!_detailReformer) {
        _detailReformer=[[ActivityDetailReformer alloc] init];
    }
   return _detailReformer;
}

@end
