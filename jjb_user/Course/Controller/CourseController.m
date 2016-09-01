//
//  CourseController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseController.h"
#import "CourseCatalogCell.h"
#import "CourseRegistrationCell.h"
#import "CourseCatalogAPIManager.h"
#import "CourseRegisterListAPIManager.h"
#import "CourseDetailAPIManager.h"
#import "CourseDetailHeader.h"
#import "HMSegmentedControl.h"
#import "CourseRegisterListReformer.h"
#import "CourseInfoReformer.h"
#import "CourseCatalogReformer.h"
#import "CourseCatalogView.h"
#import "SelectMenuController.h"
#import "CourseDetailCell.h"

/**
 *  课程控制器
 */
static NSString  *const RegisterListCellIdentifier=@"RegisterListCellIdentifier";
static NSString  *const CatalogCellIdentifier=@"CatalogCellIdentifier";
static NSString  *const CourseDetailCellIdentifier=@"CourseDetailCellIdentifier";

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
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *registrationData;
@property (nonatomic,copy) NSDictionary *detailData;
@property (nonatomic,copy) NSMutableArray *catalogData;

@property (nonatomic,strong) NSMutableArray *boolArr;
@property (nonatomic,strong) UIButton *btn;

/*
 *立即报名
 */
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *priceLabel;

@end

@implementation CourseController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageSize = 10;
    [self.view addSubview:self.tableView];
    [self.bottomView addSubview:self.lineView];
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.priceLabel];
    [self.view addSubview:self.bottomView];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
    [self.detailAPIManager loadData];
    [self.catalogAPIManager loadData];
    [self.signUpAPIManager loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self loadData];
}

-(void)loadData {
    if (self.tabbarControl.selectedSegmentIndex==0) {
        [self.detailAPIManager loadData];
    }else if(self.tabbarControl.selectedSegmentIndex==1)
    {
        [self.catalogAPIManager loadData];
    }else {
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
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@50);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_top).offset(10);
        make.left.mas_equalTo(self.lineView.mas_left).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_top).offset(10);
        make.right.mas_equalTo(self.lineView.mas_right).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.tabbarControl.selectedSegmentIndex==1) {
        return self.dataSource.count + 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tabbarControl.selectedSegmentIndex==0) {
        return 1;
    }else if (self.tabbarControl.selectedSegmentIndex==1) {
        if (section == 0) {
            return 0;
        }else {
            if (![self.boolArr[section] boolValue]) {
                return 0;
            }else {
                return 1;
            }
        }
    }
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        //课程详情
        CourseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.detailData];
        return cell;
    }else if (_tabbarControl.selectedSegmentIndex==1) {
        //课程目录
        CourseCatalogCell * cell = [tableView dequeueReusableCellWithIdentifier:CatalogCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.catalogData[indexPath.row]];
        return cell;
    }
    else {
        //报名信息
        CourseRegistrationCell * cell = [tableView dequeueReusableCellWithIdentifier:RegisterListCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.registrationData[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 0) {
        CGSize size = [self.detailData[@"describe"] boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
        
        float height = size.height;
        
        return height;
    } else if(_tabbarControl.selectedSegmentIndex == 1){
        
        NSDictionary * dic = self.catalogData[indexPath.row];
        
        CGSize size = [dic[@"CourseCatalogDesc"] boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
        
        float height = size.height;
        
        return height + 20;
    } else{
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.tabbarControl.selectedSegmentIndex==1) {
        if (section==0) {
            return  self.tabbarControl;
        }else{
            CourseCatalogView *view=[[CourseCatalogView alloc] init];
            [view configWithData:self.dataSource[section-1]];
            view.tag = 1000+section;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
            [view addGestureRecognizer:tap];
            view.backgroundColor = COLOR_WHITE;
            return view;
        }
    }
    return self.tabbarControl;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[CourseDetailAPIManager class]]) {
        self.detailData=[manager fetchDataWithReformer:self.detailReformer];
        [self.headerView configWithData:_detailData];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",_detailData[kCoursePrice]];
        self.title=_detailData[kCourseName];
    }
    if ([manager isKindOfClass:[CourseCatalogAPIManager class]]) {
        NSArray *resultData = [manager fetchDataWithReformer:self.catalogReformer];
        [self.catalogData addObjectsFromArray:resultData];
        
        for (NSInteger i = 0; i < self.catalogData.count + 1; i++) {
            
            [self.boolArr addObject:@NO];
        }
        
        if (self.tabbarControl.selectedSegmentIndex==0) {
            self.dataSource=self.catalogData;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }
    if ([manager isKindOfClass:[CourseRegisterListAPIManager class]]) {
        NSArray *resultData = [manager fetchDataWithReformer:self.registerListReformer];
        [self.registrationData addObjectsFromArray:resultData];
        if (self.tabbarControl.selectedSegmentIndex==1) {
            self.dataSource=self.registrationData;
        }
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
    
    if ([manager isKindOfClass:[CourseRegisterListAPIManager class]]) {
        
        return @{
                 @"course_id":@(self.courseID),
                 @"count":@(self.pageSize)
                 };
    }
        return @{
                 @"course_id":@(self.courseID)
                 };
}

#pragma -
#pragma mark - event response
- (void)tabbarControllChangeValue:(id)sender{
    
    if (self.tabbarControl.selectedSegmentIndex==0) {
        
        _tableView.mj_footer.hidden = YES;
    }else if (self.tabbarControl.selectedSegmentIndex==1) {
        self.dataSource=self.catalogData;
        self.pageIndex=[self.dataSource count];
    }else {
        self.dataSource=self.registrationData;
        self.pageIndex=[self.dataSource count];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.signUpAPIManager loadData];
        }];
    }
        [self.tableView reloadData];
}

- (void)tapGR:(UITapGestureRecognizer *)tapGR{
    //获取section
    NSInteger section = tapGR.view.tag - 1000;
    //判断改变bool值
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    //刷新section
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)payBtnClick:(UIButton *)click {
    
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
    if (controller==nil) {
        SelectMenuController *select = [[SelectMenuController alloc] init];
        self.definesPresentationContext = YES;
        select.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        select.courseID = [_detailData[@"CourseID"] integerValue];
        [self presentViewController:select animated:YES completion:nil];
    } else{
        UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
        [navController pushViewController:controller animated:YES];
    }
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
        _tabbarControl=[[HMSegmentedControl alloc] initWithSectionTitles:@[@"课程详情",@"课程目录",@"报名信息"]];
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
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataSource removeAllObjects];
            self.pageIndex=0;
            [self loadData];
        }];
        [_tableView registerClass:[CourseCatalogCell class] forCellReuseIdentifier:CatalogCellIdentifier];
        [_tableView registerClass:[CourseRegistrationCell class] forCellReuseIdentifier:RegisterListCellIdentifier];
        [_tableView registerClass:[CourseDetailCell class] forCellReuseIdentifier:CourseDetailCellIdentifier];
    }
    return _tableView;
}
- (NSMutableArray *)registrationData {
    if (!_registrationData) {
        
        _registrationData = [[NSMutableArray alloc] init];
    }
    return _registrationData;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (NSMutableArray *)catalogData {
    if (!_catalogData) {
        _catalogData = [[NSMutableArray alloc] init];
    }
    return _catalogData;
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
        _registerListReformer=[[CourseRegisterListReformer alloc] init];
    }
    return _registerListReformer;
}
-(id<ReformerProtocol>) catalogReformer{
    if (!_catalogReformer) {
        _catalogReformer=[[CourseCatalogReformer alloc] init];
    }
    return _catalogReformer;
}
-(id<ReformerProtocol>) detailReformer{
    if (!_detailReformer) {
        _detailReformer=[[CourseInfoReformer alloc] init];
    }
    return _detailReformer;
}
- (NSMutableArray *)boolArr {
    if (!_boolArr) {
        _boolArr = [[NSMutableArray alloc] init];
    }
    return _boolArr;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = COLOR_WHITE;
    }
    return _bottomView;
}
- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _payBtn.backgroundColor = COLOR_ORANGE;
        _payBtn.layer.cornerRadius = 2.0;
        _payBtn.clipsToBounds = YES;
        [_payBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_payBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _lineView;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = COLOR_ORANGE;
        _priceLabel.font = H1;
    }
    return _priceLabel;
}

@end