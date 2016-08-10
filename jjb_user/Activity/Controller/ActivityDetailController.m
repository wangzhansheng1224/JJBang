//
//  ActivityDetailController.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailController.h"
#import "ActivityDetailCell.h"
#import "ActivityInfoCell.h"
#import "ActivityDetailAPIManager.h"
#import "ActivityDetailHeader.h"
#import "HMSegmentedControl.h"

@interface ActivityDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LDAPIBaseManager *detailAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> detailReformer;
@property (nonatomic,strong) ActivityDetailHeader *headerView;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array_data;
@property (nonatomic,assign) int index;//0 1 2

@end

@implementation ActivityDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.headerView;
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index == 0) {
        //活动详情
        ActivityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetail" forIndexPath:indexPath];
        
        return cell;
        
    }else {
        //报名信息
        ActivityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityInfo" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.tabbarControl;
}



#pragma -
#pragma mark - event response

- (void) tabbarControllChangeValue:(id)sender{
    
}


- (void)joinClick {

    NSLog(@"------立即报名------");
}


#pragma -
#pragma mark - getters and setters

- (ActivityDetailHeader *) headerView{
    if (!_headerView) {
        _headerView=[[ActivityDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 273)];
        _headerView.backgroundColor=COLOR_WHITE;
    }
   return _headerView;
}

- (HMSegmentedControl *) tabbarControl
{
    if (!_tabbarControl) {
        _tabbarControl=[[HMSegmentedControl alloc] initWithSectionTitles:@[@"活动详情",@"报名信息",@"评价信息"]];
        _tabbarControl.selectionIndicatorColor=COLOR_ORANGE;
        _tabbarControl.titleTextAttributes=@{NSForegroundColorAttributeName:COLOR_GRAY,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation=HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight=2.0f;
        [_tabbarControl addTarget:self action:@selector(tabbarControllChangeValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tabbarControl;
}

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_tableView registerClass:[ActivityDetailCell class] forCellReuseIdentifier:@"ActivityDetail"];
        [_tableView registerClass:[ActivityInfoCell class] forCellReuseIdentifier:@"ActivityInfo"];
        
    }
    return _tableView;
}


- (NSMutableArray *)array_data {

    if (!_array_data) {
        
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

@end
