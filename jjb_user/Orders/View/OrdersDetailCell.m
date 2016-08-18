//
//  OrdersDetailCell.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrdersDetailCell.h"

@interface OrdersDetailCell ()

@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *describeLabel;    //商品描述
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation OrdersDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.picImageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLabel];
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
       
        make.left.equalTo(@16);
        make.top.equalTo(@8);
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@16);
        make.left.equalTo(_picImageV.mas_right).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(70, 17));
    }];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(16);
        make.centerX.equalTo(_titleLabel.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@16);
        make.right.equalTo(@-16);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@0);
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
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
        _titleLabel.text = @"商品名称";
        _titleLabel.font = H2;
    }
    return _titleLabel;
}

- (UILabel *)describeLabel {

    if (!_describeLabel) {
        
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.text = @"商品描述";
        _describeLabel.font = H4;
        _describeLabel.textColor = COLOR_GRAY;
    }
    return _describeLabel;
}

- (UILabel *)priceLabel {

    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"￥1080";
        _priceLabel.font = H4;
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UILabel *)line {

    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

@end
