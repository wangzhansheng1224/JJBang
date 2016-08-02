//
//  ActivityListController.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListController.h"
#import "ActivityListCell.h"

#define SIZE [UIScreen mainScreen].bounds.size

@interface ActivityListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ActivityListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    
    [self loadData];
    
    [self createTableView];
}


- (void)initData {
    
}

- (void)loadData {
    
}

#pragma mark -- CreateTableView
- (void)createTableView {
    
    self.tableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height-40);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:@"ID"];
    
    [self.view addSubview:self.tableView];
}



#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 340;
}

#pragma mark -- getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
