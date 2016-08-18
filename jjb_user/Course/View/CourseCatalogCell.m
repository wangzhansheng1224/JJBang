//
//  CourseCatalogCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseCatalogCell.h"
#import "CourseCatalogKeys.h"

@interface CourseCatalogCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIImageView *dropdownImageView;
@end

@implementation CourseCatalogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.dropdownImageView];
        [self addSubview:self.descLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    UIView *superView=self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(self.dropdownImageView.mas_right);
        make.height.mas_equalTo(30);
    }];
    [self.dropdownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-10);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    [self.titleLabel setText:data[kCourseCatalogTitle]];
    [self.descLabel setText:data[kCourseCatalogDesc]];
    
    
    CGSize size = [data[kCourseCatalogDesc] boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H3} context:nil].size;
    
    float height = size.height;
    
    if ([data[kCourseCatalogDesc] length] <= 0) {
        height = 0;
    }
    
    [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
}

-(void)changeDisplay:(id)sender
{
    self.descLabel.hidden=!self.descLabel.hidden;
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)dropdownImageView {
    
    if (!_dropdownImageView) {
        _dropdownImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"course_down"]];
        _dropdownImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeDisplay:)];
        [_dropdownImageView addGestureRecognizer:tap];
        _dropdownImageView.backgroundColor=COLOR_WHITE;
    }
    return _dropdownImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"第一节课 拉伸运动";
        _titleLabel.font = H3;
        _titleLabel.textColor=COLOR_GRAY;
        [_titleLabel sizeToFit];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"第一节课 拉伸运动";
        _descLabel.hidden=YES;
        _descLabel.font = H3;
        [_descLabel sizeToFit];
        _descLabel.backgroundColor=JJBRandomColor;
        _descLabel.textColor=COLOR_GRAY;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}
@end
