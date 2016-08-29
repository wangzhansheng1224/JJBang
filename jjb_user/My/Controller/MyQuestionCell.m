//
//  MyQuestionCell.m
//  jjb_user
//
//  Created by Check on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyQuestionCell.h"

@interface MyQuestionCell ()

@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *line;

@end

@implementation MyQuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = COLOR_LIGHT_GRAY;
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.bottom.right.equalTo(@-10);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma -
#pragma mark - configWithData
//- (void)configWithData:(NSDictionary *)data{
//    [self.descLabel setText:data[kCourseCatalogDesc]];
//    
//    CGSize size = [data[kCourseCatalogDesc] boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
//    
//    float height = size.height;
//    
//    if ([data[kCourseCatalogDesc] length] <= 0) {
//        height = 0;
//    }
//    
//    [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(height));
//        make.top.mas_equalTo(@10);
//        make.left.mas_equalTo(@10);
//        make.right.mas_equalTo(@-10);
//    }];
//}

#pragma -
#pragma mark - getters and setters

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"Q：如何联系客服解决问题\n\n您可以拨打家家帮客服电话或者在我的页面提交反馈";
        _descLabel.font = H3;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}
- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}

@end
