//
//  ContactServiceController.m
//  jjb_user    联系客服
//
//  Created by Check on 16/8/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ContactServiceController.h"
#import "ContactServiceCell.h"
#import "StoreDetailInfoAPIManager.h"
#import "StoreDetailReformer.h"

@interface ContactServiceController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) StoreDetailInfoAPIManager *storeDetailInfoAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> storeDetailReformer;

@end

@implementation ContactServiceController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"门店详情";
    [self.view addSubview:self.tableView];
    [self layoutPageSubviews];
    [self.storeDetailInfoAPIManager loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.top.left.equalTo(@0);
    }];
}

#pragma -
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactServiceCellIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ContactServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContactServiceCellIdentifier"];
    }
    [cell configWithData:self.dataDic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    self.dataDic = [manager fetchDataWithReformer:self.storeDetailReformer];
    [self.tableView reloadData];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    if ([manager isKindOfClass:[StoreDetailInfoAPIManager class]]) {
        return @{@"shop_id":@([ShopModel currentShop].shopID)};
    }
    return @{};
}

#pragma -
#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ContactServiceCell class] forCellReuseIdentifier:@"ContactServiceCellIdentifier"];
    }
    return _tableView;
}
- (NSDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [[NSDictionary alloc] init];
    }
    return _dataDic;
}
- (StoreDetailInfoAPIManager *)storeDetailInfoAPIManager {
    if (_storeDetailInfoAPIManager == nil) {
        _storeDetailInfoAPIManager = [StoreDetailInfoAPIManager  sharedInstance];
        _storeDetailInfoAPIManager.delegate=self;
        _storeDetailInfoAPIManager.paramSource=self;
    }
    return _storeDetailInfoAPIManager;
}
- (id<ReformerProtocol>)storeDetailReformer {
    
    if (!_storeDetailReformer) {
        _storeDetailReformer=[[StoreDetailReformer alloc] init];
    }
    return _storeDetailReformer;
}
@end
