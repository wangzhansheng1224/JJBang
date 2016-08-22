//
//  MineTableViewCell.m
//  Mine
//
//  Created by Check on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MineTableViewCell.h"
#import "RHHeader.h"

@interface MineTableViewCell ()

@property (nonatomic,strong) UIImageView *headerImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *rightImage;

@end

@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.rightImage];
        [self.contentView addSubview:self.titleLabel];
        
    }
    
    return self;
}

-(void) layoutSubviews{
    UIView *superView=self;
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.width.height.mas_equalTo(@24);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(10);
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.height.mas_equalTo(@30);
        make.right.mas_equalTo(self.rightImage.mas_left);
    }];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
}

- (void)refreshCellWithModel:(MineModel *)model {
    
    _headerImageView.image = [UIImage imageNamed:model.image];
    
    _titleLabel.text = model.title;
}

#pragma mark -- getter and setter
- (UIImageView *)headerImageView {

    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_course"]];
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImageView *)rightImage {

    if (!_rightImage) {
        
        _rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_right"]];
    }
    return _rightImage;
}


@end
