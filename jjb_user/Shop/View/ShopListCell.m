//
//  ShopListCell.m
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopListCell.h"
#import "ShopIndexKeys.h"
/**
 *  所有门店
 */
@interface ShopListCell ()
@property(nonatomic,weak)UILabel * shopNameLabel;
@property(nonatomic,weak)UILabel * shopIDLabel;
@end

@implementation ShopListCell

#pragma -
#pragma  mark - life cycle

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
    if (self ) {
        [self addSubViewConstraints];
    }
    return self;
}

-(void)addSubViewConstraints
{
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.shopIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopNameLabel.mas_top);
        make.bottom.equalTo(self.shopNameLabel.mas_bottom);
        make.left.equalTo(self.shopNameLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right);
    }];
}

#pragma 
#pragma mark - configWithData
-(void)configWithData:(NSDictionary *)data
{
    [self.shopNameLabel setText:data[kShopIndexShopListName]];
    [self.shopIDLabel setText:data[kShopIndexShopListID]];
}


#pragma 
#pragma mark - getter and setter
-(UILabel *)shopNameLabel
{
    if (_shopNameLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"测试门店";
        label.font = H4;
        [self.contentView addSubview:label];
        _shopNameLabel = label;
    }
    return _shopNameLabel;
}

-(UILabel *)shopIDLabel
{
    if (_shopIDLabel == nil) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"门店ID";
        label.font = H4;
        [self.contentView addSubview:label];
        _shopIDLabel = label;
    }
    return _shopIDLabel;
}


@end
