//
//  GrowingCell.m
//  jjb_user
//
//  Created by Check on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingCell.h"
#import "GrowingTreeListKey.h"
#import "AppDelegate.h"

@interface GrowingCell ()<MWPhotoBrowserDelegate>

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *moodLabel;
@property (nonatomic,strong) UIImageView *locView;
@property (nonatomic,strong) UILabel *locLabel;
@property (nonatomic,strong) NSMutableArray *photos;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation GrowingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.view_image];
        [self.contentView addSubview:self.moodLabel];
        [self.contentView addSubview:self.locView];
        [self.contentView addSubview:self.locLabel];
        [self.contentView addSubview:self.lineView];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark -- layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_timeLabel.mas_left);
        make.centerY.equalTo(self.iconView.mas_centerY);
        make.left.equalTo(_iconView.mas_right).with.offset(10);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 14));
        make.centerY.mas_equalTo(self.iconView.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
    [_view_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_moodLabel.mas_top);
        make.top.equalTo(_iconView.mas_bottom);
        make.left.equalTo(self.mas_left).with.offset(8);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
    [_moodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.bottom.equalTo(_locView.mas_top).with.offset(-10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    [_locView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.height.mas_equalTo(@13);
        make.width.mas_equalTo(@12);
    }];
    [_locLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@14);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(_locView.mas_right).with.offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    
    [self.nameLabel setText:data[kGrowingTreeListFromUserName]];
    [self.locLabel setText:data[kGrowingTreeListAddress]];
    [self.timeLabel setText:data[kGrowingTreeListCreateTime]];
    [self.moodLabel setText:data[kGrowingTreeListContent]];
    
    NSURL *url=[NSURL initWithImageURL:data[kGrowingTreeListFromUserFace] Width:40 Height:40];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    float width = (Screen_Width - 8 * 4)/3.0;
    
    NSArray * imageArr = data[kGrowingTreeListImages];
    _photos=[[NSMutableArray alloc] initWithCapacity:0];
    [self.view_image.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < imageArr.count; i++) {
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%3 * (width+8), i/3 * (77+8)+8, width, 77)];
        NSURL *url=[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",ImageServer,imageArr[i][kGrowingTreeListImagesPath]]];
        
        MWPhoto *photo = [MWPhoto photoWithURL:url];
        [_photos addObject:photo];
        imageView.userInteractionEnabled=YES;
        [imageView sd_setImageWithURL:[NSURL initWithImageURL:imageArr[i][kGrowingTreeListImagesPath] Size:imageView.frame.size] placeholderImage:[UIImage imageNamed:@"pic_default"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
        imageView.tag = 2016 + i;
        UITapGestureRecognizer  *tapGR=  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [imageView addGestureRecognizer:tapGR];
        
        [self.view_image addSubview:imageView];
    }

    CGSize size = [data[kGrowingTreeListContent] boundingRectWithSize:CGSizeMake(Screen_Width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H4} context:nil].size;
    
    float height = size.height;
    
    if ([data[kGrowingTreeListContent] length] <= 0) {
        
        height = 0;
    }
    
    [_moodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(height));
        make.bottom.equalTo(_locView.mas_top).with.offset(-10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
}


#pragma -
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    
    return  [_photos count];
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

#pragma -
#pragma mark - event respone
- (void)tapGR:(UITapGestureRecognizer *)tap {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    UIImageView *imgView=(UIImageView*)tap.view;
    [browser setCurrentPhotoIndex:imgView.tag-2016];
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    [navController pushViewController:browser animated:YES];
}

#pragma -
#pragma mark - getters and setters
- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 20;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = H3;
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = H4;
        _timeLabel.textColor = COLOR_GRAY;
        [_timeLabel sizeToFit];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)moodLabel {
    
    if (!_moodLabel) {
        
        _moodLabel = [[UILabel alloc] init];
        _moodLabel.font = H4;
        _moodLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _moodLabel.numberOfLines = 0;
    }
    return _moodLabel;
}

- (UIImageView *)locView {
    
    if (!_locView) {
        _locView = [[UIImageView alloc] init];
        _locView.image = [UIImage imageNamed:@"growing_loc"];
        _locView.contentMode = UIViewContentModeScaleAspectFill;
        _locView.clipsToBounds = YES;
    }
    return _locView;
}

- (UILabel *)locLabel {
    
    if (!_locLabel) {
        _locLabel = [[UILabel alloc] init];
        _locLabel.textColor = COLOR_ORANGE;
        _locLabel.font = H6;
    }
    return _locLabel;
}

- (UIView *)view_image {
    
    if (!_view_image) {
        
        _view_image = [[UIView alloc] init];
    }
    return _view_image;
}

-(UIView*)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _lineView;
}
@end
