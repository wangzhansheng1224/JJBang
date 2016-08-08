//
//  MySettingController.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MySettingController.h"
#import "MySettingCell.h"
#import "MySettingDetailController.h"


@interface MySettingController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * arr_title;
@property (nonatomic,strong) NSMutableArray * arr_content;

@end

@implementation MySettingController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavController];
    
    [self createTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - 设置导航
- (void)setNavController {
    
    self.navigationItem.title = @"设置";
}


#pragma -
#pragma mark - 创建tableView
- (void)createTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerClass:[MySettingCell class] forCellReuseIdentifier:@"MySettingCellID"];
    
    [self.view addSubview:_tableView];
    
}



#pragma -
#pragma mark - tableView代理方法

//每个section的row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arr_title.count;
}
//cell的样式设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MySettingCellID" forIndexPath:indexPath];
    
    if (indexPath.row < self.arr_title.count) {
        
        cell.title = self.arr_title[indexPath.row];
        
        cell.content = self.arr_content[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MySettingDetailController * detail = [[MySettingDetailController alloc] init];
    
    if (indexPath.row == 0) {
        
        
    }else if (indexPath.row == 1) {
        
        detail.name = self.arr_title[indexPath.row];
        
        detail.block = ^(NSString * content) {
            
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        
    }else if (indexPath.row == 2) {
        
        detail.sign = self.arr_title[indexPath.row];
        
        detail.block = ^(NSString * content) {
            
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        
    }else if (indexPath.row == 3) {
        
        detail.password = self.arr_title[indexPath.row];
        
        detail.block = ^(NSString * content) {
            
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        
    }else if (indexPath.row == 4) {
        
        detail.phoneNum = self.arr_title[indexPath.row];
        
        detail.block = ^(NSString * content) {
            
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        
    }else if (indexPath.row == 5) {
        
        detail.weixinNum = self.arr_title[indexPath.row];
        
        detail.block = ^(NSString * content) {
            
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
        
    }else if (indexPath.row == 6) {
        
        detail.qqNum = self.arr_title[indexPath.row];
        
        detail.block = ^(NSString * content) {
            
            [self.arr_content replaceObjectAtIndex:indexPath.row withObject:content];
        };
    }
    [self.navigationController pushViewController:detail animated:YES];
}





#pragma -
#pragma mark - 懒加载
- (NSMutableArray *)arr_title {
    
    if (!_arr_title) {
        
        NSArray * array = @[@"头像", @"昵称", @"个性签名", @"账户密码", @"手机号", @"微信账号", @"QQ"];
        
        _arr_title = [NSMutableArray arrayWithArray:array];
    }
    return _arr_title;
}

- (NSMutableArray *)arr_content {
    
    if (!_arr_content) {
        
        NSArray * array = @[@"头像", @"昵称", @"个性签名", @"账户密码", @"手机号", @"微信账号", @"QQ"];
        _arr_content = [NSMutableArray arrayWithArray:array];
    }
    return _arr_content;
}



@end
