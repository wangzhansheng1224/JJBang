//
//  TeacherHeaderView.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherHeaderView.h"
#import "TeacherKeys.h"
#import "StarView.h"

@interface TeacherHeaderView ()

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) StarView *starView;
@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UIImageView *iconImageV;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation TeacherHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.picImageV];
        [self addSubview:self.iconImageV];
        [self addSubview:self.nameLabel];
        [self addSubview:self.sexLabel];
        [self addSubview:self.starView];
        [self addSubview:self.lineView];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 197));
        make.top.left.equalTo(@0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.bottom.equalTo(self.picImageV.mas_bottom).with.offset(-10);
        make.left.equalTo(@10);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(@20);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(_iconImageV.mas_top);
        make.left.equalTo(self.iconImageV.mas_right).offset(10);
    }];
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.equalTo(self.iconImageV.mas_right).with.offset(14);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(6);
    }];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.sexLabel.mas_bottom);
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picImageV.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@10);
    }];
}


- (void)configWithData:(NSDictionary *)data{
    NSURL *url=[NSURL initWithImageURL:data[kTeacherPhoto] Width:50 Height:50];
    [self.iconImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    [self.nameLabel setText:data[kTeacherName]];
    //[self.ageLabel setText:data[kTeacherAge]];
    if ([data[kTeacherSex] integerValue]==1) {
        [self.sexLabel setText:@"男"];
    } else if ([data[kTeacherSex] integerValue]==0)
    {
        [self.sexLabel setText:@"女"];
    } else
    {
        [self.sexLabel setText:@"未知"];
    }
    
    
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)picImageV {
    
    if (!_picImageV) {
        
        _picImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_background"]];
        _picImageV.backgroundColor = COLOR_GRAY;
    }
    return _picImageV;
}

- (UIImageView *)iconImageV {
    
    if (!_iconImageV) {
        
        _iconImageV = [[UIImageView alloc] init];
        _iconImageV.image = [UIImage imageNamed:@"student_icon"];
        _iconImageV.layer.cornerRadius = 39;
        _iconImageV.clipsToBounds = YES;
    }
    return _iconImageV;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"王鹿晗";
        _nameLabel.font = H3;
        _nameLabel.textColor = COLOR_WHITE;
    }
    return _nameLabel;
}

- (UILabel *)sexLabel {
    
    if (!_sexLabel) {
        
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"男";
        _sexLabel.font = H3;
        _sexLabel.textColor = COLOR_WHITE;
    }
    return _sexLabel;
}

- (StarView *)starView {
    
    if (!_starView) {
        _starView = [[StarView alloc] init];
        _starView.score=5.0f;
        _starView.backgroundColor=[UIColor clearColor];
    }
    return _starView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}

@end
