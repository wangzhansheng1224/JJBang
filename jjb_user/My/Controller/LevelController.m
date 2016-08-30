//
//  LevelController.m
//  jjb_user
//
//  Created by Aimee on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LevelController.h"
#import "ExplainLevelController.h"
#import "ExplainLevelHeadView.h"
#import "MyNewPrivilegeCell.h"
#import "MyFeaturePrivilegecell.h"

static NSString * const MyNewPrivilegeCellIdentifier = @"MyNewPrivilegeCellIdentifier";
static NSString * const MyFeaturePrivilegeCellIdentifier = @"MyFeaturePrivilegeCellIdentifier";

@interface LevelController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) ExplainLevelHeadView * headView;



@end

@implementation LevelController
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    self.navigationItem.title = @"会员等级";
//    self.navigationItem.rightBarButtonItem = self.rightItem;

    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - event respone
- (void)itemClick {

    ExplainLevelController * explainVC = [[ExplainLevelController alloc]init];
    [self.navigationController pushViewController:explainVC animated:YES];
}

#pragma -
#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MyNewPrivilegeCell * cell = [self.tableView dequeueReusableCellWithIdentifier:MyNewPrivilegeCellIdentifier];
        return cell;

    }
    else if(indexPath.row == 1)
    {
        MyFeaturePrivilegecell * cell = [self.tableView dequeueReusableCellWithIdentifier:MyFeaturePrivilegeCellIdentifier];
        return cell;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"我的特权";
}
#pragma -
#pragma mark - getters and setters
- (UIBarButtonItem *)rightItem {

    if (!_rightItem) {
        
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStyleDone target:self action:@selector(itemClick)];
        _rightItem.tintColor = COLOR_WHITE;
    }
    return _rightItem;
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-49) style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_LIGHT_GRAY;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyNewPrivilegeCell class] forCellReuseIdentifier:MyNewPrivilegeCellIdentifier];
        [_tableView registerClass:[MyFeaturePrivilegecell class] forCellReuseIdentifier:MyFeaturePrivilegeCellIdentifier];
    }
    return _tableView;
}

-(ExplainLevelHeadView *)headView
{
    if (_headView == nil) {
        _headView = [[ExplainLevelHeadView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 300)];
        _headView.backgroundColor = COLOR_ORANGE ;
        
    }
    return _headView;
}

@end
