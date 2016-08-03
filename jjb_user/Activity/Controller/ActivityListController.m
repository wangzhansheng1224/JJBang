//
//  ActivityListController.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListController.h"
#import "ActivityListCell.h"
#import "ActivityListAPIManager.h"

#define SIZE [UIScreen mainScreen].bounds.size

@interface ActivityListController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) LDAPIBaseManager *activityListAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> activityListReformer;

@end

@implementation ActivityListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    [self.activityListAPIManager loadData];
    [self createTableView];
}


- (void)initData {
    
}

- (void)loadData {
    
}

#pragma mark -- CreateTableView
- (void)createTableView {
    
    self.tableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height-40);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:@"ID"];
    
    [self.view addSubview:self.tableView];
}



#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 340;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary *reformedShopIndexData = [manager fetchDataWithReformer:self.activityListReformer];
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{@"shop_id":@"1",@"user_id":@"1",@"start":@"0",@"count":@"20"};
}

#pragma -
#pragma mark - getters and setters

- (LDAPIBaseManager *)activityListAPIManager {
    if (_activityListAPIManager == nil) {
        _activityListAPIManager = [ActivityListAPIManager  sharedInstance];
        _activityListAPIManager.delegate=self;
        _activityListAPIManager.paramSource=self;
    }
    return _activityListAPIManager;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
