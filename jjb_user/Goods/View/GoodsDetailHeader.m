//
//  GoodsDetailHeader.m
//  jjb_user
//
//  Created by Check on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsDetailHeader.h"
#import "HMSegmentedControl.h"

@interface GoodsDetailHeader()

@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *salesLabel;
@property (nonatomic,strong) UIView *line;

@end

@implementation GoodsDetailHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.picImageV];
        [self addSubview:self.titleLabel];
        [self addSubview:self.salesLabel];
        [self addSubview:self.line];
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
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85, 17));
        make.top.equalTo(_picImageV.mas_bottom).with.offset(16);
        make.left.equalTo(@24);
    }];
    [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 14));
        make.top.equalTo(_picImageV.mas_bottom).with.offset(16);
        make.right.equalTo(@-24);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(20);
        make.left.equalTo(@0);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
//    self.data=[[NSMutableDictionary alloc] initWithDictionary:data];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)picImageV {

    if (!_picImageV) {
        
        _picImageV = [[UIImageView alloc] init];
        _picImageV.backgroundColor = JJBRandomColor;
    }
    return _picImageV;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"曲奇 饼干";
        _titleLabel.font = H2;
        [_titleLabel sizeToFit];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)salesLabel {
    
    if (!_salesLabel) {
        
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"月销量1024";
        _salesLabel.textColor = COLOR_ORANGE;
        _salesLabel.font = H4;
        _salesLabel.textAlignment = NSTextAlignmentRight;
        [_salesLabel sizeToFit];
    }
    return _salesLabel;
}

-(UIView *)line{
    if (!_line) {
        
        _line=[[UIView alloc] init];
        _line.backgroundColor = COLOR_GRAY;
    }
    return _line;
}

@end
