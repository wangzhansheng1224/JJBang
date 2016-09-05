//
//  GoodsMakeOrderBar.m
//  jjb_user
//
//  Created by Owen on 16/9/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsMakeOrderBar.h"
#import "OrdersDetailController.h"
#import "MakeOrderAPIManager.h"

@interface GoodsMakeOrderBar ()<LDAPIManagerParamSourceDelegate,LDAPIManagerApiCallBackDelegate>

@property (nonatomic,assign) NSInteger orderType;
@property (nonatomic,assign) NSInteger objectID;
@property (nonatomic,assign) NSInteger shopID;
@property (nonatomic,assign) NSInteger studentID;
@property (nonatomic,strong) UIButton* payBtn;
@property (nonatomic,strong) UIView* lineView;
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UIButton *reduceBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) MakeOrderAPIManager *apiManager;

@end

@implementation GoodsMakeOrderBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _num = 1;
        [self addSubview:self.lineView];
        [self addSubview:self.payBtn];
        [self addSubview:self.priceLabel];
        [self addSubview:self.reduceBtn];
        [self addSubview:self.numberLabel];
        [self addSubview:self.addBtn];
    }
    return self;
}

#pragma -
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.equalTo(@1);
    }];
    [_reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_top).offset(10);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_reduceBtn.mas_centerY);
        make.left.mas_equalTo(_reduceBtn.mas_right).offset(1);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_numberLabel.mas_centerY);
        make.left.equalTo(_numberLabel.mas_right).offset(1);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addBtn.mas_centerY);
        make.left.mas_equalTo(_addBtn.mas_right).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLabel.mas_centerY);
        make.right.mas_equalTo(self.lineView.mas_right).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    self.orderType=[data[@"orderType"] integerValue];
    self.objectID=[data[@"objectID"] integerValue];
    self.shopID=[data[@"shopID"] integerValue];
    self.studentID=[data[@"studentID"] integerValue];
    float price = [data[@"price"] floatValue];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%.2f",price]];
    NSLog(@"%@++",data);
}


#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[MakeOrderAPIManager class]]) {
        NSDictionary *dic=[manager fetchDataWithReformer:nil];
        UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
        OrdersDetailController *order=[[OrdersDetailController alloc] init];
        order.orderNo=dic[@"data"][@"order"];
        [navController pushViewController:order animated:YES];
    }
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    [self hideToastActivity];
    NSDictionary *dic=[manager fetchDataWithReformer:nil];
    [self makeToast:dic[@"message"] duration:3.0f position:CSToastPositionCenter];
}

#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
    
    return @{
             @"id":@(self.objectID),
             @"user_id":@([UserModel currentUser].userID),
             @"shop_id":@([ShopModel currentShop].shopID),
             @"student_id":@(self.studentID)
             };
}

#pragma -
#pragma mark - event respone
- (void)payBtnClick:(UIButton *)click {
    
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
    if (controller==nil) {
        self.apiManager.methodName=[NSString stringWithFormat:@"gateway/makeOrder/%ld",(long)self.orderType];
        [self.apiManager loadData];
    } else{
        UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
        [navController pushViewController:controller animated:YES];
    }
}

- (void)reduceBtnClick {
    if (_num > 1) {
        _num --;
        self.numberLabel.text = [NSString stringWithFormat:@"%d",_num];
    }else {
        self.reduceBtn.userInteractionEnabled = NO;
        self.numberLabel.text = @"1";
    }
}

- (void)addBtnClick {
    _num ++;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",_num];
}

#pragma -
#pragma mark - getters and setters
- (UIButton *)payBtn {
    
    if (!_payBtn) {
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _payBtn.backgroundColor = COLOR_ORANGE;
        _payBtn.layer.cornerRadius = 2.0;
        _payBtn.clipsToBounds = YES;
        [_payBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_payBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLOR_LIGHT_GRAY;
    }
    return _lineView;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = COLOR_ORANGE;
        _priceLabel.font = H1;
        _priceLabel.text = @"￥128";
    }
    return _priceLabel;
}

-(MakeOrderAPIManager*) apiManager{
    if (!_apiManager) {
        _apiManager=[[MakeOrderAPIManager alloc] init];
        _apiManager.delegate=self;
        _apiManager.paramSource=self;
    }
    return _apiManager;
}
- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [[UIButton alloc] init];
        [_reduceBtn setImage:[UIImage imageNamed:@"goods_reduce"] forState:UIControlStateNormal];
        _reduceBtn.backgroundColor = COLOR_LIGHT_GRAY;
        [_reduceBtn addTarget:self action:@selector(reduceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setImage:[UIImage imageNamed:@"goods_add"] forState:UIControlStateNormal];
        _addBtn.backgroundColor = COLOR_LIGHT_GRAY;
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.backgroundColor = COLOR_LIGHT_GRAY;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.text = @"1";
    }
    return _numberLabel;
}

@end
