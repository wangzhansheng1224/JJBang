//
//  StudentDetailController.m
//  jjb_user
//
//  Created by Check on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailController.h"
#import "GrowingCell.h"

static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";

@interface StudentDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array_data;
@property (nonatomic,strong) UIView *view_top;
@property (nonatomic,strong) UIView *view_header;
@property (nonatomic,strong) UIImageView *imageView_pic;
@property (nonatomic,strong) UIImageView *imageView_icon;
@property (nonatomic,strong) UILabel *label_name;
@property (nonatomic,strong) UILabel *label_sex;
@property (nonatomic,strong) UILabel *label_age;
@property (nonatomic,strong) NSMutableArray *array_btn;
@property (nonatomic,strong) NSArray *array_title;
@property (nonatomic,assign) int index;//0 1 2
@property (nonatomic,strong) UILabel *label_verticalline;
@property (nonatomic,strong) UILabel *label_bottomline;

@end

@implementation StudentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self.view addSubview:self.tableView];
    [self createTableHeaderView];
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
    [self.view_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 202));
        make.top.left.equalTo(@0);
    }];
    [self.imageView_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 202));
        make.top.left.equalTo(@0);
    }];
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.bottom.equalTo(self.imageView_pic.mas_bottom).with.offset(2);
        make.left.equalTo(@16);
    }];
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 16));
        make.top.equalTo(@137);
        make.left.equalTo(self.imageView_icon.mas_right).with.offset(14);
    }];
    [self.label_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.equalTo(self.imageView_icon.mas_right).with.offset(14);
        make.top.equalTo(self.label_name.mas_bottom).with.offset(6);
    }];
    [self.label_age mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(34, 16));
        make.top.equalTo(self.label_name.mas_bottom).with.offset(6);
        make.left.equalTo(self.label_sex.mas_right).with.offset(0);
    }];
    [self.view_header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 36));
        make.top.equalTo(self.view_top.mas_bottom).with.offset(0);
        make.left.equalTo(@0);
    }];
    [self.label_bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    __weak typeof (self) weakSelf = self;
    [self.label_verticalline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(1, 16));
        make.bottom.equalTo(self.label_bottomline.mas_top).with.offset(-10);
        make.centerX.equalTo(weakSelf.view);
    }];
}


#pragma -
#pragma mark - createTableHeaderView
- (void)createTableHeaderView {
    
    [self.tableView addSubview:self.view_top];
    [self.view_top addSubview:self.imageView_pic];
    [self.view_top addSubview:self.imageView_icon];
    [self.view_top addSubview:self.label_name];
    [self.view_top addSubview:self.label_sex];
    [self.view_top addSubview:self.label_age];
    
    for (int i = 0; i < self.array_title.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Screen_Width / 2 * i, 0, Screen_Width / 2, 38);
        [button setTitle:self.array_title[i] forState:UIControlStateNormal];
        button.titleLabel.font = H3;
        [button setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
        [button setTitleColor:COLOR_ORANGE forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000 + i;
        [self.array_btn addObject:button];
        [self.view_header addSubview:button];
        
        if (i == 0) {
            
            button.selected = YES;
        }
    }
    self.tableView.tableHeaderView = self.view_header;
    [self.view_header addSubview:self.label_bottomline];
    [self.view_header addSubview:self.label_verticalline];
}

#pragma -
#pragma mark - event response
- (void)buttonClick:(UIButton*)button{
    _index = (int)button.tag - 2000;
    
    for (int i = 0; i < self.array_btn.count; i++) {
        
        UIButton * button = (UIButton *)self.array_btn[i];
        
        if (i == _index) {
            
            button.selected = YES;
        }else {
            
            button.selected = NO;
        }
    }
    [self.tableView reloadData];
}



#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_index == 0) {
        //我的成长
        GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:GrowingCellIdentifier forIndexPath:indexPath];
        
        return cell;
        
    }else {
        //已报课程
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        
        cell.backgroundColor = JJBRandomColor;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 210;
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
        _tableView.contentOffset = CGPointMake(0, -202);
    }
    return _tableView;
}

- (NSMutableArray *)array_data {
    
    if (!_array_data) {
        
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (UIView *)view_header {

    if (!_view_header) {
        
        _view_header = [[UIView alloc] init];
    }
    return _view_header;
}

- (UIImageView *)imageView_pic {

    if (!_imageView_pic) {
        
        _imageView_pic = [[UIImageView alloc] init];
        _imageView_pic.backgroundColor = COLOR_GRAY;

    }
    return _imageView_pic;
}

- (UIImageView *)imageView_icon {

    if (!_imageView_icon) {
        
        _imageView_icon = [[UIImageView alloc] init];
        _imageView_icon.image = [UIImage imageNamed:@"student_icon"];
        _imageView_icon.layer.cornerRadius = 39;
        _imageView_icon.clipsToBounds = YES;
    }
    return _imageView_icon;
}

- (UILabel *)label_name {

    if (!_label_name) {
        
        _label_name = [[UILabel alloc] init];
        _label_name.text = @"王鹿晗";
        _label_name.font = H3;
        _label_name.textColor = COLOR_WHITE;
    }
    return _label_name;
}

- (UILabel *)label_sex {

    if (!_label_sex) {
        
        _label_sex = [[UILabel alloc] init];
        _label_sex.text = @"男";
        _label_sex.font = H3;
        _label_sex.textColor = COLOR_WHITE;
    }
    return _label_sex;
}

- (UILabel *)label_age {

    if (!_label_age) {
        
        _label_age = [[UILabel alloc] init];
        _label_age.text = @"3岁";
        _label_age.font = H3;
        _label_age.textColor = COLOR_WHITE;
        _label_age.textAlignment = NSTextAlignmentRight;
    }
    return _label_age;
}

- (NSMutableArray *)array_btn {

    if (!_array_btn) {
        
        _array_btn = [[NSMutableArray alloc] init];
    }
    return _array_btn;
}

- (NSArray *)array_title {
    
    if (!_array_title) {
        
        _array_title = @[@"我的成长",@"已报课程"];
    }
    return _array_title;
}

- (UIView *)view_top {

    if (!_view_top) {
        
        _view_top = [[UIView alloc] init];
    }
    return _view_top;
}

- (UILabel *)label_verticalline {
    
    if (!_label_verticalline) {
        
        _label_verticalline = [[UILabel alloc] init];
        _label_verticalline.backgroundColor = COLOR_GRAY;
    }
    return _label_verticalline;
}

- (UILabel *)label_bottomline {
    
    if (!_label_bottomline) {
        
        _label_bottomline = [[UILabel alloc] init];
        _label_bottomline.backgroundColor = COLOR_GRAY;
    }
    return _label_bottomline;
}

@end
