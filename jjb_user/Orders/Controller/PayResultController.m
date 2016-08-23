//
//  PayResultController.m
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "PayResultController.h"
#import "OrderStatusAPImanager.h"

@interface PayResultController()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>
@property (nonatomic,strong) OrderStatusAPImanager *apiManager;
@end

@implementation PayResultController
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付完成";
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[OrderStatusAPImanager class]]) {

    }

    
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    if ([manager isKindOfClass:[OrderStatusAPImanager class]]) {
    }
    return nil;
}


#pragma -
#pragma mark - setter and getter
-(OrderStatusAPImanager*) apiManager{
    if (!_apiManager) {
        _apiManager=[OrderStatusAPImanager sharedInstance];
        _apiManager.delegate=self;
        _apiManager.paramSource=self;
    }
    return _apiManager;
}
@end
