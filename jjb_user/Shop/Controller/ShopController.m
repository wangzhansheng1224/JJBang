//
//  ShopController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopController.h"
#import "SHopIndexAPIManager.h"
@interface ShopController()
@property (nonatomic,strong) LDAPIBaseManager *shopIndexAPIManager;
@end

@implementation ShopController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JJBRandomColor;
}

#pragma mark - getters and setters
- (LDAPIBaseManager *)shopAPIManager {
    if (_shopIndexAPIManager == nil) {
        _shopIndexAPIManager = [ShopIndexAPIManager  sharedInstance];
    }
    return _shopIndexAPIManager;
}

@end
