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
    
    
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
}

#pragma -
#pragma mark - getters and setters
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        
    }
    return _nameLabel;
}
- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        
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
