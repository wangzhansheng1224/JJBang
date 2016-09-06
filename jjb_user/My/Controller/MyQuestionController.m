//
//  MyQuestionController.m
//  jjb_user    常见问题
//
//  Created by Check on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyQuestionController.h"
#import "MyQuestionCell.h"
#import "MyQuestionSectionView.h"

@interface MyQuestionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *titleArr;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *boolArr;


@end

@implementation MyQuestionController
#pragma - 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"常见问题";
    [self.view addSubview:self.tableView];
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
    if (![self.boolArr[section] boolValue]) {
        return 0;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuestionCellIdentifier" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    MyQuestionSectionView * sectionView = [[MyQuestionSectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
    sectionView.titleLabel.text = self.titleArr[section];
    sectionView.tag = 1000+section;
    sectionView.backgroundColor = COLOR_WHITE;
    if ([self.boolArr[section] boolValue]) {
        sectionView.rightImageV.image = [UIImage imageNamed:@"course_up"];
    }else {
        sectionView.rightImageV.image = [UIImage imageNamed:@"course_down"];
//        sectionView.rightImageV.image = nil;

    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [sectionView addGestureRecognizer:tap];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001;
}

#pragma -
#pragma mark - event respone
- (void)tapGR:(UITapGestureRecognizer *)tapGR{
    //获取section
    NSInteger section = tapGR.view.tag - 1000;
    //判断改变bool值
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    //刷新section
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyQuestionCell class] forCellReuseIdentifier:@"MyQuestionCellIdentifier"];
    }
    return _tableView;
}
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc] init];
        NSArray *array = @[@"支付问题",@"订单问题",@"优惠问题",@"其他问题"];
        _titleArr = [NSMutableArray arrayWithArray:array];
    }
    return _titleArr;
}

- (NSMutableArray *)boolArr {
    
    if (!_boolArr) {
        _boolArr = [[NSMutableArray alloc] init];
        NSArray *array = @[@NO,@NO,@NO,@NO];
        _boolArr = [NSMutableArray arrayWithArray:array];
    }
    return _boolArr;
}


@end
