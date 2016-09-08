//
//  StudentDetailHeader.m
//  jjb_user
//
//  Created by Check on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailHeader.h"
#import "StudentKeys.h"

@interface StudentDetailHeader ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UIImageView *iconImageV;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation StudentDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.picImageV];
        [self addSubview:self.iconImageV];
        [self addSubview:self.nameLabel];
        [self addSubview:self.sexLabel];
        [self addSubview:self.ageLabel];
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
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(34, 16));
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(6);
        make.left.equalTo(self.sexLabel.mas_right).with.offset(0);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picImageV.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@10);
    }];
}


- (void)configWithData:(NSDictionary *)data{
    NSURL *url=[NSURL initWithImageURL:data[kStudentPhoto] Width:50 Height:50];
    [self.iconImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    [self.nameLabel setText:data[kStudentName]];
    [self.ageLabel setText:data[kStudentAge]];
    if ([data[kStudentSex] integerValue]==1) {
        [self.sexLabel setText:@"男"];
    } else if ([data[kStudentSex] integerValue]==0)
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
        _nameLabel.font = H3;
        _nameLabel.textColor = COLOR_WHITE;
    }
    return _nameLabel;
}

- (UILabel *)sexLabel {
    
    if (!_sexLabel) {
        
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.font = H3;
        _sexLabel.textColor = COLOR_WHITE;
    }
    return _sexLabel;
}

- (UILabel *)ageLabel {
    
    if (!_ageLabel) {
        
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.font = H3;
        _ageLabel.textColor = COLOR_WHITE;
        _ageLabel.textAlignment = NSTextAlignmentRight;
    }
    return _ageLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}

@end
