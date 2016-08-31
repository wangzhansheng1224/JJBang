//
//  TitleBar.m
//  jjb_user
//
//  Created by Aimee on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TitleBar.h"

@interface TitleBar ()
@property(nonatomic,strong) UIView *orangeView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *moreLabel;
@property(nonatomic,strong) MoreButtonClickBlock moreClickBlock;
@end

@implementation TitleBar

-(id) initWithTitle:(NSString*)title{
    self=[super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.orangeView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.moreLabel];
        [self.titleLabel setText:title];
        [self layoutPageSubviews];
    }
    return self;
}

-(void) moreButtonClick:(MoreButtonClickBlock) block{
    self.moreClickBlock=block;
}

-(void) moreLabelClick:(UITapGestureRecognizer *)recognizer{
    if (self.moreClickBlock) {
        self.moreClickBlock(self);
    }
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
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
        make.right.equalTo(_moreLabel.mas_left);
        make.height.equalTo(@(30));
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.width.equalTo(@(100));
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@(30));
    }];

}

#pragma -
#pragma mark - getter and setter
-(UILabel*) titleLabel{
    
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.text = @"最新活动";
        _titleLabel.font = H3;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UILabel*) moreLabel{
    
    if (!_moreLabel) {
        _moreLabel=[[UILabel alloc] init];
        _moreLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreLabelClick:)];
        [_moreLabel addGestureRecognizer:labelTapGestureRecognizer];
        _moreLabel.text = @"更多";
        _moreLabel.textColor=COLOR_GRAY;
        _moreLabel.font = H4;
        _moreLabel.textAlignment=NSTextAlignmentRight;
        [_moreLabel sizeToFit];
    }
    return _moreLabel;
}

-(UIView*) orangeView{
    if (!_orangeView) {
        _orangeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        _orangeView.backgroundColor=COLOR_ORANGE;
    }
    return _orangeView;
}
@end
