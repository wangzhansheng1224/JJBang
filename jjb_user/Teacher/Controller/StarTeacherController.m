//
//  StarTeacherController.m
//  jjb_user
//
//  Created by Check on 16/8/14.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StarTeacherController.h"
#import "StarTeacherCell.h"

static NSString  *const StarTeacherCellIdentifier=@"StarTeacherCellIdentifier";

@interface StarTeacherController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array_data;

@end

@implementation StarTeacherController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"明星老师";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    [self layoutPageSubviews];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
}


#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StarTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:StarTeacherCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 94;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[StarTeacherCell class] forCellReuseIdentifier:StarTeacherCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)array_data {
    
    if (!_array_data) {
        
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

@end
