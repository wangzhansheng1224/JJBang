//
//  ContactServiceCell.m
//  jjb_user
//
//  Created by Check on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ContactServiceCell.h"
#import "StoreDetailKeys.h"

@interface ContactServiceCell ()

@property (nonatomic,strong) UILabel *nameLabel;    //门店名字
@property (nonatomic,strong) UILabel *locationLabel;    //地址
@property (nonatomic,strong) UILabel *phoneLabel;   //电话

@end

@implementation ContactServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
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
        make.bottom.equalTo(_phoneLabel.mas_top).with.offset(-10);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@20);
        make.bottom.equalTo(@-10);
    }];
}

#pragma -
#pragma mark - private methods
- (void)configWithData:(NSDictionary *)data
{
    self.nameLabel.text = [NSString stringWithFormat:@"门店名称：%@",data[kStoreName]];
    self.locationLabel.text = [NSString stringWithFormat:@"地址：%@",data[kStoreAddress]];
    self.phoneLabel.text = [NSString stringWithFormat:@"电话：%@",data[kStoreMobile]];
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
        _locationLabel.textColor = COLOR_GRAY;
        _locationLabel.text = @"常营";
        _locationLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _locationLabel.numberOfLines = 0;
    }
    return _locationLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = H3;
        _phoneLabel.textColor = [UIColor blueColor];
        _phoneLabel.text = @"1235433553";
    }
    return _phoneLabel;
}

@end
