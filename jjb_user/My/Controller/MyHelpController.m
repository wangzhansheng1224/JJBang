//
//  MyHelpController.m
//  jjb_user    帮助反馈
//
//  Created by Check on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyHelpController.h"
#import "MyHelpCell.h"
#import "MyCommentController.h"
#import "MyQuestionController.h"
#import "ExplainLevelController.h"

@interface MyHelpController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *titleArr;

@end

@implementation MyHelpController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助与反馈";
    self.view.backgroundColor = COLOR_WHITE;
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
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.left.equalTo(@0);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyHelpCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.row < self.titleArr.count) {
        
        cell.title = self.titleArr[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyCommentController *commentVC = [[MyCommentController alloc] init];
        [self.navigationController pushViewController:commentVC animated:YES];
    }else if (indexPath.row == 1) {
//        MyQuestionController *questionVC = [[MyQuestionController alloc] init];
//        [self.navigationController pushViewController:questionVC animated:YES];
    }else {
        ExplainLevelController *controller = [[ExplainLevelController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyHelpCell class] forCellReuseIdentifier:@"MyHelpCellIdentifier"];
    }
    return _tableView;
}

- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {
        
        _titleArr = [[NSMutableArray alloc] init];
        NSArray *array = @[@"意见反馈",@"常见问题",@"网络诊断"];
        _titleArr = [NSMutableArray arrayWithArray:array];
    }
    return _titleArr;
}

@end
