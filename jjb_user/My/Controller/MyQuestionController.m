//
//  MyQuestionController.m
//  jjb_user
//
//  Created by Check on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyQuestionController.h"
#import "MyQuestionCell.h"

@interface MyQuestionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *titleArr;

@end

@implementation MyQuestionController

#pragma - 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"常见问题";
    
    [self layoutPageSubviews];
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
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuestionCellIdentifier" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}


#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyQuestionCell class] forCellReuseIdentifier:@"MyQuestionCellIdentifier"];
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
