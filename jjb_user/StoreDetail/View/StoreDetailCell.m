//
//  TeacherDetailCell.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StoreDetailCell.h"
#import "StoreDetailKeys.h"

@interface StoreDetailCell()
@property (nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) UIView *orangeView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *detailLabel;

@end
@implementation StoreDetailCell


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor=JJBRandomColor;
        
        [self setBackgroundColor:COLOR_WHITE];
        [self addSubview:self.orangeView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self layoutSubviews];

    }
    return self;
}
#pragma -
#pragma mark - layoutSubviews
-(void)layoutSubviews{
    UIView *superView=self;
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left);
        make.height.equalTo(@(20));
        make.width.equalTo(@(10));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
//        make.height.equalTo(@(100));
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
    }];
}

#pragma -
#pragma mark - setTitleData
- (void)setVoteData:(NSDictionary *)data{
    [self.titleLabel setText:@"优 势"];
    [self.detailLabel setText:data[kStoreVotes]];
    [self configDataSize:data[kStoreVotes]];
}
- (void)setSummaryData:(NSDictionary *)data{
    [self.titleLabel setText:@"简 介"];
    [self.detailLabel setText:data[kStoreSummary]];
    [self configDataSize:data[kStoreSummary]];
}
-(void)configDataSize:(NSString *)dataString{
    
    CGSize size = [dataString boundingRectWithSize:CGSizeMake(Screen_Width -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H4} context:nil].size;
    
    float height = size.height;
    
    if ([dataString length] <= 0) {
        height = 0;
    }
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.equalTo(@(height+40));

    }];

}
#pragma -
#pragma mark - getter and setter
-(UILabel*) titleLabel{
    
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font = H3;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UILabel*) detailLabel{
    
    if (!_detailLabel) {
        _detailLabel=[[UILabel alloc] init];
        _detailLabel.font = H4;
        _detailLabel.textColor =  COLOR_GRAY;
        _detailLabel.numberOfLines=0;
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

-(UIView*) orangeView{
    if (!_orangeView) {
        _orangeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        _orangeView.backgroundColor=COLOR_ORANGE;
    }
    return _orangeView;
}

@end
