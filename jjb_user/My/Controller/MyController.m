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
#import "ExplainLevelController.h"
#import "ContactServiceController.h"
#import "ImgModel.h"
#import "ChangeHeaderIconController.h"
#import "MyFamilyCell.h"
#import "MyFamilyController.h"


@interface MyController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MineHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *array_data;
@property (nonatomic,strong) UITapGestureRecognizer *tapGR;
//记录tableview偏移量
@property (nonatomic,assign) CGFloat orginOffsetY;
@property(nonatomic,assign) CGFloat myheadH;
//背景图片的高度约束
@property (nonatomic,strong) NSLayoutConstraint * headViewConstraintH;

@end


@implementation MyController


#define HeadMinH 0
#define TabH 44
#define HeadH 278

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.headerView;
    [self configMasonry];
    [self loadData];
//    [self layoutSubViews];
    
    /*
    self.orginOffsetY = -(HeadH+TabH);
    self.tableView.contentInset = UIEdgeInsetsMake(HeadH+TabH, 0, 0, 0);
    self.headerView.topImage.clipsToBounds = YES;
    */
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerView configWithData:[UserModel currentUser]];
    self.navigationController.navigationBarHidden = YES;
    NSURL * url = [NSURL initWithImageURL:[UserModel currentUser].photo Width:100 Height:100];
    [self.headerView.itemImage setHeader:url];

    UIViewController *controller = [[CTMediator sharedInstance]CTMediator_CheckIsLogin];
    if (controller == nil) {
        self.headerView.isLogin = YES;
    }else {
        self.headerView.isLogin = NO;
    }
    [self.tableView reloadData];
}

#pragma -
#pragma - mark autoLayout
-(void)layoutSubViews
{
    self.headViewConstraintH = [NSLayoutConstraint constraintWithItem:self.headerView.topImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:278.0f];

    NSLayoutConstraint *Top = [NSLayoutConstraint constraintWithItem:self.headerView.topImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.headerView.topImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.headerView.topImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.headerView.topImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    
    [self.headerView.topImage addConstraint:self.headViewConstraintH];
    [self.view addConstraint:Top];
    [self.view addConstraint:left];
    [self.view addConstraint:right];
    [self.headerView addConstraint:bottom];
    
}

#pragma -
#pragma mark - CustomMethods
- (void)loadData {
    
    NSArray *array_image1 = @[@""];
    NSArray * array_title1 = @[@"我的家庭"];
    NSMutableArray * array_section1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < array_image1.count; i++) {
        MineModel * model = [[MineModel alloc] init];
        model.image = array_image1[i];
        model.title = array_title1[i];
        [array_section1 addObject:model];
    }
    [self.dataArr addObject:array_section1];
    
    NSArray *array_image2 = @[@"my_order", @"my_course"];
    NSArray * array_title2 = @[@"我的订单", @"我的课程"];
    NSMutableArray * array_section2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < array_image2.count; i++) {
        MineModel * model = [[MineModel alloc] init];
        model.image = array_image2[i];
        model.title = array_title2[i];
        [array_section2 addObject:model];
    }
    [self.dataArr addObject:array_section2];
    NSArray * array_image3 = @[@"my_help", @"my_service", @"my_more"];
    NSArray * array_title3 = @[@"帮助与反馈", @"联系客服", @"更多"];
    NSMutableArray * array_section3 = [[NSMutableArray alloc] init];
    for (int i = 0; i < array_image3.count; i++) {
        MineModel * model = [[MineModel alloc] init];
        model.image = array_image3[i];
        model.title = array_title3[i];
        [array_section3 addObject:model];
    }
    [self.dataArr addObject:array_section3];
}


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
    if (indexPath.section == 0) {
        MyFamilyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyFamilyCellIdentifier" forIndexPath:indexPath];
        UIViewController *controller = [[CTMediator sharedInstance]CTMediator_CheckIsLogin];
        if (controller == nil) {
            
            [cell configWithData:[UserModel currentUser].myFamily.family_member];
        }else {
            
            [cell configWithData:@[]];
        }
        return cell;
    }else {
        MineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCellIdentifier" forIndexPath:indexPath];
    
        if (indexPath.row < [self.dataArr[indexPath.section] count]) {
        
            MineModel * model = self.dataArr[indexPath.section][indexPath.row];
        
            [cell refreshCellWithModel:model];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160.0f;
    }
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
            MyFamilyController *family = [[MyFamilyController alloc] init];
            family.dataArr = [UserModel currentUser].myFamily.family_member;
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:family];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MyOrderPayController *order = [[MyOrderPayController alloc] init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:order];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 1) {
            MyCourseController *course=[[MyCourseController alloc] init];
         UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:course];
        [self.navigationController pushViewController:controller animated:YES];
        }else {
            ExplainLevelController *controller = [[ExplainLevelController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }else {
        if (indexPath.row == 0) {
            MyHelpController *helpVC = [[MyHelpController alloc] init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:helpVC];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 1) {
            ContactServiceController *contactService = [[ContactServiceController alloc] init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:contactService];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 2) {
            MyMoreController *myMoreVC=[[MyMoreController alloc]init];
            UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:myMoreVC];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


#pragma -
#pragma mark - UIScrollViewDelegate
/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    CGFloat delta = currentOffsetY - self.orginOffsetY;
//    CGFloat headH = self.headerView.height - delta;
    self.myheadH = HeadH - delta;
    if (self.myheadH < HeadMinH) {
        self.myheadH = HeadMinH;
        JJBLog(@"上上%lf",self.myheadH);
    }
    self.headViewConstraintH.constant = self.myheadH;
    JJBLog(@"上上%lf",self.myheadH);

    
}
*/

#pragma mark -- getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCellIdentifier"];
        [_tableView registerClass:[MyFamilyCell class] forCellReuseIdentifier:@"MyFamilyCellIdentifier"];
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
