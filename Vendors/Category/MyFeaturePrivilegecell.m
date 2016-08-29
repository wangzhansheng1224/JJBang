//
//  MyFeaturePrivilegecell.m
//  jjb_user
//
//  Created by Maybe on 16/8/26.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyFeaturePrivilegecell.h"

@interface MyFeaturePrivilegecell ()
@property(nonatomic,strong)UILabel * levelLabel;
@property(nonatomic,strong)UILabel * nowlevelLabel;
@property(nonatomic,strong)UILabel * moneyLabel;
@property(nonatomic,strong)UILabel * figureLabel;
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * disLabel;

@end
@implementation MyFeaturePrivilegecell

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
        label.text = @"下一等级";
        label.textColor = JJBColor(182, 182, 182);
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
        NSString * string = [[NSString alloc]init];
        switch ([UserModel currentUser].level +1) {
            case 0:
                string = @"铜牌会员";
                break;
            case 1:
                string = @"银牌会员";
                break;
            case 2:
                string = @"金牌会员";
                break;
            case 3:
                string = @"钻石会员";
                break;
            default:
                string = @"钻石会员";
                break;
        }
        label.text = string;

        label.textColor = JJBColor(182, 182, 182);

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
        label.textColor = JJBColor(182, 182, 182);

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
        NSString * string = [[NSString alloc]init];
        switch ([UserModel currentUser].level+1) {
            case 0:
                string = @"3000";
                break;
            case 1:
                string = @"10000";
                break;
            case 2:
                string = @"100000";
                break;
            case 3:
                string = @"1000000";
                break;
            default:
                break;
        }
        
        label.text = string;

        label.textColor = JJBColor(182, 182, 182);

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
        imageView.image = [UIImage imageNamed:@"my_level_privilege_1"];
        [self.contentView addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
-(UILabel *)disLabel
{
    if (_disLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        NSString * string = [[NSString alloc]init];
        switch ([UserModel currentUser].level +1) {
            case 0:
                string = @"100%";
                break;
            case 1:
                string = @"98%";
                break;
            case 2:
                string = @"95%";
                break;
            case 3:
                string = @"88%";
                break;
            default:
                break;
        }
        
        label.text =string;

        label.textColor = JJBColor(182, 182, 182);
        [label sizeToFit];
        [self.contentView addSubview:label];
        _disLabel = label;
    }
    return _disLabel;
    
}


@end
