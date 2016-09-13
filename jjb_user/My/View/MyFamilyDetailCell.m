//
//  MyFamilyDetailCell.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyFamilyDetailCell.h"
#import "MemberModel.h"

@interface MyFamilyDetailCell ()

@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *roleLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation MyFamilyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headerImageV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.roleLabel];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {

    [_headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageV.mas_right).with.offset(10);
        make.centerY.equalTo(_headerImageV.mas_centerY);
        make.right.equalTo(_roleLabel.mas_left);
        make.height.equalTo(@30);
    }];
    [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-30);
        make.centerY.equalTo(_headerImageV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSArray *)data {

    MemberModel *model = data;
    [_headerImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageServer,model.photo]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly];
    [_nameLabel setText:model.name];
    if (model.role ) {
        [_roleLabel setText:@"爸爸"];
    } else if (model.role == 1) {
        [_roleLabel setText:@"妈妈"];
    } else if (model.role == 2) {
        [_roleLabel setText:@"孩子"];
    } else if (model.role == 3) {
        [_roleLabel setText:@"爷爷"];
    } else {
        [_roleLabel setText:@"奶奶"];
    }
}
#pragma -
#pragma mark - getters and setters
- (UIImageView *)headerImageV {
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc] init];
        _headerImageV.backgroundColor = JJBRandomColor;
        _headerImageV.layer.cornerRadius = 40;
        _headerImageV.clipsToBounds = YES;
    }
    return _headerImageV;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}
- (UILabel *)roleLabel {
    if (!_roleLabel) {
        _roleLabel = [[UILabel alloc] init];
        _roleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _roleLabel;
}
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}
@end
