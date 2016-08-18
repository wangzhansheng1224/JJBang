//
//  CourseDetailHeader.m
//  jjb_user
//
//  Created by Aimee on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseDetailHeader.h"
#import "CourseKeys.h"


@interface CourseDetailHeader()

@property (nonatomic,copy) UIImageView *iView_Photo;
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UILabel *label_num;
@property (nonatomic,strong) UIView *view_line;
@property (nonatomic,strong) NSMutableDictionary *data;
@end

@implementation CourseDetailHeader
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iView_Photo];
        [self addSubview:self.label_title];
        [self addSubview:self.label_num];
        [self addSubview:self.view_line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView* superView=self;
    [_iView_Photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-50);
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
    }];
    [_label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iView_Photo.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@30);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(_label_num.mas_left).offset(-10);
    }];
    [_label_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iView_Photo.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
    }];
    [_view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label_title.mas_bottom);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(10));
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    self.data=[[NSMutableDictionary alloc] initWithDictionary:data];
    [self.label_title setText:data[kCourseName]];
    [self.label_num setText:[NSString stringWithFormat:@"%@人报名",data[kCourseNum]]];
    NSURL *url=[NSURL initWithImageURL:data[kCourseImg] Width:Screen_Width Height:Screen_Width*2.0/3];
    [self.iView_Photo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)iView_Photo {
    
    if (!_iView_Photo) {
        _iView_Photo = [[UIImageView alloc] init];
        _iView_Photo.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _iView_Photo;
}
- (UILabel *)label_title {
    
    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        _label_title.text = @"三峡游开始了，大家快快报名吧";
        _label_title.font = H2;
        [_label_title sizeToFit];
        _label_title.numberOfLines = 1;
    }
    return _label_title;
}

- (UILabel *)label_num {
    
    if (!_label_num) {
        _label_num = [[UILabel alloc] init];
        _label_num.text = @"20人报名";
        _label_num.font = H3;
        _label_num.textAlignment=NSTextAlignmentRight;
        _label_num.textColor=COLOR_GRAY;
        [_label_num sizeToFit];
        _label_num.numberOfLines = 1;
    }
    return _label_num;
}


-(UIView *)view_line{
    if (!_view_line) {
        _view_line=[[UIView alloc] init];
        _view_line.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _view_line;
}
@end
