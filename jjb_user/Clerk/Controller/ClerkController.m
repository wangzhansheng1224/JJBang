//
//  ClerkController.m
//  jjb_user
//
//  Created by Maybe on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkController.h"
/**
 *  店员界面
 */
@interface ClerkController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ClerkController


#pragma
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    self.title=@"店员详情";
}


#pragma -
#pragma mark - getter and setter
//-(UITableView *)tableView
//{
//    if (!_tableView) {
//        
//        _tableView = [[UITableView alloc] init];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            if (self.tabbarControl.selectedSegmentIndex==1) {
//                [self.GrowingTreeDataArr removeAllObjects];
//                self.growingIndex=0;
//                [self.MyGrowingAPIManager loadData];
//            }
//            else{
//                [self.detailAPIManager loadData];
//            }
//        }];
//        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            if (self.tabbarControl.selectedSegmentIndex==1) {
//                [self.MyGrowingAPIManager loadData];
//            }
//            else{
//                [self.detailAPIManager loadData];
//            }
//        }];
//        [_tableView registerClass:[TeacherDetailCell class] forCellReuseIdentifier:TeacherDetailCellIdentifier];
//        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
//    }
//    return _tableView;
//}
@end
