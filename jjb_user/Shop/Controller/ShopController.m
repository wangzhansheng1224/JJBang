//
//  ShopController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopController.h"
#import "SHopIndexAPIManager.h"
@interface ShopController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@property(nonatomic,strong) id<ReformerProtocol> shopIndexReformer;
@end

@implementation ShopController

#pragma -
#pragma mark- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
    [self.shopIndexAPIManager loadData];
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSDictionary *reformedShopIndexData = [manager fetchDataWithReformer:self.shopIndexReformer];
}
- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{@"lng":@"117.10",@"lat":@"40.13"};
}

#pragma -
#pragma mark - getters and setters
- (LDAPIBaseManager *)shopIndexAPIManager {
    if (_shopIndexAPIManager == nil) {
        _shopIndexAPIManager = [ShopIndexAPIManager  sharedInstance];
        _shopIndexAPIManager.delegate=self;
        _shopIndexAPIManager.paramSource=self;
    }
    return _shopIndexAPIManager;
}


@end
