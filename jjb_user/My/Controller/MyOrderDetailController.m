//
//  MyOrderDetailController.m
//  jjb_user
//
//  Created by Maybe on 16/8/11.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderDetailController.h"
#import "MyOrderDetailCell.h"
#import "MyOrderDetailAPIManager.h"
#import "MyOrderDetailReformer.h"
/**
 *  明细界面
 */
@interface MyOrderDetailController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property(nonatomic,strong) NSMutableArray * listArray;
@property(nonatomic,strong)LDAPIBaseManager * MyOrderDetailAPIManagerx;
@property(nonatomic,strong)id<ReformerProtocol> MyOrderReformer;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@end

static NSString * const MyOrderDetailCellIdentifier = @"MyOrderDetailCellIdentifier";
@implementation MyOrderDetailController

#pragma 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"明细";
    [self.tableView registerClass:[MyOrderDetailCell class] forCellReuseIdentifier:MyOrderDetailCellIdentifier];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.listArray removeAllObjects];
        self.pageIndex=0;
        [self.MyOrderDetailAPIManagerx loadData];
    }];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.MyOrderDetailAPIManagerx loadData];
    }];

    self.pageSize=10;
    self.pageIndex=0;
    [self.MyOrderDetailAPIManagerx loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma 
#pragma mark - UITableViewDelegate and UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderDetailCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MyOrderDetailCellIdentifier];
    if (cell == nil) {
        cell = [[MyOrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyOrderDetailCellIdentifier];
    }
    [cell configWithData:self.listArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}


#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{

    NSArray *resultData = [manager fetchDataWithReformer:self.MyOrderReformer];
    [self.listArray addObjectsFromArray:resultData];
    self.pageIndex=[self.listArray count];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager
{
    if([manager isKindOfClass:[MyOrderDetailAPIManager class]])
    {
        //用户ID/消费类型/开始条数/返回条数
            ((MyOrderDetailAPIManager *)manager).methodName =  [NSString stringWithFormat:@"gateway/order/%@/%d/%@/%@",@([UserModel currentUser].userID),1,@(self.pageIndex),@(self.pageSize)];
    }
    return nil;
}



#pragma -
#pragma mark - getter and setter
-(NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
-(LDAPIBaseManager *)MyOrderDetailAPIManagerx
{
    if (_MyOrderDetailAPIManagerx == nil) {
        _MyOrderDetailAPIManagerx = [MyOrderDetailAPIManager sharedInstance];
        _MyOrderDetailAPIManagerx.delegate = self;
        _MyOrderDetailAPIManagerx.paramSource = self;
    }
    return _MyOrderDetailAPIManagerx;
}
-(id<ReformerProtocol>)MyOrderReformer
{
    if (_MyOrderReformer == nil) {
        _MyOrderReformer = [[MyOrderDetailReformer alloc]init];
    }
    return _MyOrderReformer;
}
@end
