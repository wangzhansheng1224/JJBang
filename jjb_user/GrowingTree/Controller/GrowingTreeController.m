//
//  GrowingTreeController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingTreeController.h"
#import "GrowingCell.h"
#import "IssueController.h"
#import "GrowingTreeListAPIManager.h"



static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";

@interface GrowingTreeController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) LDAPIBaseManager *growingTreeListAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIButton *issueBtn;

@property (nonatomic,strong) IssueController *issueVC;

@end

@implementation GrowingTreeController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"社区动态";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.issueBtn];
    [self layoutPageSubviews];
    [self.growingTreeListAPIManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView = self.view;
    [self.issueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@50);
                make.height.mas_equalTo(@50);
                make.bottom.mas_equalTo(superView.mas_bottom).offset(-50);
                make.right.mas_equalTo(superView.mas_right).offset(-50);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:GrowingCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GrowingCellIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 210;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary *reformedShopIndexData = [manager fetchDataWithReformer:self.growingTreeListReformer];
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"shop_id":@"1",
             @"type":@"2",
             @"start":@"1",
             @"count":@"20"
             };
}

#pragma -
#pragma mark - event response
- (void)btnClick:(UIButton *)btn {
    
    [self.navigationController pushViewController:self.issueVC animated:YES];
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 64, Screen_Width, Screen_Height-64 -40);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}

- (UIButton *)issueBtn {

    if (!_issueBtn) {
        
        _issueBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_issueBtn setImage:[UIImage imageNamed:@"release"] forState:UIControlStateNormal];
        [_issueBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _issueBtn;
}

- (IssueController *)issueVC {

    if (!_issueVC) {
        
        _issueVC = [[IssueController alloc] init];
    }
    return _issueVC;
}

- (LDAPIBaseManager *)growingTreeListAPIManager {
    if (_growingTreeListAPIManager == nil) {
        _growingTreeListAPIManager = [GrowingTreeListAPIManager  sharedInstance];
        _growingTreeListAPIManager.delegate=self;
        _growingTreeListAPIManager.paramSource=self;
    }
    return _growingTreeListAPIManager;
}
@end
