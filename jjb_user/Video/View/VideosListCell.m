//
//  VideosListCell.m
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosListCell.h"
#import "VideosListKey.h"


@interface VideosListCell ()

@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *salesLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation VideosListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.picImageV];
        [self.contentView addSubview:self.titleLabel];
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
        make.top.equalTo(@10);
        make.left.equalTo(@10);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 17));
        make.left.equalTo(_picImageV.mas_right).with.offset(10);
        make.top.equalTo(_picImageV.mas_top).with.offset(10);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.left.equalTo(@0);
        make.bottom.equalTo(@1);
    }];
    
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    
//    [self.titleLabel setText:data[kVideosListToName]];
//    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@",data[kVideosListToPrice]]];
    NSURL *url=[NSURL initWithImageURL:data[kVideosListImageUrl] Size:self.picImageV.frame.size];
    [self.picImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];

}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)picImageV {
    
    if (!_picImageV) {
        _picImageV = [[UIImageView alloc] init];
    }
    return _picImageV;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"摩卡咖啡";
        _titleLabel.font = H2;
    }
    return _titleLabel;
}





- (UILabel *)line {
    
    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

@end
