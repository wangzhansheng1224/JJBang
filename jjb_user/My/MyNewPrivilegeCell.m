//
//  MyNewPrivilegeCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyNewPrivilegeCell.h"

@interface MyNewPrivilegeCell ()
@property(nonatomic,strong)UILabel * levelLabel;
@property(nonatomic,strong)UILabel * nowlevelLabel;
@property(nonatomic,strong)UILabel * moneyLabel;
@property(nonatomic,strong)UILabel * figureLabel;
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * disLabel;

@end
@implementation MyNewPrivilegeCell
#pragma -
#pragma mark - life cycle
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_WHITE;
        [self setChildViewsConstraints];
    }
    return self;
}
-(void)setChildViewsConstraints
{
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    [self.nowlevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelLabel.mas_top);
        make.left.equalTo(self.levelLabel.mas_right).offset(15);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelLabel.mas_bottom).offset(15);
        make.left.equalTo(self.levelLabel.mas_left);
    }];
    [self.figureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel.mas_top);
        make.left.equalTo(self.nowlevelLabel.mas_left);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.and.width.equalTo(@30);
    }];
    [self.disLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.right.equalTo(self.iconImageView.mas_right);
    }];
    
}

#pragma -
#pragma mark - getter and setter
-(UILabel *)levelLabel
{
    if (_levelLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"当前等级";
        [label sizeToFit];
        [self.contentView addSubview:label];
        _levelLabel = label;
    }
    return _levelLabel;
}
-(UILabel *)nowlevelLabel
{
    if (_nowlevelLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"铁牌等级";
        [label sizeToFit];
        [self.contentView addSubview:label];
        _nowlevelLabel = label;
    }
    return _nowlevelLabel;
    
}
-(UILabel *)moneyLabel
{
    
    if (_moneyLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"累计消费";
        [label sizeToFit];
        [self.contentView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;

}
-(UILabel *)figureLabel
{
    if (_figureLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"3000";
        [label sizeToFit];
        [self.contentView addSubview:label];
        _figureLabel = label;
    }
    return _figureLabel;
    
}
-(UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"my_level_privilege"];
        [self.contentView addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
-(UILabel *)disLabel
{
    if (_disLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"98%";
        [label sizeToFit];
        [self.contentView addSubview:label];
        _disLabel = label;
    }
    return _disLabel;

}
@end
