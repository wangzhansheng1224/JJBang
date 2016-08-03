//
//  ActivityListController.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListController.h"
#import "ActivityListCell.h"
#import "ActivityDetailController.h"

#define SIZE [UIScreen mainScreen].bounds.size

@interface ActivityListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) ActivityDetailController *detail;

@end

@implementation ActivityListController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadData];
    
    [self.view addSubview:self.tableView];
}


- (void)loadData {
    
}



#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"List"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 340;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString *str=_dataDic[_array[indexPath.section]][indexPath.row];
//    vc.name=str;

//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.detail animated:YES];
}

#pragma mark -- getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height-40);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:@"List"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}

- (ActivityDetailController *)detail {

    if (!_detail) {
        
        _detail = [[ActivityDetailController alloc] init];
    }
    return _detail;
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
