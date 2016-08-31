//
//  ContactServiceCell.m
//  jjb_user
//
//  Created by Check on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ContactServiceCell.h"

@interface ContactServiceCell ()

@property (nonatomic,strong) UILabel *nameLabel;    //门店名字
@property (nonatomic,strong) UILabel *locationLabel;    //地址
@property (nonatomic,strong) UILabel *phoneLabel;   //电话

@end

@implementation ContactServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = JJBRandomColor;
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.locationLabel];
        [self.contentView addSubview:self.phoneLabel];
        
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@20);
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@20);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationLabel.mas_bottom).with.offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@20);
    }];
}

#pragma -
#pragma mark - private methods
- (void)configWithData:(NSDictionary *)data
{
    
}
#pragma -
#pragma mark - getters and setters
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = H1;
        _nameLabel.text = @"家家帮成长馆";
    }
    return _nameLabel;
}
- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = H3;
        _locationLabel.textColor = COLOR_LIGHT_GRAY;
        _locationLabel.text = @"常营";
    }
    return _locationLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.backgroundColor = JJBRandomColor;
        _phoneLabel.text = @"1235433553";
    }
    return _phoneLabel;
}

@end
