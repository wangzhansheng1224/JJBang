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

- (void)refreshCellWithModel:(MineModel *)model {
    
    _headerImageView.image = [UIImage imageNamed:model.image];
    
    _titleLabel.text = model.title;
}

#pragma mark -- getter and setter
- (UIImageView *)headerImageView {

    if (!_headerImageView) {
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
        _headerImageView.center = CGPointMake(_headerImageView.center.x, self.center.y);
        
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10, 0, CGRectGetMinX(_rightImage.frame)- CGRectGetMaxX(_headerImageView.frame) - 20, self.frame.size.height)];
    }
    return _titleLabel;
}

- (UIImageView *)rightImage {

    if (!_rightImage) {
        
        _rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
        
        _rightImage.image = [UIImage imageNamed:@"my_right"];
        
        _rightImage.center = CGPointMake(SCREEN_W - 25, self.center.y);
        
        _rightImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImage;
}


@end
