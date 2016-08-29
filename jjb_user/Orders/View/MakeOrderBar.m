//
//  MakeOrderBar.m
//  jjb_user
//
//  Created by Aimee on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MakeOrderBar.h"
#import "OrdersDetailController.h"
#import "MakeOrderAPIManager.h"
@interface MakeOrderBar()<LDAPIManagerParamSourceDelegate,LDAPIManagerApiCallBackDelegate>
@property (nonatomic,assign) NSInteger orderType;
@property (nonatomic,assign) NSInteger objectID;
@property (nonatomic,assign) NSInteger shopID;

@property (nonatomic,strong) UIButton* payBtn;
@property (nonatomic,strong) UIView* lineView;
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) MakeOrderAPIManager *apiManager;
@end

@implementation MakeOrderBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.lineView];
        [self addSubview:self.payBtn];
        [self addSubview:self.priceLabel];
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
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_top).offset(10);
        make.left.mas_equalTo(self.lineView.mas_left).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_top).offset(10);
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
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@",data[@"price"]]];
    
}



#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    
    if ([manager isKindOfClass:[MakeOrderAPIManager class]]) {
        [self hideToastActivity];
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
                 @"shop_id":@([ShopModel currentShop].shopID)
                 };
}


#pragma -
#pragma mark - event respone

- (void)payBtnClick:(UIButton *)click {
    
    [self makeToastActivity:CSToastPositionCenter];
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
    if (controller==nil) {
        self.apiManager.methodName=[NSString stringWithFormat:@"gateway/makeOrder/%ld",(long)self.orderType];
        [self.apiManager loadData];
    } else{
        UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
        [navController pushViewController:controller animated:YES];
    }
}

- (UIButton *)payBtn {
    
    if (!_payBtn) {
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _payBtn.backgroundColor = COLOR_ORANGE;
        _payBtn.layer.cornerRadius = 2.0;
        _payBtn.clipsToBounds = YES;
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
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

@end
