//
//  MineHeaderView.h
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView

@property (nonatomic, copy) NSString *topImageView;

@property (nonatomic, copy) NSString *emailButton;

@property (nonatomic, copy) NSString *setButton;

@property (nonatomic, copy) NSString *itemImageView;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *levelTitle;

@property (nonatomic, copy) NSString *levelImage;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *ad;


- (void)setBtnAddTarget:(id)target action:(SEL)sel;

- (void)emailBtnAddTarget:(id)target action:(SEL)sel;

- (void)levelBtnAddTarget:(id)target action:(SEL)sel;

- (void)moneyBtnAddTarget:(id)target action:(SEL)sel;

- (void)adBtnAddTarget:(id)target action:(SEL)sel;


@end
