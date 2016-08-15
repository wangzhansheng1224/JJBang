//
//  StudentDetailHeader.m
//  jjb_user
//
//  Created by Check on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailHeader.h"

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
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 202));
        make.top.left.equalTo(@0);
    }];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(78, 78));
        make.bottom.equalTo(self.picImageV.mas_bottom).with.offset(4);
        make.left.equalTo(@16);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 16));
        make.top.equalTo(@137);
        make.left.equalTo(self.iconImageV.mas_right).with.offset(14);
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
        make.top.equalTo(_picImageV.mas_bottom).with.offset(8);
        make.left.right.equalTo(@0);
        make.height.equalTo(@(10));
    }];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)picImageV {
    
    if (!_picImageV) {
        
        _picImageV = [[UIImageView alloc] init];
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

- (UILabel *)ageLabel {
    
    if (!_ageLabel) {
        
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.text = @"3岁";
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
