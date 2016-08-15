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
#import "GrowingTreeListAPIManager.h"
#import "GrowingTreeListReformer.h"
#import "GrowingPicController.h"

static NSString  *const GrowingCellIdentifier=@"GrowingCellIdentifier";

@interface GrowingTreeController ()<UITableViewDelegate,UITableViewDataSource,LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) LDAPIBaseManager *growingTreeListAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> growingTreeListReformer;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) IssueController *issueVC;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSArray *imageArr;

@property (nonatomic,strong) NSArray *imageArray;


@end

@implementation GrowingTreeController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"社区动态";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageIndex=0;
    self.pageSize=20;
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.growingTreeListAPIManager loadData];
    [self setNav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top);
        make.left.mas_equalTo(superView.mas_left);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(superView.mas_height);
    }];
}

#pragma -
#pragma mark - set Nav
- (void)setNav {
    
    UIBarButtonItem *btn_issue = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"growing_issue"] highImage:[UIImage imageNamed:@"growing_issue"] target:self action:@selector(itemClick)];
    self.navigationItem.rightBarButtonItem = btn_issue;
}

#pragma -
#pragma mark - event respone
- (void)tapGR:(UITapGestureRecognizer *)tap {
    
    UIImageView * imageV = (UIImageView *)tap.view;
    NSInteger index = imageV.tag - 2016;
        
    GrowingPicController *pic = [[GrowingPicController alloc] init];
    pic.photos = _imageArray;
    pic.index = index;
    
    CATransition *transition = [CATransition animation];
    transition.type = @"moveIn";
    transition.subtype = @"fromCenter";
    transition.duration = 1;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self presentViewController:pic animated:YES completion:nil];
}

#pragma -
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:GrowingCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GrowingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GrowingCellIdentifier];
    }
    
    NSDictionary * dic = self.arrData[indexPath.row];
    
    [cell configWithData:dic];
    
    float width = 119 - 8;
    
    NSArray * imageArr = dic[kGrowingTreeListImages];
    if (imageArr.count > 0) {
        
        _imageArray = imageArr;
    }
    
    for (int i = 0; i < imageArr.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%3 * (width+8), i/3 * (77+8), width, 77)];
        
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = JJBRandomColor;
        imageView.tag = 2016 + i;
        
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        
        [imageView addGestureRecognizer:tapGR];
        
        [cell.view_image addSubview:imageView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = self.arrData[indexPath.row];
    self.imageArr = dic[kGrowingTreeListImages];
    
    CGSize size = [dic[kGrowingTreeListContent] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H2} context:nil].size;
    
    float height = size.height;
    
    if ([dic[kGrowingTreeListContent] length] <= 0) {
        
        height = 0;
    }
    
    if (self.imageArr.count == 0) {
        
        return 92 + height;
        
    }else {
        
        return (self.imageArr.count+2)/3 *85 +92 + height;
    }
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.growingTreeListReformer];
    [self.arrData addObjectsFromArray:resultData];
    self.pageIndex=[self.arrData count];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"shop_id":@"1",
             @"start":@(self.pageIndex),
             @"count":@(self.pageSize)
             };
}

#pragma -
#pragma mark - event response
- (void)itemClick {
    
    [self.navigationController pushViewController:self.issueVC animated:YES];
}

#pragma -
#pragma mark - getter and setter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.arrData removeAllObjects];
            self.pageIndex=0;
            [self.growingTreeListAPIManager loadData];
        }];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.growingTreeListAPIManager loadData];
        }];
        [_tableView registerClass:[GrowingCell class] forCellReuseIdentifier:GrowingCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)arrData{
    if (!_arrData) {
        
        _arrData = [[NSMutableArray alloc] init];
    }
    return _arrData;
}

- (IssueController *)issueVC {
    if (!_issueVC) {
        _issueVC = [[IssueController alloc] init];
    }
    return _issueVC;
}

- (LDAPIBaseManager *)growingTreeListAPIManager {
    if (_growingTreeListAPIManager == nil) {
        _growingTreeListAPIManager = [GrowingTreeListAPIManager  sharedInstance];
        _growingTreeListAPIManager.delegate=self;
        _growingTreeListAPIManager.paramSource=self;
    }
    return _growingTreeListAPIManager;
}

- (id<ReformerProtocol>) growingTreeListReformer{
    
    if (!_growingTreeListReformer) {
        _growingTreeListReformer=[[GrowingTreeListReformer alloc] init];
    }
    return _growingTreeListReformer;
}

//- (NSArray *)imageArr {
//
//    if (!_imageArr) {
//
//        _imageArr = [[NSMutableArray alloc] init];
//
//    }
//    return _imageArr;
//}

@end
