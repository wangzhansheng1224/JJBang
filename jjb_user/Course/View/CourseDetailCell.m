//
//  CourseDetailCell.m
//  jjb_user
//
//  Created by Check on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseDetailCell.h"
#import "CourseKeys.h"

@interface CourseDetailCell ()

@property (nonatomic,strong) UILabel *descLabel;

@end

@implementation CourseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.descLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@20);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    [self.descLabel setText:data[kCourseDescribe]];
    CGSize size = [data[kCourseDescribe] boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
    
    float height = size.height;
    
    if ([data[kCourseDescribe] length] <= 0) {
        height = 0;
    }
    
    [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.top.mas_equalTo(@10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
    }];
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

@end
