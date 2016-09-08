//
//  MyFamilyInsertController.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyFamilyInsertController.h"
#import "FamilyAPIManager.h"
#import "FamilyInsertReformer.h"
#import "UpdateFamilyAPIManager.h"
#import "FamilyUpdateReformer.h"

@interface MyFamilyInsertController ()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate>

@property (nonatomic,strong) LDAPIBaseManager *familyAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> insertReformer;
@property (nonatomic,strong) LDAPIBaseManager *updateAPIManager;
@property (nonatomic,strong) id<ReformerProtocol> updateReformer;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UITextField *nameTF;
@property (nonatomic,strong) UILabel *chooseLabel;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UILabel *line1;
@property (nonatomic,strong) UILabel *line2;
@property (nonatomic,strong) UILabel *line3;
@property (nonatomic,strong) UILabel *uploadLabel;
@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UIButton *uploadBtn;
@property (nonatomic,strong) NSArray *titleArr;

@end

@implementation MyFamilyInsertController

#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE;
    self.navigationItem.title = @"家庭成员";
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameTF];
    [self.view addSubview:self.chooseLabel];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.uploadLabel];
    [self.view addSubview:self.headerImageV];
    [self.view addSubview:self.uploadBtn];

    [self layoutPageSubviews];
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right);
        make.centerY.equalTo(_nameLabel.mas_centerY);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(10);
        make.height.equalTo(@1);
    }];
    [_chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(_line1.mas_bottom).with.offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@50);
    }];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_chooseLabel.mas_right).with.offset(20);
        make.centerY.equalTo(_chooseLabel.mas_centerY);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseLabel.mas_bottom).with.offset(10);
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [_headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Screen_Width/3.0, Screen_Width/3.0));
    }];
    [_uploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImageV.mas_bottom).with.offset(10);
        make.centerX.equalTo(_headerImageV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_uploadLabel.mas_bottom).with.offset(20);
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [_uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3.mas_bottom).with.offset(20);
        make.centerX.equalTo(_uploadLabel.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}



#pragma -
#pragma mark - event respone
- (void)tapHeaderImageV {


}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    NSArray *resultData = [manager fetchDataWithReformer:self.insertReformer];
//    [self.arrData addObjectsFromArray:resultData];
//    self.pageIndex=[self.arrData count];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{

}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    if ([manager isKindOfClass:[_familyAPIManager class]]) {
        return @{
                 @"family_id":@([UserModel currentUser].myFamily.family_id),
                 @"role":@"",
                 @"name":self.nameTF.text,
                 @"userface":@""
                 };
    }else if ([manager isKindOfClass:[_updateAPIManager class]]) {
    
        return nil;
    }
    return nil;
}

#pragma -
#pragma mark - getters and setters
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"父亲",@"母亲",@"宝贝"];
    }
    return _titleArr;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"真实姓名：";
        _nameLabel.font = H2;
        _nameLabel.textColor = COLOR_GRAY;
    }
    return _nameLabel;
}
- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        
    }
    return _nameTF;
}
- (UILabel *)chooseLabel {
    if (!_chooseLabel) {
        _chooseLabel = [[UILabel alloc] init];
        _chooseLabel.text = @"选择";
        _chooseLabel.textColor = COLOR_GRAY;
        _chooseLabel.font = H2;
    }
    return _chooseLabel;
}
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        for (int i = 0; i < self.titleArr.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(i * (50 + 30), 0, 50, 30);
            btn.backgroundColor = JJBRandomColor;
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
            [_titleView addSubview:btn];
        }
    }
    return _titleView;
}
- (UILabel *)line1 {
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line1;
}
- (UILabel *)line2 {
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line2;
}
- (UILabel *)line3 {
    if (!_line3) {
        _line3 = [[UILabel alloc] init];
        _line3.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _line3;
}
- (UILabel *)uploadLabel {
    if (!_uploadLabel) {
        _uploadLabel = [[UILabel alloc] init];
        _uploadLabel.text = @"点击上传头像";
        _uploadLabel.font = H2;
        _uploadLabel.textAlignment = NSTextAlignmentCenter;
        _uploadLabel.textColor = COLOR_GRAY;
    }
    return _uploadLabel;
}
- (UIImageView *)headerImageV {
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc] init];
        _headerImageV.image = [UIImage imageNamed:@"btn_publish"];
        _headerImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderImageV)];
        [_headerImageV addGestureRecognizer:tapGR];
    }
    return _headerImageV;
}
- (UIButton *)uploadBtn {
    if (!_uploadBtn) {
        _uploadBtn = [[UIButton alloc] init];
        [_uploadBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
        _uploadBtn.backgroundColor = COLOR_ORANGE;
        _uploadBtn.layer.cornerRadius = 15;
        _uploadBtn.clipsToBounds = YES;
    }
    return _uploadBtn;
}
- (LDAPIBaseManager *)familyAPIManager {
    if (_familyAPIManager == nil) {
        _familyAPIManager = [FamilyAPIManager  sharedInstance];
        _familyAPIManager.delegate=self;
        _familyAPIManager.paramSource=self;
    }
    return _familyAPIManager;
}

- (id<ReformerProtocol>)insertReformer {
    
    if (!_insertReformer) {
        _insertReformer=[[FamilyInsertReformer alloc] init];
    }
    return _insertReformer;
}

@end
