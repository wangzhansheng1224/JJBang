//
//  CourseRegistrationCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseRegistrationCell.h"
#import "UserKeys.h"

@interface CourseRegistrationCell ()

@property (nonatomic,strong) UIView *view_line;
@property (nonatomic,strong) UILabel *nicknameLabel;
@property (nonatomic,strong) UIImageView *userfaceImageview;
@property (nonatomic,strong) UILabel *remarkLabel;

@end

@implementation CourseRegistrationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self addSubview:self.view_line];
        [self addSubview:self.userfaceImageview];
        [self addSubview:self.nicknameLabel];
        [self addSubview:self.remarkLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView *superView=self;
    
    [self.view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.top.mas_equalTo(superView.mas_top);
        make.height.mas_equalTo(@(10));
    }];
    [self.userfaceImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.top.mas_equalTo(superView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userfaceImageview.mas_right).offset(10);
        make.top.mas_equalTo(superView.mas_top).offset(20);
        make.right.mas_equalTo(superView.mas_right);
        make.height.mas_equalTo(@(20));
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nicknameLabel.mas_left);
        make.top.mas_equalTo(self.nicknameLabel.mas_bottom);
        make.right.mas_equalTo(superView.mas_right);
        make.height.mas_equalTo(@(20));
    }];
    
    
    
}


#pragma -
#pragma mark - configWithData

- (void)configWithData:(NSDictionary *)data{
    NSURL *url=[NSURL initWithImageURL:data[kUserFace] Width:50 Height:50];
    [self.userfaceImageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    [self.nicknameLabel setText:data[kUserName]];
}

#pragma -
#pragma mark - getters and setters

-(UIView*) view_line{
    if (!_view_line) {
        _view_line=[[UIView alloc] init];
        _view_line.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _view_line;
}

-(UIImageView*) userfaceImageview{
    
    if (!_userfaceImageview) {
        _userfaceImageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_default"]];
        _userfaceImageview.layer.cornerRadius = 25;
        _userfaceImageview.clipsToBounds = YES;
    }
    return _userfaceImageview;
}

- (UILabel *)nicknameLabel {
    
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = H3;
        _nicknameLabel.textColor=COLOR_GRAY;
        _nicknameLabel.numberOfLines = 1;
        [_nicknameLabel sizeToFit];
    }
    return _nicknameLabel;
}

- (UILabel *)remarkLabel {
    
    if (!_remarkLabel) {
        
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.font = H4;
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.textColor=COLOR_GRAY;
        _remarkLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_remarkLabel setContentMode:UIViewContentModeTop];
        
    }
    return _remarkLabel;
}

@end
