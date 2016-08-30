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

@property (nonatomic,strong) UIImageView *courseImg;//课程图片
@property (nonatomic,strong) UILabel *courseNameLabel;//课程名称
@property (nonatomic,strong) UILabel *shopNameLabel;//店铺名称
@property (nonatomic,strong) UILabel *nameLabel;//课时名称
@property (nonatomic,strong) UILabel *startEndTimeLabel;//开始结束时间
@property (nonatomic,strong) UILabel *lineLabel;//底部细线

@end

@implementation VideosListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.courseImg];
        [self.contentView addSubview:self.courseNameLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.shopNameLabel];
        [self.contentView addSubview:self.startEndTimeLabel];

        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    //课程图片
    [_courseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 178));
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
    }];
    //课程名称
    [_courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width-16, 20));
        make.top.equalTo(_courseImg.mas_bottom).with.offset(8);
        make.left.equalTo(@16);
    }];
    //店铺名称
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 16));
        make.left.equalTo(@16);
        make.top.equalTo(_courseNameLabel.mas_bottom).with.offset(8);
    }];
    //课时名称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 16));
        make.left.equalTo(@16);
        make.top.equalTo(_shopNameLabel.mas_bottom).with.offset(8);
    }];
    //起始时间
    [_startEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 16));
        make.left.equalTo(@16);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(8);
    }];
    //底部细线
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 4));
        make.left.equalTo(@0);
        make.top.equalTo(_startEndTimeLabel.mas_bottom).with.offset(2);
    }];

}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    
    [self.courseNameLabel setText:data[kVideosListTocourseName]];
    [self.shopNameLabel setText:data[kVideosListToShopName]];
    [self.nameLabel setText:data[kVideosListToName]];
    [self.startEndTimeLabel setText:data[kVideosListStartEndTime]];
    NSURL *url=[NSURL initWithImageURL:data[kVideosListTocourseImg] Size:self.courseImg.frame.size];
    JJBLog(@"kVideosListTocourseImgUrl=%@",url);
    
    [self.courseImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_default"]];
    

}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)courseImg {
    
    if (!_courseImg) {
        _courseImg = [[UIImageView alloc] init];
    }
    return _courseImg;
}

- (UILabel *)courseNameLabel {
    
    if (!_courseNameLabel) {
        
        _courseNameLabel = [[UILabel alloc] init];
        _courseNameLabel.font = H2;
    }
    return _courseNameLabel;
}
- (UILabel *)shopNameLabel {
         
    if (!_shopNameLabel) {
             
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = H4;
        _shopNameLabel.textColor = COLOR_GRAY;
    }
    return _shopNameLabel;
}
- (UILabel *)nameLabel {
         
    if (!_nameLabel) {
             
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = H4;
        _nameLabel.textColor = COLOR_GRAY;
    }
    return _nameLabel;
}
- (UILabel *)startEndTimeLabel {
         
    if (!_startEndTimeLabel) {
             
        _startEndTimeLabel = [[UILabel alloc] init];
        _startEndTimeLabel.font = H4;
        _startEndTimeLabel.textColor = COLOR_GRAY;
    }
    return _startEndTimeLabel;
}



- (UILabel *)lineLabel {
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _lineLabel;
}

@end
