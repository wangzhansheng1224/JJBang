//
//  ActivityInfoCell.m
//  jjb_user
//
//  Created by Check on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityInfoCell.h"

@interface ActivityInfoCell ()

@property (nonatomic,strong) UIImageView *imageView_icon;
@property (nonatomic,strong) UILabel *label_name;

@end

@implementation ActivityInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.imageView_icon];
        [self.contentView addSubview:self.label_name];
        
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(@16);
        make.top.equalTo(@8);
    }];
    
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 16));
        make.top.equalTo(@16);
        make.left.equalTo(self.imageView_icon.mas_right).with.offset(8);
    }];
}


#pragma -
#pragma mark - getters and setters 
- (UIImageView *)imageView_icon {

    if (!_imageView_icon) {
        
        _imageView_icon = [[UIImageView alloc] init];
        _imageView_icon.image = [UIImage imageNamed:@""];
        _imageView_icon.backgroundColor = COLOR_DARK_GRAY;
        _imageView_icon.layer.cornerRadius = 15;
        _imageView_icon.clipsToBounds = YES;
    }
    return _imageView_icon;
}

- (UILabel *)label_name {

    if (!_label_name) {
        
        _label_name = [[UILabel alloc] init];
        _label_name.text = @"王璐璐";
        _label_name.font = H3;
        _label_name.textColor = COLOR_DARK_GRAY;
    }
    return _label_name;
}

@end

