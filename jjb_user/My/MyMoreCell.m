//
//  MyMoreCell.m
//  jjb_user
//
//  Created by Check on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyMoreCell.h"

@interface MyMoreCell ()

@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_icon;
@property (nonatomic,strong) UILabel *label_line;
@property (nonatomic,strong) NSArray *textArr;

@end

@implementation MyMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
    
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.imageView_icon];
        [self.contentView addSubview:self.label_line];
        [self layoutPageSubviews];
    }
    return self;
}


#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@17);
        make.top.equalTo(@20);
        make.left.equalTo(@18);
        make.right.mas_equalTo(_imageView_icon.mas_left);
    }];
    
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(12, 20));
        make.top.equalTo(@22);
        make.right.equalTo(@-16);
    }];
    
    [self.label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
}


#pragma -
#pragma mark - getters and setters
- (UILabel *)label_title {

    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        NSLog(@"%@qqqq",_label_title.text);
        _label_title.font = H2;
        _label_title.textColor = COLOR_GRAY;
    }
    return _label_title;
}

- (UIImageView *)imageView_icon {

    if (!_imageView_icon) {
        
        _imageView_icon = [[UIImageView alloc] init];
        _imageView_icon.image = [UIImage imageNamed:@"my_right"];
    }
    return _imageView_icon;
}

- (UILabel *)label_line {

    if (!_label_line) {
        
        _label_line = [[UILabel alloc] init];
        _label_line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _label_line;
}

- (void)setTitle:(NSString *)title {
    
    _label_title.text = title;
}

@end
