//
//  MyFamilyCell.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyFamilyCell.h"

@interface MyFamilyCell ()

@property (nonatomic,strong) UIImageView *iconImageV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *moreLabel;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UIScrollView *familySV;
@property (nonatomic,strong) NSMutableArray *nameArr;
@property (nonatomic,strong) NSMutableArray *photoArr;

@end

@implementation MyFamilyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconImageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.moreLabel];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.familySV];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.height.mas_equalTo(@24);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageV.mas_right).offset(10);
        make.centerY.equalTo(_iconImageV.mas_centerY);
        make.height.mas_equalTo(@20);
        make.right.mas_equalTo(_moreLabel.mas_left);
    }];
    [_moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.height.equalTo(@20);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageV.mas_bottom).with.offset(10);
        make.right.left.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [_familySV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(10);
        make.left.right.equalTo(@0);
        make.height.equalTo(@200);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data {

    NSDictionary *dic = data[@"myFamily"];
    self.photoArr = dic[@"familyMember"];

}



#pragma -
#pragma mark - getters and setters
- (UIImageView *)iconImageV {
    if (!_iconImageV) {
        _iconImageV = [[UIImageView alloc] init];
        _iconImageV.image = [UIImage imageNamed:@"my_family"];
    }
    return _iconImageV;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"我的家庭";
    }
    return _titleLabel;
}
- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.text = @"更多...";
        _moreLabel.font = H3;
        _moreLabel.textColor = COLOR_GRAY;
    }
    return _moreLabel;
}
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}
- (UIScrollView *)familySV {
    if (!_familySV) {
        float width1 = (Screen_Width - 16 * (3 + 1))/3;
        _familySV = [[UIScrollView alloc] init];
        _familySV.contentSize = CGSizeMake((width1 + 16) * 3 + 16, 30);
        _familySV.bounces = NO;
        _familySV.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < 10; i++) {
            UIImageView *headerView = [[UIImageView alloc] init];
            CGFloat width = 60;
            int cols = 3;
            CGFloat margin = (Screen_Width - 80 - cols * width) /4;

//            headerView.frame = CGRectMake(i * (width + 16)+16, 0, width, width);
            headerView.frame = CGRectMake((width+margin)*i+margin, 0, width, width);
            headerView.layer.cornerRadius = width/2.0;
            headerView.clipsToBounds = YES;
            headerView.backgroundColor = JJBRandomColor;
            
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.frame = CGRectMake((width+margin)*i+margin, width+10, width, 20);
            nameLabel.backgroundColor = JJBRandomColor;
            
            
            [_familySV addSubview:headerView];
            [_familySV addSubview:nameLabel];
        }
    }
    return _familySV;
}
- (NSMutableArray *)nameArr {
    if (!_nameArr) {
        _nameArr = [[NSMutableArray alloc] init];
    }
    return _nameArr;
}
- (NSMutableArray *)photoArr {
    if (!_photoArr) {
        _photoArr = [[NSMutableArray alloc] init];
    }
    return _photoArr;
}

@end
