//
//  TeacherListCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/20.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherListCell.h"
#import "StarView.h"
#import "TeacherKeys.h"

@interface TeacherListCell()
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *clerkFaceIView;
@property (nonatomic,strong) UILabel *nicknameLabel;
@property (nonatomic,strong) StarView *starView;
@end

@implementation TeacherListCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.lineView];
        [self addSubview:self.clerkFaceIView];
        [self addSubview:self.nicknameLabel];
        [self addSubview:self.starView];
    }
    return self;
}

#pragma -
#pragma mark - layoutSubviews
-(void)layoutSubviews{
    UIView *superView=self;
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top);
        make.left.mas_equalTo(superView.mas_left);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(superView.mas_width);
    }];
    [self.clerkFaceIView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@50);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.clerkFaceIView.mas_right).offset(10);
        make.height.mas_equalTo(@30);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nicknameLabel.mas_bottom);
        make.left.mas_equalTo(self.nicknameLabel.mas_left);
        make.right.mas_equalTo(superView.mas_right).offset(10);
        make.height.mas_equalTo(@30);
    }];
}


#pragma -
#pragma mark - configWithData

- (void)configWithData:(NSDictionary *)data{
    
    NSURL *url=[NSURL initWithImageURL:data[kTeacherPhoto] Width:50 Height:50];
    [self.clerkFaceIView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    [self.nicknameLabel setText:data[kTeacherName]];
}


#pragma -
#pragma mark - getter and setter


-(UIView*) lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}

-(UIImageView*)clerkFaceIView{
    if (!_clerkFaceIView) {
        _clerkFaceIView=[[UIImageView alloc] init];
        _clerkFaceIView.layer.cornerRadius=25.0f;
        _clerkFaceIView.layer.masksToBounds=YES;
    }
    return _clerkFaceIView;
}


-(UILabel*) nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel=[[UILabel alloc] init];
        [_nicknameLabel setFont:H2];
        [_nicknameLabel setText:@"王书奎"];
    }
    return _nicknameLabel;
}

-(StarView*) starView{
    
    if (!_starView) {
        _starView=[[StarView alloc] init];
        _starView.score=5.0f;
    }
    return _starView;
}

@end
