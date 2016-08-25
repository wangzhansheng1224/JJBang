//
//  ShopListController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopListController.h"
#import "ShopListCell.h"
/**
 *  所有门店
 */
@interface ShopListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UIButton * backButton;
@property(nonatomic,weak) UIView * NavView;

@end

static NSString * const shopListCellIdentifer = @"shopListCellIdentifier";

@implementation ShopListController
#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    
    [self setupNav];
//    self.tableView.height = 60.0f;
    [self.view addSubview:self.tableView];
    [self.NavView addSubview:self.backButton];
}

-(void)setupNav
{
    self.navigationItem.title = @"所有门店";
}

#pragma -
#pragma mark - private methods
-(void)backClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -
#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopListArray.count;
//    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:shopListCellIdentifer];
    if(cell == nil )
    {
        cell = [[ShopListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopListCellIdentifer];
            }
    [cell configWithData:self.shopListArray[indexPath.row]];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopModel * model = self.shopListArray[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeShopName" object:nil userInfo:@{@"selectShop":model}];
    }];
}

#pragma -
#pragma mark - getter and setter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 44- 20) style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_LIGHT_GRAY;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ShopListCell class] forCellReuseIdentifier:shopListCellIdentifer];
        
        
    }
    return _tableView;
}
-(NSMutableArray *)shopListArray
{
    if (_shopListArray == nil) {
        NSMutableArray * array = [NSMutableArray array];
        _shopListArray = array;
    }
    return _shopListArray;
}
-(UIButton *)backButton
{
    if (_backButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 25, 20, 20);
        [button setBackgroundImage:[UIImage imageNamed:@"cancel_icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.NavView addSubview:button];
        _backButton = button;
    }
    return _backButton;
}
-(UIView *)NavView
{
    if (_NavView == nil) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
        view.backgroundColor = COLOR_ORANGE;
        [self.view addSubview:view];
        _NavView = view;
    }
    return _NavView;
}
@end
