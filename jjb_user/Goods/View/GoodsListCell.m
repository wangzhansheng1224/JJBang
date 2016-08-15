//
//  GoodsListCell.m
//  jjb_user
//
//  Created by Check on 16/8/15.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsListCell.h"

@interface GoodsListCell ()

@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *salesLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation GoodsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.picImageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.salesLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.top.equalTo(@8);
        make.left.equalTo(@16);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 17));
        make.left.equalTo(_picImageV.mas_right).with.offset(8);
        make.top.equalTo(_picImageV.mas_top).with.offset(8);
    }];
    [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 14));
        make.left.equalTo(_picImageV.mas_right).with.offset(8);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(_salesLabel.mas_bottom).with.offset(12);
        make.right.equalTo(@-24);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.left.equalTo(@0);
        make.bottom.equalTo(@1);
    }];
    
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
        _titleLabel.text = @"摩卡 咖啡";
        _titleLabel.font = H2;
    }
    return _titleLabel;
}

-(UILabel *)salesLabel {
    
    if (!_salesLabel) {
        
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.textColor = COLOR_ORANGE;
        _salesLabel.font = H4;
        _salesLabel.text = @"月销量1024";
    }
    return _salesLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = COLOR_ORANGE;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"￥128";
        _priceLabel.font = H1;
    }
    return _priceLabel;
}

- (UILabel *)line {
    
    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_GRAY;
    }
    return _line;
}

@end
