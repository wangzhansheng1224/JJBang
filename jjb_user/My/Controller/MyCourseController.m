//
//  MyCourseController.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyCourseController.h"
#import <Masonry.h>
#import "MyCourseCell.h"

@interface MyCourseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *array_course;

@end

@implementation MyCourseController

#pragma -
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的课程";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SIZE.width, SIZE.height - 64 - 49));
        make.top.left.equalTo(0);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseCellIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCourseCellIdentifier"];
    }
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    return 210;
}
    
#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
        
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyCourseCell class] forCellReuseIdentifier:@"MyCourseCellIdentifier"];
    }
    return _tableView;
}
    
- (NSMutableArray *)array_course{
        
    if (!_array_course) {
        
        _array_course = [NSMutableArray array];
    }
    return _array_course;
}
@end
