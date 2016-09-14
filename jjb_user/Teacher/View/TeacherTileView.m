//
//  TeacherTileView.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherTileView.h"

NSString * const kTeacherTitle = @"TeacherTitle";
NSString * const kTeacherContent = @"TeacherContent";

@interface TeacherTileView()
@property(nonatomic,strong) UIView *orangeView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *detailLabel;
@end
@implementation TeacherTileView

-(id) init{
    self=[super init];
    if (self) {
        [self setBackgroundColor:COLOR_WHITE];
        [self addSubview:self.orangeView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
    }
    return self;
}

#pragma -
#pragma mark - layoutSubviews
-(void)layoutSubviews{
    UIView *superView=self;
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(5);
        make.left.equalTo(superView.mas_left);
        make.height.equalTo(@(20));
        make.width.equalTo(@(10));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(30));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
//        make.height.equalTo(@(100));
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    [self.titleLabel setText:data[kTeacherTitle]];
    [self.detailLabel setText:data[kTeacherContent]];
}

#pragma -
#pragma mark - getter and setter
-(UILabel*) titleLabel{
    
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font = H3;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UILabel*) detailLabel{
    
    if (!_detailLabel) {
        _detailLabel=[[UILabel alloc] init];
        _detailLabel.numberOfLines=0;
        _detailLabel.textColor = COLOR_GRAY;
        _detailLabel.font = H4;
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

-(UIView*) orangeView{
    if (!_orangeView) {
        _orangeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        _orangeView.backgroundColor=COLOR_ORANGE;
    }
    return _orangeView;
}
@end
