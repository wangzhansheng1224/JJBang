//
//  MyCourseController.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyCourseController.h"
#import "MyCourseCell.h"
#import "MyCourseAPIManager.h"
#import "CourseListReformer.h"

static NSString  *const MyCourseCellIdentifier=@"MyCourseCellIdentifier";
@interface MyCourseController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *myCourseAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> myCourseReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation MyCourseController

#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的课程";
    self.pageSize=10;
    self.pageIndex=0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.myCourseAPIManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView=self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.bottom.equalTo(superView.mas_bottom);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCourseCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCourseCellIdentifier];
    }
    [cell configWithData:self.arrData[indexPath.row]];
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    return 148;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic=self.arrData[indexPath.row];
    UIViewController* controller=[[CTMediator sharedInstance] CTMediator_CourseDetail:@{@"courseID":dataDic[kCourseID]}];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.myCourseReformer];
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
    return @{
             @"user_id":@([UserModel currentUser].userID),
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)myCourseAPIManager {
    if (_myCourseAPIManager == nil) {
        _myCourseAPIManager = [MyCourseAPIManager  sharedInstance];
        _myCourseAPIManager.delegate=self;
        _myCourseAPIManager.paramSource=self;
    }
    return _myCourseAPIManager;
}

- (id<ReformerProtocol>) myCourseReformer{
    
    if (!_myCourseReformer) {
        _myCourseReformer=[[CourseListReformer alloc] init];
    }
    return _myCourseReformer;
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
        
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.myCourseAPIManager loadData];
        }];
        //判断列表数据>=10时才出现上提请求
        if (self.pageIndex >=10){
            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.myCourseAPIManager loadData];
           }];
        }
        [_tableView registerClass:[MyCourseCell class] forCellReuseIdentifier:MyCourseCellIdentifier];
    }
    return _tableView;
}
    
- (NSMutableArray *)arrData{
        
    if (!_arrData) {
        
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
@end
