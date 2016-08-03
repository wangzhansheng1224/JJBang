//
//  GrowingTreeController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingTreeController.h"
#import "GrowingCell.h"
#import "IssueController.h"
#import <Masonry.h>


#define SIZE [UIScreen mainScreen].bounds.size

@interface GrowingTreeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIButton *issueBtn;

@property (nonatomic,strong) IssueController *issueVC;

@end

@implementation GrowingTreeController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
    
    self.navigationItem.title = @"社区动态";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadData];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.issueBtn];
//    [self.view bringSubviewToFront:self.issueBtn];
    
    [self configMasonry];
}

#pragma mark -- CustomMethods
- (void)loadData {
    
}

- (void)configMasonry {

    
            [self.issueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
                make.size.mas_equalTo(CGSizeMake(50, 50));
                make.bottom.equalTo(@-100);
                make.right.equalTo(@-50);
    //
    //            make.right.equalTo(self.view.mas_right).with.offset(-50);
    //            make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
                
            }];
}


#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ident" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ident"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 313;
}

#pragma mark -- event response
- (void)btnClick:(UIButton *)btn {

    NSLog(@"发布");
    
    [self.navigationController pushViewController:self.issueVC animated:YES];
}


#pragma mark -- getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 64, SIZE.width, SIZE.height-64 -40);
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@64);
//            make.bottom.equalTo(@-49);
//            make.left.right.equalTo(@0);
//        }];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:@"ident"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}

- (UIButton *)issueBtn {

    if (!_issueBtn) {
        
        _issueBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _issueBtn.frame = CGRectMake(200, 200, 50, 50);
        [_issueBtn setImage:[UIImage imageNamed:@"release"] forState:UIControlStateNormal];
        [_issueBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _issueBtn;
}

- (IssueController *)issueVC {

    if (!_issueVC) {
        
        _issueVC = [[IssueController alloc] init];
    }
    return _issueVC;
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
