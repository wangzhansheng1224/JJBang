//
//  TeacherListController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherListController.h"
#import "StarTeacherCell.h"
#import "StarTeacherListAPIManager.h"
#import "TeacherReformer.h"

static NSString  *const TeacherListCellIdentifier=@"TeacherListCellIdentifier";
@interface TeacherListController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *apiManager;
@property (nonatomic,strong) id<ReformerProtocol> teacherReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation TeacherListController

#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"明星老师111";
    self.view.backgroundColor=JJBRandomColor;
    self.pageSize=10;
    self.pageIndex=0;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.apiManager loadData];
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
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StarTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:TeacherListCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[StarTeacherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TeacherListCellIdentifier];
    }
   // [cell configWithData:self.arrData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 148;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.teacherReformer];
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
             @"shop_id":[[NSUserDefaults standardUserDefaults]objectForKey:@"currenShopID"],
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)apiManager {
    if (_apiManager == nil) {
        _apiManager = [StarTeacherListAPIManager  sharedInstance];
        _apiManager.delegate=self;
        _apiManager.paramSource=self;
    }
    return _apiManager;
}

- (id<ReformerProtocol>) teacherReformer{
    
    if (!_teacherReformer) {
        _teacherReformer=[[TeacherReformer alloc] init];
    }
    return _teacherReformer;
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=COLOR_ORANGE;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.apiManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{            [self.apiManager loadData];
        }];
        [_tableView registerClass:[StarTeacherCell class] forCellReuseIdentifier:TeacherListCellIdentifier];
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