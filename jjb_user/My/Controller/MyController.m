//
//  MyController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//
/**
 *  个人主控制器
 */
#import "MyController.h"
#import <Masonry.h>
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
#import "MyCourseController.h"


@interface MyController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *array_data;

@property (nonatomic,strong) MyCourseController *myCourseVC;

@end


@implementation MyController
#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
    [self createTableHeaderView];
    
    [self configMasonry];
}
#pragma -
#pragma mark - CustomMethods
- (void)loadData {
    
    NSArray *array_image1 = @[@"", @"", @""];
    
    NSArray * array_title1 = @[@"我的订单", @"我的课程", @"我的评价"];
    
    NSMutableArray * array_section1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array_image1.count; i++) {
        
        MineModel * model = [[MineModel alloc] init];
        
        model.image = array_image1[i];
        
        model.title = array_title1[i];
        
        [array_section1 addObject:model];
        
    }
    
    [self.dataArr addObject:array_section1];
    
    NSArray * array_image2 = @[@"", @"", @""];
    
    NSArray * array_title2 = @[@"帮助与反馈", @"联系客服", @"更多"];
    
    NSMutableArray * array_section2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array_image2.count; i++) {
        
        MineModel * model = [[MineModel alloc] init];
        
        model.image = array_image2[i];
        
        model.title = array_title2[i];
        
        [array_section2 addObject:model];
    }
    
    [self.dataArr addObject:array_section2];
}

#pragma mark -- tableView headerView
- (void)createTableHeaderView {
    
    MineHeaderView * headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 250)];
    
    headerView.topImageView = @"";
    
    headerView.emailButton = @"";
    
    headerView.setButton = @"";
    
    headerView.itemImageView = @"";
    
    headerView.name = @"亓凯";
    
    headerView.sign = @"爱生活爱自己";
    
    headerView.levelTitle = @"黄金会员";
    
    headerView.levelImage = @"";
    
    headerView.money = @"88.88";
    
    headerView.ad = @"门店超市";
    
    [headerView setBtnAddTarget:self action:@selector(setBtnClick:)];
    
    [headerView emailBtnAddTarget:self action:@selector(emailBtnClick:)];
    
    [headerView levelBtnAddTarget:self action:@selector(levelBtnClick:)];
    
    [headerView moneyBtnAddTarget:self action:@selector(moneyBtnClick:)];
    
    [headerView adBtnAddTarget:self action:@selector(adBtnClick:)];
    
    self.tableView.tableHeaderView = headerView;
}


#pragma mark -- Masonry
- (void)configMasonry {

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.bottom.equalTo(@-49);
        make.left.right.equalTo(@0);
    }];
}





#pragma mark -- event response

- (void)setBtnClick:(UIButton *)setBtn {
    
    NSLog(@"我是设置按钮");
}

- (void)emailBtnClick:(UIButton *)emailBtn {
    
    NSLog(@"我是邮件按钮");
}

- (void)levelBtnClick:(UIButton *)levelBtn {
    
    NSLog(@"我是会员按钮");
}

- (void)moneyBtnClick:(UIButton *)moneyBtn {
    
    NSLog(@"我是余额按钮");
}

- (void)adBtnClick:(UIButton *)adBtn {
    
    NSLog(@"我是广告按钮");
}



#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row < [self.dataArr[indexPath.section] count]) {
        
        MineModel * model = self.dataArr[indexPath.section][indexPath.row];
        
        [cell refreshCellWithModel:model];
        
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
            [self.navigationController pushViewController:self.myCourseVC animated:YES];
        }
    }
}


#pragma mark -- getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 64, SIZE.width, SIZE.height-64 -40);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    
    if (!_array_data) {
        
        _array_data = [NSMutableArray array];
    }
    return _array_data;
}

- (MyCourseController *)myCourseVC{
    
    if (!_myCourseVC) {
        
        _myCourseVC = [[MyCourseController alloc] init];
    }
    return _myCourseVC;
}

@end
