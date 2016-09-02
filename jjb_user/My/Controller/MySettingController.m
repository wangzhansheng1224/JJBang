//
//  MySettingController.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MySettingController.h"
#import "MySettingCell.h"
#import "MySettingIconCell.h"
#import "MySettingDetailController.h"
#import "FindPassWordViewController.h"
#import "ChangeHeaderIconController.h"

@interface MySettingController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * arr_title;
@property (nonatomic,strong) NSMutableArray * arr_content;
@property (nonatomic,strong) UIButton * quitButton; //退出按钮
//@property(nonatomic,strong) MySettingIconCell * mySettingIconCell;

@end

@implementation MySettingController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = NO;
//    [self.tableView reloadData];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
    [self.quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tableView.mas_centerX);
        make.top.equalTo(self.tableView.mas_top).offset(326);
        make.left.equalTo(self.tableView.mas_left).offset(30);
    }];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arr_title.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MySettingIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySettingIconCellIdentifier" forIndexPath:indexPath];
        
        NSURL * url = [NSURL initWithImageURL:[UserModel currentUser].photo Width:100 Height:100];
        [cell.iconImageV setHeader:url];


        return cell;
    }else {
        MySettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MySettingCellIdentifier" forIndexPath:indexPath];
        if (indexPath.row < self.arr_title.count) {
        cell.title = self.arr_title[indexPath.row];
        cell.content = self.arr_content[indexPath.row];
        }
        if (indexPath.row == 1) {
//            cell.rightImageV.image = nil;
        }else if (indexPath.row == 4) {
            cell.rightImageV.image = nil;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MySettingDetailController * detail = [[MySettingDetailController alloc] init];
    if (indexPath.row == 0) {
        ChangeHeaderIconController *changeHeader = [[ChangeHeaderIconController alloc] init];
        [self.navigationController pushViewController:changeHeader animated:YES];
    }else if (indexPath.row == 1) {
        detail.name = self.arr_title[indexPath.row];
        detail.block = ^(NSString * content){
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (indexPath.row == 2) {
        detail.sign = self.arr_title[indexPath.row];
        detail.block = ^(NSString * content) {
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.row == 3) {
        FindPassWordViewController *findPassWord = [[FindPassWordViewController alloc] init];
        [self.navigationController pushViewController:findPassWord animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma -
#pragma mark - getters and setters
-(void)quit:(UIButton *)btn
{
    [UserModel removeUser];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -
#pragma mark - getters and setters
- (NSMutableArray *)arr_title {
    if (!_arr_title) {
        NSArray * array = @[@"",@"昵称", @"个性签名", @"账户密码", @"手机号"];
        _arr_title = [NSMutableArray arrayWithArray:array];
    }
    return _arr_title;
}
- (NSMutableArray *)arr_content {
    if (!_arr_content) {
        NSArray * array = @[@"",[UserModel currentUser].nickName, [UserModel currentUser].signature, @"重置密码", [UserModel currentUser].phone];
        _arr_content = [NSMutableArray arrayWithArray:array];
    }
    return _arr_content;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[MySettingCell class] forCellReuseIdentifier:@"MySettingCellIdentifier"];
        [_tableView registerClass:[MySettingIconCell class] forCellReuseIdentifier:@"MySettingIconCellIdentifier"];

    }
    return _tableView;
}

-(UIButton *)quitButton
{
    if (_quitButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        [button setBackgroundColor:COLOR_ORANGE];
        [button addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor whiteColor];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        _quitButton = button;
        [self.tableView addSubview:_quitButton];
    }
    return _quitButton;
}

@end
