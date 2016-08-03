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
#import "ActivityListReformer.h"
#import "ActivityDetailController.h"

static NSString  *const ActivityListCellIdentifier=@"ActivityListCellIdentifier";

@interface ActivityListController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) LDAPIBaseManager *activityListAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> activityListReformer;

@property (nonatomic,strong) ActivityDetailController *detail;

@end

@implementation ActivityListController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.activityListAPIManager loadData];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityListCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActivityListCellIdentifier];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 340;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.activityListReformer];
    
    [self.arrData addObjectsFromArray:resultData];

}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{@"shop_id":@"3",@"user_id":@"1",@"start":@"0",@"count":@"10",@"isOwn":@"0"};
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString *str=_dataDic[_array[indexPath.section]][indexPath.row];
//    vc.name=str;

//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.detail animated:YES];
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

 - (id<ReformerProtocol>) activityListReformer{
    
     if (!_activityListReformer) {
         _activityListReformer=[[ActivityListReformer alloc] init];
     }
     return _activityListReformer;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height-40);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:ActivityListCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)arrData{
    
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
    
}

- (ActivityDetailController *)detail {

    if (!_detail) {
        
        _detail = [[ActivityDetailController alloc] init];
    }
    return _detail;
}


@end
