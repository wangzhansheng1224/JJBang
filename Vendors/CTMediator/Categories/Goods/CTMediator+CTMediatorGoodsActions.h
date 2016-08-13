//
//  CTMediator+CTMediatorGoodsActions.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (CTMediatorGoodsActions)
- (UIViewController *)CTMediator_GoodsDetail:(NSDictionary *)params;
- (UIViewController *)CTMediator_GoodsList:(NSDictionary *)params;
@end
