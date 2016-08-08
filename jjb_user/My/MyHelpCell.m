//
//  MyHelpCell.m
//  jjb_user
//
//  Created by Check on 16/8/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyHelpCell.h"

@interface MyHelpCell ()

@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_right;

@end

@implementation MyHelpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.imageView_right];
        
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 16));
        make.top.left.equalTo(@16);
    }];
    
    [self.imageView_right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 20));
        make.right.equalTo(@16);
        make.top.equalTo(@20);
    }];
}



#pragma -
#pragma mark - getters and setters
- (UILabel *)label_title {

    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
    }
    return _label_title;
}

- (UIImageView *)imageView_right {

    if (!_imageView_right) {
        
        _imageView_right = [[UIImageView alloc] init];
        _imageView_right.image = [UIImage imageNamed:@"my_right"];
    }
    return _imageView_right;
}

@end
