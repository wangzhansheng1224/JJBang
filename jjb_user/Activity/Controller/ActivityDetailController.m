//
//  ActivityDetailController.m
//  jjb_user
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailController.h"
#import "ActivityDetailCell.h"
#import "ActivityInfoCell.h"

@interface ActivityDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIBarButtonItem *item_share;   //分享item
@property (nonatomic,strong) UIImageView *imageView_pic;
@property (nonatomic,strong) UILabel *label_status; //进行中
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_location;
@property (nonatomic,strong) UILabel *label_location;
@property (nonatomic,strong) UIImageView *imageView_time;
@property (nonatomic,strong) UILabel *label_time;
@property (nonatomic,strong) UIButton *btn_join;
@property (nonatomic,strong) UILabel *label_topline;
@property (nonatomic,strong) UILabel *label_bottomline;
@property (nonatomic,strong) UILabel *label_verticalline;
@property (nonatomic,strong) UIView *view_header;
@property (nonatomic,strong) NSArray *array_title;
@property (nonatomic,assign) int index;//0 1 2
@property (nonatomic,strong) UIView *view_top;
@property (nonatomic,strong) NSMutableArray *array_btn;

@end

@implementation ActivityDetailController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.view_top];
    [self.view_top addSubview:self.imageView_pic];
    [self.view_top addSubview:self.label_status];
    [self.view_top addSubview:self.label_title];
    [self.view_top addSubview:self.imageView_location];
    [self.view_top addSubview:self.label_location];
    [self.view_top addSubview:self.imageView_time];
    [self.view_top addSubview:self.label_time];
    [self.view_top addSubview:self.btn_join];
    [self createHeadView];
    [self setUpNav];
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.left.equalTo(@0);
    }];
    
    [self.view_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 264));
        make.top.equalTo(@-264);
        make.left.equalTo(@0);
    }];
    
    [self.imageView_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 178));
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
    
    [_label_status mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_imageView_pic.mas_bottom).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(76, 30));
        make.left.equalTo(self.imageView_pic.mas_left).with.offset(0);
    }];
    
    [_label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imageView_pic.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(Screen_Width - 10, 20));
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
    }];
    
    [_imageView_location mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_title.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.left.equalTo(@16);
    }];
    
    [_label_location mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_title.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(200, 17));
        make.left.equalTo(_imageView_location.mas_right).with.offset(8);
    }];
    
    [_imageView_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imageView_location.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.left.equalTo(@16);
    }];
    
    [_label_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_location.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(200, 17));
        make.left.equalTo(_imageView_time.mas_right).with.offset(8);
    }];
    
    [_btn_join mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 34));
        make.top.equalTo(_imageView_pic.mas_bottom).with.offset(33);
        make.right.equalTo(@-16);
    }];
    
    [self.label_topline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.top.left.equalTo(@0);
    }];
    
    [self.view_header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 44));
        make.top.equalTo(@0);
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
        make.top.equalTo(self.label_topline.mas_bottom).with.offset(13);
        make.centerX.equalTo(weakSelf.view);
    }];
}

#pragma -
#pragma mark - custom methods
-(void)setUpNav
{
    self.navigationItem.rightBarButtonItem = self.item_share;
}

- (void)createHeadView{
    
    for (int i = 0; i < self.array_title.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Screen_Width / 2 * i, 0, Screen_Width / 2, 42);
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
    [self.view_header addSubview:self.label_topline];
    [self.view_header addSubview:self.label_bottomline];
    [self.view_header addSubview:self.label_verticalline];
}


#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_index == 0) {
        //活动详情
        ActivityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityDetailIdentifier" forIndexPath:indexPath];
//        if (indexPath.row == 0) {
//            
//            cell.textLabel.text = @"活动规则";
//        }else if (indexPath.row == 1) {
//        
//            cell.textLabel.text = @"围绕户外美食的文章，图片均可以参加。充分体现在野外活动中快捷，方便制作户外美食和户外和谐氛围的全过程。";
//        }
        
        return cell;
        
    }else {
        //报名信息
        ActivityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityInfoCellIdentifier" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 200;
}



#pragma -
#pragma mark - event response
- (void)shareClick {

    NSLog(@"------分享------");
}

- (void)joinClick {

    NSLog(@"------立即报名------");
}

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
}


#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];

        [_tableView registerClass:[ActivityDetailCell class] forCellReuseIdentifier:@"ActivityDetailIdentifier"];
        [_tableView registerClass:[ActivityInfoCell class] forCellReuseIdentifier:@"ActivityInfoCellIdentifier"];

        _tableView.rowHeight = UITableViewAutomaticDimension;
        //预计行高
        _tableView.estimatedRowHeight = 44.0;
        
        _tableView.contentInset = UIEdgeInsetsMake(264, 0, 0, 0);
        
        _tableView.contentOffset = CGPointMake(0, -264);
        
    }
    return _tableView;
}

- (UIBarButtonItem *)item_share {

    if (!_item_share) {
        
        _item_share = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
    }
    return _item_share;
}

- (UIImageView *)imageView_pic {

    if (!_imageView_pic) {
        
        _imageView_pic = [[UIImageView alloc] init];
        _imageView_pic.backgroundColor = JJBRandomColor;
        _imageView_pic.contentMode = UIViewContentModeScaleAspectFill;
        _imageView_pic.clipsToBounds = YES;
    }
    return _imageView_pic;
}

- (UILabel *)label_status {

    if (!_label_status) {
        
        _label_status = [[UILabel alloc] init];
        _label_status = [[UILabel alloc] init];
        _label_status.textAlignment = NSTextAlignmentCenter;
        _label_status.text = @"进行中";
        _label_status.font = H3;
        _label_status.textColor = COLOR_WHITE;
        _label_status.numberOfLines = 1;
        [_label_status setBackgroundColor:COLOR_DARK_GRAY];
        [_label_status setAlpha:0.3];
    }
    return _label_status;
}

- (UILabel *)label_title {

    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        _label_title.text = @"三峡游开始了，大家快快报名吧";
        _label_title.font = H2;
        [_label_title sizeToFit];
        _label_title.textColor = [UIColor blackColor];
        _label_title.numberOfLines = 1;
    }
    return _label_title;
}

- (UIImageView *)imageView_location {

    if (!_imageView_location) {
        
        _imageView_location = [[UIImageView alloc] init];
        _imageView_location.image = [UIImage imageNamed:@"activity_location"];
    }
    return _imageView_location;
}

- (UILabel *)label_location {

    if (!_label_location) {
        
        _label_location = [[UILabel alloc] init];
        _label_location.text = @"社区儿童成长中心兴源店";
        _label_location.textColor = COLOR_GRAY;
        _label_location.font = H4;
        [_label_location sizeToFit];
    }
    return _label_location;
}

- (UIImageView *)imageView_time {

    if (!_imageView_time) {
        
        _imageView_time = [[UIImageView alloc] init];
        _imageView_time.image = [UIImage imageNamed:@"activity_time"];
    }
    return _imageView_time;
}

- (UILabel *)label_time {

    if (!_label_time) {
        
        _label_time = [[UILabel alloc] init];
        _label_time.text = @"08-02 00:00至08-02 24:00";
        _label_time.textColor = COLOR_GRAY;
        [_label_time sizeToFit];
        _label_time.font = H4;
    }
    return _label_time;
}

- (UIButton *)btn_join {

    if (!_btn_join) {
        
        _btn_join = [[UIButton alloc] init];
        _btn_join.backgroundColor = COLOR_ORANGE;
        [_btn_join setTitle:@"立即报名" forState:UIControlStateNormal];
        [_btn_join setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
        _btn_join.titleLabel.font = H3;
        [_btn_join addTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_join;
}

- (UIView *)view_header {

    if (!_view_header) {
        
        _view_header = [[UIView alloc] init];
    }
    return _view_header;
}

- (NSArray *)array_title {

    if (!_array_title) {
        
        _array_title = @[@"活动详情",@"报名信息"];
    }
    return _array_title;
}

- (UIView *)view_top {

    if (!_view_top) {
        
        _view_top = [[UIView alloc] init];
    }
    return _view_top;
}

- (UILabel *)label_topline {

    if (!_label_topline) {
        
        _label_topline = [[UILabel alloc] init];
        _label_topline.backgroundColor = COLOR_GRAY;
    }
    return _label_topline;
}

- (UILabel *)label_bottomline {
    
    if (!_label_bottomline) {
        
        _label_bottomline = [[UILabel alloc] init];
        _label_bottomline.backgroundColor = COLOR_GRAY;
    }
    return _label_bottomline;
}

- (UILabel *)label_verticalline {

    if (!_label_verticalline) {
        
        _label_verticalline = [[UILabel alloc] init];
        _label_verticalline.backgroundColor = COLOR_GRAY;
    }
    return _label_verticalline;
}

- (NSMutableArray *)array_btn {

    if (!_array_btn) {
        
        _array_btn = [[NSMutableArray alloc] init];
    }
    return _array_btn;
}

@end
