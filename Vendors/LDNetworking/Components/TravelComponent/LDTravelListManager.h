//
//  LDTravelListManager.h
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface LDTravelListManager
    : LDAPIBaseManager <LDAPIManager, LDAPIManagerParamSourceDelegate,
                        LDAPIManagerValidator, LDAPIManagerInterceptor>
@property(nonatomic, assign) NSInteger totalPropertyCount;
@property(nonatomic, assign) NSInteger nextPageNumber;

- (void)loadNextPage;
@end
