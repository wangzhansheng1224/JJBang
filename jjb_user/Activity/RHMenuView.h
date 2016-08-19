//
//  RHMenuView.h
//  jjb_user
//
//  Created by Check on 16/4/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSInteger index);
@interface RHMenuView : UIView



- (instancetype)initWithFrame:(CGRect)frame andMenuTitles:(NSArray *)titles andBlock:(MyBlock)block;

- (void)changeSelectItemWithIndex:(NSInteger)index;//可以使用属性代替

@property (nonatomic,assign)NSInteger selectIndex;

@end
