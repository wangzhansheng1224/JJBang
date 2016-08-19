//
//  issueLocationController.m
//  jjb_user
//
//  Created by Maybe on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "issueLocationController.h"

@interface issueLocationController ()
@property(nonatomic,strong) UITableView * tableView;
@end

@implementation issueLocationController


#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"所在位置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma mark - getter and setter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_WHITE;
    }
    return _tableView;
}



@end
