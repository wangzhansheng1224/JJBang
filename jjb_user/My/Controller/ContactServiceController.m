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
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"联系我们" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            
            [self openFuncFromCommd:@"telprompt://01056264701"];
            
        }];
    [alert addAction:OKAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
        
}

- (void)openFuncFromCommd:(NSString*)str{
    //NSString -> NSURL
    NSURL *url = [NSURL URLWithString:str];
    //当前程序
    UIApplication *app = [UIApplication sharedApplication];
    //判断
    if ([app canOpenURL:url]) {
        //调用
        [app openURL:url];
    } else {
        NSLog(@"没有此功能或该功能不可用");
    }
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
