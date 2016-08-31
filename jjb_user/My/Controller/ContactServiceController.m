//
//  ContactServiceController.m
//  jjb_user    联系客服
//
//  Created by Check on 16/8/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ContactServiceController.h"

@interface ContactServiceController ()

@property (nonatomic,strong) UILabel *nameLabel;    //门店名字
@property (nonatomic,strong) UILabel *locationLabel;    //地址
@property (nonatomic,strong) UIButton *phoneBtn;   //电话

@end

@implementation ContactServiceController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"门店详情";
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.locationLabel];
    [self.view addSubview:self.phoneBtn];
    [self layoutPageSubviews];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@50);
        make.size.mas_equalTo(CGSizeMake(Screen_Width - 100, 40));
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(20);
        make.left.equalTo(@50);
        make.size.mas_equalTo(CGSizeMake(Screen_Width - 100, 40));
    }];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationLabel.mas_bottom).with.offset(20);
        make.left.equalTo(@50);
        make.size.mas_equalTo(CGSizeMake(Screen_Width - 100, 40));
    }];
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = H1;
    }
    return _nameLabel;
}
- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = H3;
        _locationLabel.textColor = COLOR_LIGHT_GRAY;
    }
    return _locationLabel;
}
- (UIButton *)phoneBtn {
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc] init];
        _phoneBtn.backgroundColor = JJBRandomColor;
        
    }
    return _phoneBtn;
}

@end
