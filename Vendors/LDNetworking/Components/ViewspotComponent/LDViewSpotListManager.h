//
//  LDViewSpotListManager.h
//  Common
//
//  Created by Owen on 15/9/3.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface LDViewSpotListManager
    : LDAPIBaseManager <LDAPIManager, LDAPIManagerValidator,
                        LDAPIManagerInterceptor>
@property(nonatomic, assign) NSInteger totalPropertyCount;
@property(nonatomic, assign) NSInteger nextPageNumber;

- (void)loadNextPage;
@end
