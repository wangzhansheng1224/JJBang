//
//  SelectMenuController.m
//  jjb_user
//
//  Created by Check on 16/8/19.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "SelectMenuController.h"
#import "MakeOrderBar.h"
#import "CoursePackagesAPIManager.h"
#import "CoursePackagesReformer.h"

@interface SelectMenuController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) LDAPIBaseManager *coursePackagesAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> coursePackagesReformer;
@property (nonatomic,strong) UIView *menuView;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UILabel *classLabel;

@property (nonatomic,strong) MakeOrderBar *makeOrderBar;
@property (nonatomic,strong) UITapGestureRecognizer *tapGR;
@property (nonatomic,strong) UIView *clearView;
@property (nonatomic,strong) UIScrollView *btnSV;

@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) NSDictionary *dataDic;

@end

@implementation SelectMenuController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuView addSubview:self.line];
    [self.menuView addSubview:self.classLabel];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.clearView];
    [self.clearView addGestureRecognizer:self.tapGR];
    [self.coursePackagesAPIManager loadData];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    [_clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(Screen_Height - 162 - 64);
        make.top.left.right.equalTo(@0);
    }];
    
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 162));
        make.bottom.left.right.equalTo(@0);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
    }];
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(@10);
        make.top.equalTo(_line.mas_bottom).with.offset(20);
        make.height.equalTo(@16);
    }];
    [_makeOrderBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@50);
    }];
    [_btnSV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_classLabel.mas_bottom).with.offset(20);
        make.left.right.equalTo(@0);
        make.height.equalTo(@56);
    }];
}

#pragma -
#pragma mark - event respone
- (void)tapGRClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnClick:(UIButton *)btn {
    NSInteger index = btn.tag - 100;
    [self.makeOrderBar configWithData:@{@"price":_arrData[index][@"CoursePackagesOrgPrice"]}];
    
    for (UIView * view in _btnSV.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton * packagesItem = (UIButton *)view;
            
            if (packagesItem == btn) {
                
                packagesItem.selected = YES;
                [packagesItem.layer setBorderColor:COLOR_ORANGE.CGColor];
            }else {
                
                packagesItem.selected = NO;
                [packagesItem.layer setBorderColor:COLOR_GRAY.CGColor];
            }
        }
    }
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[CoursePackagesAPIManager class]]) {

        NSArray *resultData = [manager fetchDataWithReformer:self.coursePackagesReformer];
        [self.arrData addObjectsFromArray:resultData];
        [self.makeOrderBar configWithData:@{@"price":_arrData[0][@"CoursePackagesOrgPrice"],@"objectID":_arrData[0][@"PackagesID"]}];
    
        [self.menuView addSubview:self.btnSV];
        [self.menuView addSubview:self.makeOrderBar];
        [self layoutPageSubviews];
    }
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    return @{
             @"course_id":@(self.courseID)
             };
}

#pragma -
#pragma mark - getters and setters

- (NSMutableArray *)arrData {
    
    if (!_arrData) {
        
        _arrData = [[NSMutableArray alloc] init];
    }
    return _arrData;
}
- (UIView *)menuView {
    
    if (!_menuView) {
        
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = COLOR_WHITE;
    }
    return _menuView;
}

- (UILabel *)classLabel {
    
    if (!_classLabel) {
        
        _classLabel = [[UILabel alloc] init];
        _classLabel.text = @"选择课时数量";
        _classLabel.font = H3;
    }
    return _classLabel;
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
- (UIView *)clearView {
    
    if (!_clearView) {
        
        _clearView = [[UIView alloc] init];
        _clearView.backgroundColor = [UIColor clearColor];
    }
    return _clearView;
}
- (UITapGestureRecognizer *)tapGR {
    
    if (!_tapGR) {
        
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick)];
    }
    return _tapGR;
}
- (UIScrollView *)btnSV {
    
    if (!_btnSV) {
        
        float width = (Screen_Width - 16 * (_arrData.count + 1))/3;
        
        _btnSV = [[UIScrollView alloc] init];
        _btnSV.contentSize = CGSizeMake((width + 16) * _arrData.count + 16, 30);
        _btnSV.bounces = NO;
        _btnSV.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < _arrData.count; i++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * (width + 16)+16, 0, width, 36)];
            btn.layer.cornerRadius = 3.0;
            btn.clipsToBounds = YES;
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:COLOR_GRAY.CGColor];
            NSString * str = [NSString stringWithFormat:@"%@", _arrData[i][@"CoursePackagesNums"]];
            [btn setTitle:[NSString stringWithFormat:@"%@课时",str] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ORANGE forState:UIControlStateSelected];
            btn.titleLabel.font = H4;
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                btn.selected = YES;
                [btn.layer setBorderColor:COLOR_ORANGE.CGColor];
            }
            [self.btnSV addSubview:btn];
        }
    }
    return _btnSV;
}

- (LDAPIBaseManager *)coursePackagesAPIManager {
    if (_coursePackagesAPIManager == nil) {
        _coursePackagesAPIManager = [CoursePackagesAPIManager  sharedInstance];
        _coursePackagesAPIManager.delegate=self;
        _coursePackagesAPIManager.paramSource=self;
    }
    return _coursePackagesAPIManager;
}

- (id<ReformerProtocol>)coursePackagesReformer {
    
    if (!_coursePackagesReformer) {
        _coursePackagesReformer = [[CoursePackagesReformer alloc] init];
    }
    return _coursePackagesReformer;
}

- (NSDictionary *)dataDic {
    
    if (!_dataDic) {
        
        _dataDic = [[NSDictionary alloc] init];
    }
    return _dataDic;
}

@end
