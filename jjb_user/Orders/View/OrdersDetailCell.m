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

@end

@implementation OrdersDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
    }
    return self;
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

@end
