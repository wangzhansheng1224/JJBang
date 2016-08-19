//
//  RHADScrollView.h
//  jjb_user
//
//  Created by Check on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHADScrollViewDelegate <NSObject>

- (void)tapImageIndex:(NSInteger)index;

@end

@interface RHADScrollView : UIView

@property (nonatomic, strong) NSArray * arrPic;
@property (nonatomic, weak) id<RHADScrollViewDelegate> delegate;

- (instancetype)initWithPicArr:(NSArray *)picArr;

@end
