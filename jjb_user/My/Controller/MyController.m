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
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
#import "MyCourseController.h"
#import "MyMoreController.h"
#import "LoginViewController.h"
#import "MySettingController.h"
#import "StudentController.h"
#import "MyOrderPayController.h"
#import "MyBalanceViewController.h"
#import "MyHelpController.h"


@interface MyController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MineHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *array_data;
@end


@implementation MyController
#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.headerView;
    [self configMasonry];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerView configWithData:[UserModel currentUser]];
    self.navigationController.navigationBarHidden = YES;
}

#pragma -
#pragma mark - CustomMethods
- (void)loadData {
    
    NSArray *array_image1 = @[@"my_order", @"my_course", @"my_evaluate"];
    
    NSArray * array_title1 = @[@"我的订单", @"我的课程", @"我的评价"];
    
    NSMutableArray * array_section1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array_image1.count; i++) {
        
        MineModel * model = [[MineModel alloc] init];
        
        model.image = array_image1[i];
        
        model.title = array_title1[i];
        
        [array_section1 addObject:model];
        
    }
    
    [self.dataArr addObject:array_section1];
    
    NSArray * array_image2 = @[@"my_help", @"my_service", @"my_more"];
    
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



#pragma mark -- Masonry
- (void)configMasonry {
    UIView* superView=self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).with.offset(-20);
        make.bottom.equalTo(superView.mas_bottom);
        make.width.equalTo(superView.mas_width);
        make.height.equalTo(@(Screen_Height));
    }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MyOrderPayController *order = [[MyOrderPayController alloc] init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:order];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 1) {
            MyCourseController *course=[[MyCourseController alloc] init];
         UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:course];
        [self.navigationController pushViewController:controller animated:YES];
        }else {
        
            [self.view makeToast:@"敬请期待"];
        }
        
    }else {
    
        if (indexPath.row == 0) {
            MyHelpController *helpVC = [[MyHelpController alloc] init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:helpVC];
            [self.navigationController pushViewController:controller animated:YES];
        }
        
        if (indexPath.row == 1) {
        
            [self.view makeToast:@"敬请期待"];
        }
        if (indexPath.row == 2) {
            MyMoreController *myMoreVC=[[MyMoreController alloc]init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:myMoreVC];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


#pragma mark -- getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (MineHeaderView*)headerView {
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 194.0f+84.0f)];
    }
    return _headerView;
}

- (NSMutableArray *)dataArr{
    
    if (!_array_data) {
        
        _array_data = [NSMutableArray array];
    }
    return _array_data;
}

@end
