//
//  MyOrderPayController.m
//  jjb_user
//
//  Created by Check on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderPayController.h"

#define BTN_TAG  2000

#define Cell_Order @"CellReuseIdentifier_Order"

@interface MyOrderPayController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel * lab_line;
@property (nonatomic,strong) UIView * view_header;
@property (nonatomic,assign) int index;
@property (nonatomic,strong) NSArray * arr_title;
@property (nonatomic,strong) NSMutableArray * arr_button;
@property (nonatomic,strong) NSMutableArray * arr_noPayData;
@property (nonatomic,strong) NSMutableArray * arr_hasPayData;
@property (nonatomic,strong) NSMutableArray * arr_backPayData;
@property (nonatomic,strong) NSMutableArray * arr_allData;



@end

@implementation MyOrderPayController


#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
    [self createHeaderViewButton];
    
    [self layoutPageSubviews];
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    
    self.tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    
    self.view_header.frame = CGRectMake(0, 0, Screen_Width, 50);
    
    self.lab_line.frame = CGRectMake(0, 48, Screen_Width/4.0, 2);
    
#if 0
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.equalTo(@64);
        make.left.equalTo(@0);
        
    }];
    //    [self.view addSubview:self.view_header];
    
    [self.view_header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGPointMake(Screen_Width, 50));
        
        make.top.equalTo(@0);
        
        make.left.equalTo(@0);
    }];
    
    [self.lab_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGPointMake(Screen_Width / self.arr_title.count, 2));
        
        make.bottom.equalTo(@0);
        
        make.left.equalTo(@0);
    }];
#endif
    
}


- (void)createHeaderViewButton {
    
    for (int i = 0; i < self.arr_title.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * Screen_Width/4.0, 0, Screen_Width/4.0, 50)];
        
        button.tag = BTN_TAG + i;
        
        [button setTitle:self.arr_title[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view_header addSubview:button];
        
        if (i == 0) {
            
            button.selected = YES;
        }
        
        [self.arr_button addObject:button];
    }
    
    self.tableView.tableHeaderView = self.view_header;
    
    [self.view_header addSubview:self.lab_line];
}

#pragma -
#pragma mark - 点击事件

- (void)titleBtnClick:(UIButton *)button {
    
    NSLog(@"-------");
    
    self.index = (int)button.tag - BTN_TAG;
    
    for (int i = 0; i < self.arr_button.count; i++) {
        
        UIButton * btn = (UIButton *)self.arr_button[i];
        
        if (self.index == i) {
            
            btn.selected = YES;
        }else {
            
            btn.selected = NO;
        }
    }
    
    NSLog(@"%d",self.index);
    
    float contentOffset = self.index * Screen_Width / self.arr_title.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.lab_line.frame = CGRectMake(contentOffset, 48, Screen_Width/4.0, 2);
    }];
}


#pragma -
#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

//每个section的row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
//cell的样式设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Cell_Order];
    
    cell.backgroundColor = JJBRandomColor;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    UILabel * label = [[UILabel alloc] initWithFrame:header.bounds];
    
    label.text = @"订单号201506072921";
    
    [header addSubview:label];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001;
}


#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell_Order];
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        _tableView.estimatedRowHeight = 44.0;
    }
    return _tableView;
}

- (UIView *)view_header {
    
    if (!_view_header) {
        
        _view_header = [[UIView alloc] init];
        
    }
    return _view_header;
}

- (UILabel *)lab_line {
    
    if (!_lab_line) {
        
        _lab_line = [[UILabel alloc] init];
        
        _lab_line.backgroundColor = [UIColor orangeColor];
    }
    return _lab_line;
}

- (NSArray *)arr_title {
    
    if (!_arr_title) {
        
        _arr_title = [[NSArray alloc] initWithObjects:@"待付款", @"已付款", @"退款", @"全部订单", nil];
    }
    return _arr_title;
}

- (NSMutableArray *)arr_button {
    
    if (!_arr_button) {
        
        _arr_button = [[NSMutableArray alloc] init];
        
    }
    return _arr_button;
}

- (NSMutableArray *)arr_noPayData {
    
    if (!_arr_noPayData) {
        
        _arr_noPayData = [[NSMutableArray alloc] init];
    }
    return _arr_noPayData;
}

- (NSMutableArray *)arr_hasPayData {
    
    if (!_arr_hasPayData) {
        
        _arr_hasPayData = [[NSMutableArray alloc] init];
    }
    return _arr_hasPayData;
}

- (NSMutableArray *)arr_backPayData {
    
    if (!_arr_backPayData) {
        
        _arr_backPayData = [[NSMutableArray alloc] init];
    }
    return _arr_backPayData;
}

- (NSMutableArray *)arr_allData {
    
    if (!_arr_allData) {
        
        _arr_allData = [[NSMutableArray alloc] init];
    }
    return _arr_allData;
}


@end
