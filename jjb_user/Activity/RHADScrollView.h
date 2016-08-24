//
//  RHADScrollView.h
//  jjb_user
//
//  Created by Check on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHADScrollViewDelegate <NSObject>

@optional
- (void)tapImageIndex:(NSInteger )index;

@end

@interface RHADScrollView : UIView

@property (nonatomic, weak) id<RHADScrollViewDelegate> delegate;

@property (nonatomic, strong) NSArray * arrPic;
@property (nonatomic, assign) BOOL invalidate;
@property (nonatomic, assign) float adHeight;

//设置好属性开始播放
- (void)play;

@end
