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
@property (nonatomic,strong) UILabel *membersLabel;
@property (nonatomic,strong) MakeOrderBar *makeOrderBar;
@property (nonatomic,strong) UITapGestureRecognizer *tapGR;
@property (nonatomic,strong) UIView *clearView;
@property (nonatomic,strong) UIScrollView *packagesSV;
@property (nonatomic,strong) UIScrollView *membersSV;
@property (nonatomic,strong) NSMutableArray *packagesData;
@property (nonatomic,strong) NSMutableArray *membersData;
@property (nonatomic,assign) NSInteger packagesIndex;
@property (nonatomic,assign) NSInteger membersIndex;

@end

@implementation SelectMenuController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _packagesIndex = 0;
    _membersIndex = 0;
    [self.menuView addSubview:self.line];
    [self.menuView addSubview:self.classLabel];
    [self.menuView addSubview:self.membersLabel];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.clearView];
    [self.clearView addGestureRecognizer:self.tapGR];
    [self.coursePackagesAPIManager loadData];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Screen_Height - 274 - 64);
        make.top.left.right.equalTo(@0);
    }];
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 274));
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
    [_packagesSV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_classLabel.mas_bottom).with.offset(20);
        make.left.right.equalTo(@0);
        make.height.equalTo(@56);
    }];
    [_membersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@10);
        make.top.equalTo(_packagesSV.mas_bottom).with.offset(10);
        make.height.equalTo(@16);
    }];
    [_membersSV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_membersLabel.mas_bottom).with.offset(20);
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
    _packagesIndex = btn.tag;
//    [self.makeOrderBar configWithData:@{@"price":_packagesData[_packagesIndex][@"CoursePackagesOrgPrice"]}];
    for (UIView * view in _packagesSV.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * packagesItem = (UIButton *)view;
            if (packagesItem == btn) {
                [self.coursePackagesAPIManager loadData];
                packagesItem.selected = YES;
                [packagesItem.layer setBorderColor:COLOR_ORANGE.CGColor];
            }else {
                packagesItem.selected = NO;
                [packagesItem.layer setBorderColor:COLOR_GRAY.CGColor];
            }
        }
    }
}

- (void)membersBtnClick:(UIButton *)button {
    _membersIndex = button.tag-100;
//    [self.makeOrderBar configWithData:@{@"studentID":_membersData[_membersIndex][@"PackagesMembersName"]}];
    for (UIView * view in _membersSV.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * memberItem = (UIButton *)view;
            if (memberItem == button) {
                [self.coursePackagesAPIManager loadData];
                memberItem.selected = YES;
                [memberItem.layer setBorderColor:COLOR_ORANGE.CGColor];
            }else {
                memberItem.selected = NO;
                [memberItem.layer setBorderColor:COLOR_GRAY.CGColor];
            }
        }
    }
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    if ([manager isKindOfClass:[CoursePackagesAPIManager class]]) {
        
        NSDictionary * resultDic = [manager fetchDataWithReformer:self.coursePackagesReformer];
        NSArray *packageArr = resultDic[@"packages"];
        NSArray *memberArr = resultDic[@"members"];
       
        [self.packagesData addObjectsFromArray:packageArr];
        [self.membersData addObjectsFromArray:memberArr];
        NSInteger studentID;
        if ([memberArr count]>0) {
            studentID=[self.membersData[_membersIndex][@"PackagesMembersId"] integerValue];
        } else
        {
            studentID=[UserModel currentUser].userID;
        }
        [self.makeOrderBar configWithData:@{@"price":self.packagesData[_packagesIndex][@"CoursePackagesOrgPrice"],@"objectID":self.packagesData[_packagesIndex][@"PackagesID"],@"studentID":@(studentID)}];
        [self.menuView addSubview:self.packagesSV];
        [self.menuView addSubview:self.membersSV];
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
             @"course_id":@(self.courseID),
             @"user_id":@([UserModel currentUser].userID)
             };
}

#pragma -
#pragma mark - getters and setters
- (NSMutableArray *)packagesData {
    if (!_packagesData) {
        _packagesData = [[NSMutableArray alloc] init];
    }
    return _packagesData;
}
- (NSMutableArray *)membersData {
    if (!_membersData) {
        _membersData = [[NSMutableArray alloc] init];
    }
    return _membersData;
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
- (UILabel *)membersLabel {
    if (!_membersLabel) {
        _membersLabel = [[UILabel alloc] init];
        _membersLabel.text = @"为谁购买课程";
        _membersLabel.font = H3;
    }
    return _membersLabel;
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
- (UIScrollView *)packagesSV {
    if (!_packagesSV) {
        float width = (Screen_Width - 16 * (_packagesData.count + 1))/3;
        _packagesSV = [[UIScrollView alloc] init];
        _packagesSV.contentSize = CGSizeMake((width + 16) * _packagesData.count + 16, 30);
        _packagesSV.bounces = NO;
        _packagesSV.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < _packagesData.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * (width + 16)+16, 0, width, 36)];
            btn.layer.cornerRadius = 3.0;
            btn.clipsToBounds = YES;
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:COLOR_GRAY.CGColor];
            NSString * str = [NSString stringWithFormat:@"%@", _packagesData[i][@"CoursePackagesNums"]];
            [btn setTitle:[NSString stringWithFormat:@"%@课时",str] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ORANGE forState:UIControlStateSelected];
            btn.titleLabel.font = H4;
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                btn.selected = YES;
                [btn.layer setBorderColor:COLOR_ORANGE.CGColor];
            }
            [self.packagesSV addSubview:btn];
        }
    }
    return _packagesSV;
}
- (UIScrollView *)membersSV {
    if (!_membersSV) {
        float width = (Screen_Width - 16 * (_membersData.count + 1))/3;
        _membersSV = [[UIScrollView alloc] init];
        _membersSV.contentSize = CGSizeMake((width + 16) * _membersData.count + 16, 30);
        _membersSV.bounces = NO;
        _membersSV.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < _membersData.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * (width + 16)+16, 0, width, 36)];
            btn.layer.cornerRadius = 3.0;
            btn.clipsToBounds = YES;
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:COLOR_GRAY.CGColor];
            NSString * str = [NSString stringWithFormat:@"%@", _membersData[i][@"PackagesMembersName"]];
            [btn setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ORANGE forState:UIControlStateSelected];
            btn.titleLabel.font = H4;
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(membersBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                btn.selected = YES;
                [btn.layer setBorderColor:COLOR_ORANGE.CGColor];
            }
            [self.membersSV addSubview:btn];
        }
    }
    return _membersSV;
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


@end
