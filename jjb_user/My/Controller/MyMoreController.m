//
//  MyMoreController.m
//  jjb_user
//
//  Created by Check on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyMoreController.h"
#import "MyMoreCell.h"

@interface MyMoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIView *view_top;

@property (nonatomic,strong) UIImageView *imageView_icon;

@property (nonatomic,strong) UILabel *label_name;

@end

@implementation MyMoreController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_GRAY;
    
    [self.view addSubview:self.tableView];
    [self.view_top addSubview:self.imageView_icon];
    [self.view_top addSubview:self.label_name];
    [self.view addSubview:self.view_top];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.view_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 242));
        make.top.left.equalTo(@0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height - 242));
        make.top.equalTo(self.view_top.mas_bottom).with.offset(0);
        make.left.equalTo(@0);
    }];
    
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(95, 95));
        make.top.equalTo(@53);
        make.left.equalTo(@140);
    }];
    
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(self.imageView_icon.mas_bottom).with.offset(20);
        make.left.equalTo(@138);
    }];
}

#pragma -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMoreCellIdentifier" forIndexPath:indexPath];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyMoreCell class] forCellReuseIdentifier:@"MyMoreCellIdentifier"];
    }
    return _tableView;
}

- (UIView *)view_top {

    if (!_view_top) {
        
        _view_top = [[UIView alloc] init];
        _view_top.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _view_top;
}

- (UIImageView *)imageView_icon {

    if (!_imageView_icon) {
        
        _imageView_icon = [[UIImageView alloc] init];
        _imageView_icon.image = [UIImage imageNamed:@"login_select"];
    }
    return _imageView_icon;
}

- (UILabel *)label_name {

    if (!_label_name) {
        
        _label_name = [[UILabel alloc] init];
        _label_name.text = @"家家帮V1.0";
        _label_name.font = H1;
        _label_name.textColor = COLOR_ORANGE;
    }
    return _label_name;
}
@end
