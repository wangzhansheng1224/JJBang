//
//  TeacherController.m
//  jjb_user    学员
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentController.h"
#import "StudentListCell.h"
#import "StudentDetailController.h"

#import "MyCourseCell.h"
#import "StarStudentListAPIManger.h"
#import "StudentReformer.h"

static NSString  *const StudentListCellIdentifier=@"StudentListCellIdentifier";
@interface StudentController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *studentListAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> studentReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation StudentController

#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"明星学员";
    self.pageSize=10;
    self.pageIndex=0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.studentListAPIManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    MyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:StudentListCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StudentListCellIdentifier];
    }
    [cell configWithData:self.arrData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 148;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentDetailController *detail=[[StudentDetailController alloc] init];
    detail.studentID=1;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.studentReformer];
    [self.arrData addObjectsFromArray:resultData];
    self.pageIndex=[self.arrData count];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)studentListAPIManager {
    if (_studentListAPIManager == nil) {
        _studentListAPIManager = [StarStudentListAPIManger  sharedInstance];
        _studentListAPIManager.delegate=self;
        _studentListAPIManager.paramSource=self;
    }
    return _studentListAPIManager;
}

- (id<ReformerProtocol>) studentReformer{
    
    if (!_studentReformer) {
        _studentReformer=[[StudentReformer alloc] init];
    }
    return _studentReformer;
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
            [self.studentListAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{            [self.studentListAPIManager loadData];
        }];
        [_tableView registerClass:[MyCourseCell class] forCellReuseIdentifier:StudentListCellIdentifier];
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
