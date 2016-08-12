//
//  MyOrderDetailController.m
//  jjb_user
//
//  Created by Maybe on 16/8/11.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderDetailController.h"
#import "MyOrderDetailCell.h"
/**
 *  明细界面
 */
@interface MyOrderDetailController ()
@property(nonatomic,strong) NSMutableArray * listArray;
@end

static NSString * const MyOrderDetailCellIdentifier = @"MyOrderDetailCellIdentifier";
@implementation MyOrderDetailController

#pragma 
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"明细";
    [self.tableView registerClass:[MyOrderDetailCell class] forCellReuseIdentifier:MyOrderDetailCellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma 
#pragma mark - UITableViewDelegate and UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderDetailCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MyOrderDetailCellIdentifier];
    if (cell == nil) {
        cell = [[MyOrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyOrderDetailCellIdentifier];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

#pragma 
#pragma mark - getter and setter
-(NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
