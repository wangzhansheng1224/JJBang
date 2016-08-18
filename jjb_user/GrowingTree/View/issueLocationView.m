//
//  issueLocationView.m
//  jjb_user
//
//  Created by Maybe on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "issueLocationView.h"


@interface issueLocationView ()

//@property(nonatomic,strong) UIView * lineView;
//@property(nonatomic,strong) UIView * bjView;
@property(nonatomic,strong) UIImageView * locationImageView;
//@property(nonatomic,strong) UILabel * locationLabel;
//@property(nonatomic,strong) UIImageView * rightImageView;

@end
@implementation issueLocationView

#pragma -
#pragma mark - life cycle

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViewConstraints];
        self.backgroundColor = COLOR_WHITE;
    }
    return self;
}


#pragma -
#pragma mark - private methods
-(void)addSubViewConstraints
{
    
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
        JJBLog(@"self 的frame%@",NSStringFromCGRect(self.frame));
        
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.locationImageView.mas_right).offset(25);
        
        
    }];
//    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY);
//        make.right.equalTo(self.mas_right).offset(-20);
//    }];
}

#pragma -
#pragma mark - getter and setter
//-(UIView *)bjView
//{
//    if (_bjView == nil) {
//        UIView * view = [[UIView alloc]init];
////        view.backgroundColor = COLOR_WHITE;
//        [self addSubview:view];
//        _bjView = view;
//    }
//    return _bjView;
//}

//-(UIView *)lineView
//{
//    if (_lineView == nil) {
//        UIView * view = [[UIView alloc]init];
//        view.backgroundColor = COLOR_LIGHT_GRAY;
//        [self.bjView addSubview:view];
//        _lineView = view;
//    }
//    return _lineView;
//}
-(UIImageView *)locationImageView
{
    if (_locationImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"growing_loc"]];
        [self addSubview:imageView];
        _locationImageView = imageView;
    }
    return _locationImageView;
}
//-(UIImageView *)rightImageView
//{
//    if (_rightImageView == nil) {
//        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_solid-1"]];
////        [self addSubview:imageView];
//        _rightImageView = imageView;
//        
//    
//    }
//    return _rightImageView;
//}
-(UILabel *)locationLabel
{
    if (_locationLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"所在位置";
        label.font = H3;
        [label sizeToFit];
        [self addSubview:label];
        _locationLabel = label;
    }
    return _locationLabel;
}

@end
