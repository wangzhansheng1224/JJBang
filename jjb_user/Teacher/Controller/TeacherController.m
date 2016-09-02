//
//  TeacherController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherController.h"
#import "GrowingCell.h"
#import "TeacherHeaderView.h"
#import "TeacherDetailCell.h"
#import "MyGrowingAPIManager.h"
#import "GrowingTreeListReformer.h"
#import "CourseListReformer.h"
#import "TeacherReformer.h"
#import "MyCourseAPIManager.h"
#import "TeacherDetailAPIManager.h"


static NSString  *const TeacherDetailCellIdentifier=@"TeacherDetailCellIdentifier";
static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";
@interface TeacherController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TeacherHeaderView *headerView;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) LDAPIBaseManager *MyGrowingAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) LDAPIBaseManager *detailAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> detailReformer;

@property (nonatomic,assign) NSInteger growingIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *GrowingTreeDataArr;
@property(nonatomic,strong) NSDictionary *detailDic;
@end

@implementation TeacherController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"老师首页";
    self.growingIndex=0;
    self.pageSize=10;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
    [self.detailAPIManager loadData];
    [self.MyGrowingAPIManager loadData];
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
    
    if (_tabbarControl.selectedSegmentIndex == 1) {
        
        GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:GrowingCellIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GrowingCellIdentifier];
        }
        
        NSDictionary * dic = self.GrowingTreeDataArr[indexPath.row];
        [cell configWithData:dic];
        return cell;
    }   else {
        
        TeacherDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:TeacherDetailCellIdentifier forIndexPath:indexPath];
        [cell configWithData:self.detailDic];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabbarControl.selectedSegmentIndex == 1) {
        
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
        return Screen_Height-204-44;
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
        self.growingIndex=[self.GrowingTreeDataArr count];
        [self.tableView.mj_header endRefreshing];
        [self addTableViewFooter];
        [self.tableView reloadData];
    }
    if ([manager isKindOfClass:[TeacherDetailAPIManager class]])
    {
        self.detailDic = [manager fetchDataWithReformer:self.detailReformer];
        [self.headerView configWithData:_detailDic];
        [self.tableView.mj_header endRefreshing];
        [self addTableViewFooter];
        [self.tableView reloadData];
    }
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self addTableViewFooter];
}
//添加tableView底部视图
-(void)addTableViewFooter{
    //判断列表数据>=10时才出现上提请求
    if (self.growingIndex >=10 && self.tabbarControl.selectedSegmentIndex==1){
        [self.tableView.mj_footer endRefreshing];
    }

}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[MyGrowingAPIManager class]]) {
        return @{
                 @"user_id":@(self.teacherID),
                 @"start":@(self.growingIndex),
                 @"count":@(self.pageSize)
                 };
    }
    if ([manager isKindOfClass:[TeacherDetailAPIManager class]]) {
        return @{
                 @"teaId":@(self.teacherID)
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
        
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"老师简介",@"老师动态"]];
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
        //判断列表数据>=10时才出现上提请求
        if (self.growingIndex >=10 && self.tabbarControl.selectedSegmentIndex==1){
            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self.MyGrowingAPIManager loadData];
            
            }];
        }
        [_tableView registerClass:[TeacherDetailCell class] forCellReuseIdentifier:TeacherDetailCellIdentifier];
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)GrowingTreeDataArr {
    
    if (!_GrowingTreeDataArr) {
        
        _GrowingTreeDataArr = [[NSMutableArray alloc] init];
    }
    return _GrowingTreeDataArr;
}

- (TeacherHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[TeacherHeaderView alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 194+10))];
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


- (LDAPIBaseManager *)detailAPIManager {
    if (_detailAPIManager == nil) {
        _detailAPIManager = [TeacherDetailAPIManager  sharedInstance];
        _detailAPIManager.delegate=self;
        _detailAPIManager.paramSource=self;
    }
    return _detailAPIManager;
}

-(id<ReformerProtocol>) detailReformer
{
    if (!_detailReformer) {
        _detailReformer=[[TeacherReformer alloc] init];
    }
    return _detailReformer;
}

@end
