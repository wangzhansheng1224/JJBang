//
//  MyBubbleView.m
//  jjb_user
//
//  Created by Maybe on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyBubbleView.h"

@interface MyBubbleView ()

@property(nonatomic,strong)UIImageView * imageView;
@end


@implementation MyBubbleView

#pragma -
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setChildViewsConstraints];
    }
    return self;
}


-(void)setChildViewsConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imageView.mas_top).offset(8);
//        make.left.equalTo(self.imageView.mas_left).offset(10);
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.centerY.equalTo(self.imageView.mas_centerY);
        
    }];
}

#pragma -
#pragma mark -  getter and setter
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView * imageView =[[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"my_levelBUbble"];
        _imageView = imageView;
        [self addSubview:imageView];
    }
    return _imageView;
}
-(UILabel *)label
{
    if (_label == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"升级还需:充值3000";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT_SIZE(13);
        [label sizeToFit];
        _label = label;
        [self.imageView addSubview:_label];
    }
    return _label;
}

@end
