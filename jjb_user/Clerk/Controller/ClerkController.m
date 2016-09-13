//
//  ClerkController.m
//  jjb_user
//
//  Created by Maybe on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkController.h"
#import "ClerkDetailHeaderView.h"
#import "GrowingCell.h"
#import "ClerkDetailCell.h"
#import "ClerkDetailAPIManager.h"
#import "ClerkDetailReformer.h"
#import "ClerkDetailCell.h"
/**
 *  店员界面
 */
static NSString * const ClerkDetailCellIdentifier = @"ClerkDetailCellIdentifier";
static NSString * const ClerkDetailGrowingCellIdentifier = @"ClerkDetailGrowingCellIdentifier";

@interface ClerkController ()<UITableViewDataSource,UITableViewDelegate,LDAPIManagerParamSourceDelegate,LDAPIManagerApiCallBackDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)HMSegmentedControl * tabbarControl;
@property(nonatomic,strong)ClerkDetailHeaderView * headerView;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)ClerkDetailAPIManager * detailAPIManager;
@property(nonatomic,strong)id<ReformerProtocol> detailReformer;
@property(nonatomic,strong)NSDictionary * detailDictionary;
@end


@implementation ClerkController


#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    self.title=@"店员首页";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self.detailAPIManager loadData];
    
}

#pragma -
#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClerkDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:ClerkDetailCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ClerkDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ClerkDetailCellIdentifier];
    }

    [cell configWithData:self.detailDictionary];
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_tabbarControl.selectedSegmentIndex == 1) {
//        
//        NSDictionary * dic = self.growTreeDataArray[indexPath.row];
//        self.imageArray = dic[kGrowingTreeListImages];
//        
//        CGSize size = [dic[kGrowingTreeListContent] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H2} context:nil].size;
//        
//        float height = size.height;
//        
//        if ([dic[kGrowingTreeListContent] length] <= 0) {
//            
//            height = 0;
//        }
//        
//        if (self.imageArray.count == 0) {
//            
//            return 92 + height;
//            
//        }else {
//            return (self.imageArray.count+2)/3 *85 +92 + height;
//        }
//    } else {
        return Screen_Height-204-44;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.tabbarControl;
}





#pragma -
#pragma - mark event respons
-(void)tabBarControlChangeValue:(id)sender
{
    [self.tableView reloadData];
}


#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[ClerkDetailAPIManager class]])
    {
        self.detailDictionary = [manager fetchDataWithReformer:self.detailReformer];
        JJBLog(@"self.detailDictionary=%@",self.detailDictionary);
        [self.headerView configWithData:self.detailDictionary];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{

    if ([manager isKindOfClass:[ClerkDetailAPIManager class]]) {
        return @{
                 @"empyId":@(self.clerkID)
                 };
    }
    return nil;
}


#pragma -
#pragma mark - getter and setter
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self.detailAPIManager loadData];
            
        }];
    
        [_tableView registerClass:[ClerkDetailCell class] forCellReuseIdentifier:ClerkDetailCellIdentifier];
    }
    return _tableView;
}


-(LDAPIBaseManager *)detailAPIManager
{
    if (_detailAPIManager == nil) {
        _detailAPIManager = [ClerkDetailAPIManager sharedInstance];
        _detailAPIManager.delegate = self;
        _detailAPIManager.paramSource = self;
    }
    return _detailAPIManager;
}
-(id<ReformerProtocol>)detailReformer
{
    if (_detailReformer == nil) {
        _detailReformer = [[ClerkDetailReformer alloc]init];
    }
    return _detailReformer;
}

-(NSDictionary *)detailDictionary{
    if (_detailDictionary == nil) {
        _detailDictionary = [[NSDictionary alloc]init];
    }
    return _detailDictionary;

}
-(HMSegmentedControl *)tabbarControl
{
    if (_tabbarControl == nil) {
        _tabbarControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"店员介绍"]];
        _tabbarControl.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_GRAY,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight = 2.0f;
        [_tabbarControl addTarget:self action:@selector(tabBarControlChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabbarControl;

}
-(ClerkDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[ClerkDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 197+10)];
        _headerView.backgroundColor = COLOR_WHITE;
        
    }
    return _headerView;
}
@end
