//
//  MyOrderDetailCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/11.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderDetailCell.h"
#import "MyOrderDetailKey.h"
@interface MyOrderDetailCell ()
@property(nonatomic,weak) UILabel * courseNameLabel;
@property(nonatomic,weak) UILabel * courseTimeLabel;
@property(nonatomic,weak) UILabel * courseMoneyLabel;

@end
@implementation MyOrderDetailCell

#pragma 
#pragma mark - life cycle

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self addSubViewConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithData:(NSDictionary *)data
{
    [self.courseNameLabel setText:data[kMyOrderDetailName]];
    [self.courseMoneyLabel setText:data[kMyOrderDetailPrice]];
    [self.courseTimeLabel setText:data[kMyOrderDetailTime]];
}
-(void)addSubViewConstraints
{
    [self.courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    [self.courseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.courseNameLabel.mas_bottom).offset(8);
        make.left.equalTo(self.courseNameLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
    }];
    [self.courseMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(22);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
}

#pragma 
#pragma mark getter and setter
-(UILabel *)courseNameLabel
{
    if (_courseNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"体育课程";
        _courseNameLabel = label;
        [label sizeToFit];
        [self.contentView addSubview:label];
    }
    return _courseNameLabel;
}

-(UILabel *)courseTimeLabel
{
    if (_courseTimeLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"2016 08-11-19-09";
        _courseTimeLabel = label;
        label.font = H4;
        label.textColor = COLOR_GRAY;
        [label sizeToFit];
        [self.contentView addSubview:label];
    }
    return _courseTimeLabel;
}

-(UILabel *)courseMoneyLabel
{
    if (_courseMoneyLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"-1080.00";
        _courseMoneyLabel = label;
        [label sizeToFit];
        [self.contentView addSubview:label];
    }
    return _courseMoneyLabel;
    
}
@end
