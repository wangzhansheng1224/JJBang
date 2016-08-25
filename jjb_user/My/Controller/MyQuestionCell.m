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

@end

@implementation MyQuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self addSubview:self.descLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    UIView *superView=self;
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_bottom).offset(10);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-10);
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
        _descLabel.text = @"第一节课 拉伸运动";
        _descLabel.font = H3;
        //        _descLabel.backgroundColor=JJBRandomColor;
        _descLabel.textColor=COLOR_GRAY;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

@end
