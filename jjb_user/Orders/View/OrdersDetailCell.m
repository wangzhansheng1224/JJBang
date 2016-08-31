//
//  OrdersDetailCell.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrdersDetailCell.h"
#import "OrdersDetailKey.h"
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
        make.size.mas_equalTo(CGSizeMake(Screen_Width/4.0, Screen_Width/4.0));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@16);
        make.left.mas_equalTo(_picImageV.mas_right).with.offset(8);
        make.right.mas_equalTo(_priceLabel.mas_left).offset(8);
        make.height.equalTo(@17);
    }];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(16);
//        make.centerX.equalTo(_titleLabel.mas_centerX);
        make.left.equalTo(_picImageV.mas_right).with.offset(8);
        make.right.equalTo(@8);
        make.height.equalTo(@14);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@16);
        make.right.equalTo(@-16);
        make.size.mas_equalTo(CGSizeMake(100, 14));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@0);
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
    }];
}


- (void)configWithData:(NSDictionary *)data
{
    [self.titleLabel setText:data[kOrdersDetailName]];
    NSString * URLString = [NSString stringWithFormat:@"%@%@",ImageServer,data[kOrdersDetailImage]];
    NSURL * imageURL = [NSURL URLWithString:URLString];
    [self.picImageV sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"img_default"]];
    float price = [data[kOrdersDetailPayPrice] floatValue];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥ %.2f",price]];
    [self.describeLabel setText:[NSString stringWithFormat:@" %@ 课时",data[kOrdersDetailCourseNum]]];
    if ([data[kOrdersDetailType] isEqualToString:@"1"]) {
        self.describeLabel.hidden = YES;
    }else {
        self.describeLabel.hidden = NO;
    }
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
//        _describeLabel.text = @"商品描述";
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
