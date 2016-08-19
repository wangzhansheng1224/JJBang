//
//  SelectMenuController.m
//  jjb_user
//
//  Created by Check on 16/8/19.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "SelectMenuController.h"
#import "MakeOrderBar.h"

@interface SelectMenuController ()

@property (nonatomic,strong) UIView *menuView;
@property (nonatomic,strong) UIImageView *picImageV;
@property (nonatomic,strong) UILabel *categoryLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *starImageV;
@property (nonatomic,strong) UILabel *teacherLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UILabel *classLabel;

@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,strong) MakeOrderBar *makeOrderBar;
@property (nonatomic,strong) UITapGestureRecognizer *tapGR;

@end

@implementation SelectMenuController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuView addSubview:self.picImageV];
    [self.menuView addSubview:self.categoryLabel];
    [self.menuView addSubview:self.titleLabel];
    [self.menuView addSubview:self.starImageV];
    [self.menuView addSubview:self.teacherLabel];
    [self.menuView addSubview:self.priceLabel];
    [self.menuView addSubview:self.line];
    [self.menuView addSubview:self.classLabel];
    [self.menuView addSubview:self.makeOrderBar];
    [self.view addSubview:self.menuView];
    [self.view addGestureRecognizer:self.tapGR];
    [self layoutPageSubviews];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {

    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 300));
        make.bottom.left.right.equalTo(@0);
    }];
    [_picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 120));
        make.top.left.equalTo(@10);
//        make.right.equalTo(_titleLabel.mas_left).with.offset(10);
    }];
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@20);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 12));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@18);
        make.left.equalTo(_picImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
        make.height.equalTo(@17);
    }];
    [_starImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@14);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(_picImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
    }];
    [_teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@14);
        make.top.equalTo(_starImageV.mas_bottom).with.offset(10);
        make.left.equalTo(_picImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@17);
        make.top.equalTo(_teacherLabel.mas_bottom).with.offset(10);
        make.left.equalTo(_picImageV.mas_right).with.offset(10);
        make.right.equalTo(@-10);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
        make.top.equalTo(_picImageV.mas_bottom).with.offset(10);
    }];
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(@10);
        make.top.equalTo(_line.mas_bottom).with.offset(10);
        make.height.equalTo(@16);
    }];
    [_makeOrderBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@50);
    }];
}

#pragma -
#pragma mark - event respone
- (void)tapGRClick {

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -
#pragma mark - getters and setters
- (UIView *)menuView {

    if (!_menuView) {
        
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = COLOR_WHITE;
    }
    return _menuView;
}
- (UIImageView *)picImageV {

    if (!_picImageV) {
        
        _picImageV = [[UIImageView alloc] init];
        _picImageV.backgroundColor = JJBRandomColor;
    }
    return _picImageV;
}
- (UILabel *)categoryLabel {

    if (!_categoryLabel) {
        
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.text = @"少儿";
    }
    return _categoryLabel;
}
- (UILabel *)titleLabel {

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"少儿美术";
        _titleLabel.font = H3;
    }
    return _titleLabel;
}
- (UIImageView *)starImageV {

    if (!_starImageV) {
        
        _starImageV = [[UIImageView alloc] init];
        _starImageV.backgroundColor = JJBRandomColor;
    }
    return _starImageV;
}
- (UILabel *)teacherLabel {

    if (!_teacherLabel) {
        
        _teacherLabel = [[UILabel alloc] init];
        _teacherLabel.text = @"王蒙 老师";
    }
    return _teacherLabel;
}
- (UILabel *)priceLabel {

    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"￥1080";
    }
    return _priceLabel;
}
- (UILabel *)classLabel {

    if (!_classLabel) {
        
        _classLabel = [[UILabel alloc] init];
        _classLabel.text = @"选择课时数量";
    }
    return _classLabel;
}
- (NSMutableArray *)btnArray {

    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
-(UILabel *)line {

    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line;
}
- (MakeOrderBar *)makeOrderBar {

    if (!_makeOrderBar) {
        
        _makeOrderBar = [[MakeOrderBar alloc] init];
    }
    return _makeOrderBar;
}

- (UITapGestureRecognizer *)tapGR {
    
    if (!_tapGR) {
        
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick)];
    }
    return _tapGR;
}

@end
