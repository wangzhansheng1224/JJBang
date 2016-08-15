//
//  StudentDetailController.m
//  jjb_user    学员详情
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailController.h"
#import "GrowingCell.h"
#import "StudentDetailHeader.h"

static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";

@interface StudentDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) StudentDetailHeader *headerView;

@end

@implementation StudentDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
}

#pragma -
#pragma mark - event response
- (void)tabBarControlChangeValue:(HMSegmentedControl *)change {

//    if (self.tabbarControl.selectedSegmentIndex==1) {
//        [self.arrRegistrationData removeAllObjects];
//        self.pageIndex=0;
//        [self loadData];
//    }
//    [self.tableView reloadData];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.tabbarControl;
}


#pragma -
#pragma mark - getters and setters
- (HMSegmentedControl *)tabbarControl {

    if (!_tabbarControl) {
        
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"我的成长",@"我的课程"]];
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
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {

    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (StudentDetailHeader *)headerView {

    if (!_headerView) {
        
        _headerView = [[StudentDetailHeader alloc] initWithFrame:(CGRectMake(0, 0, Screen_Width, 202))];
        _headerView.backgroundColor = COLOR_WHITE;
    }
    return _headerView;
}

@end
