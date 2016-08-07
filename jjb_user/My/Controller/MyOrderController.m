//
//  MyOrderController.m
//  jjb_user
//
//  Created by Check on 16/8/6.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderController.h"

@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MyOrderController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
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
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    return cell;
}


#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    }
    return _tableView;
}

@end
