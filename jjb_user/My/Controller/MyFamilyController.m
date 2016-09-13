//
//  MyFamilyController.m
//  jjb_user 我的家庭
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyFamilyController.h"
#import "MyFamilyDetailCell.h"
#import "MyFamilyInsertController.h"

@interface MyFamilyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIBarButtonItem *addItem;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MyFamilyController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"我的家庭";
    self.navigationItem.rightBarButtonItem = self.addItem;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height - 64));
        make.top.left.equalTo(@0);
    }];
}


#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyFamilyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyFamilyDetailCellIdentifier" forIndexPath:indexPath];
    [cell configWithData:self.dataArr[indexPath.row]];;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyFamilyInsertController *insert = [[MyFamilyInsertController alloc] init];
    [self.navigationController pushViewController:insert animated:YES];
}

#pragma -
#pragma mark - event respone
- (void)addItemClick {
    MyFamilyInsertController *insert = [[MyFamilyInsertController alloc] init];
    [self.navigationController pushViewController:insert animated:YES];
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
//        //判断列表数据>=10时才出现上提请求
//        if ([self.arrData count] >=10){
//            _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                [self.growingTreeListAPIManager loadData];
//            }];
//        }
        [_tableView registerClass:[MyFamilyDetailCell class] forCellReuseIdentifier:@"MyFamilyDetailCellIdentifier"];
    }
    return _tableView;
}

- (UIBarButtonItem *)addItem {
    if (!_addItem) {
        _addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addItemClick)];
        _addItem.tintColor = COLOR_WHITE;
    }
    return _addItem;
}

@end
