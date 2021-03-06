//
//  ActivityDetailHeader.m
//  jjb_user
//
//  Created by Aimee on 16/8/9.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailHeader.h"
#import "HMSegmentedControl.h"
#import "ActivityRegisterAPIManager.h"
#import "ActivityDetailKey.h"
#import "RHADScrollView.h"

@interface ActivityDetailHeader()<LDAPIManagerApiCallBackDelegate,LDAPIManagerParamSourceDelegate,RHADScrollViewDelegate>

@property (nonatomic,strong) UILabel *label_status;
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UILabel *label_location;
@property (nonatomic,strong) UILabel *label_time;
@property (nonatomic,strong) UIButton *signupButton;
@property (nonatomic,strong) UIView *view_line;
@property (nonatomic,assign) NSInteger activity_id;
@property (nonatomic,strong) NSMutableDictionary *data;
@property (nonatomic,strong) ActivityRegisterAPIManager *registerAPIManager;
@property (nonatomic,strong) RHADScrollView *adScrollView;
@property (nonatomic,strong) NSString *endTimeStr;//判断报名是否结束
@end

@implementation ActivityDetailHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.adScrollView];
        [self addSubview:self.label_status];
        [self addSubview:self.label_title];
        [self addSubview:self.label_location];
        [self addSubview:self.label_time];
        [self addSubview:self.signupButton];
        [self addSubview:self.view_line];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    
    UIView* superView=self;
    [_adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-100);
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
    }];
    [_label_status mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_adScrollView.mas_bottom).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(76, 30));
        make.left.equalTo(@0);
    }];
    [_label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_adScrollView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@30);
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-10);
    }];
    [_label_location mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_title.mas_bottom).with.offset(5);
        make.height.equalTo(@30);
        make.width.mas_equalTo(Screen_Width - 80);
        make.left.equalTo(superView.mas_left).with.offset(10);
    }];
    [_label_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label_location.mas_bottom).with.offset(8);
        make.height.equalTo(@17);
        make.right.mas_equalTo(_signupButton.mas_left);
        make.left.equalTo(superView.mas_left).with.offset(10);
    }];
    
    [_signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_view_line.mas_top).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(superView.mas_right).offset(-10);
    }];
    
    [_view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label_time.mas_bottom).with.offset(8);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@(10));
    }];
}

#pragma -
#pragma mark - configWithData
- (void)configWithData:(NSDictionary *)data{
    self.data=[[NSMutableDictionary alloc] initWithDictionary:data];
    self.activity_id=[data[kActivityDetailID] integerValue];
    self.endTimeStr = data[kActivityDetailEndTime];
    [self.label_title setText:data[kActivityDetailTitle]];
    [self.label_location setText:[NSString stringWithFormat:@"地址：%@",data[kActivityDetailAddress]]];
    [self.label_status setText:data[kActivityDetailState]];
    [self.label_time setText:[NSString stringWithFormat:@"时间：%@",data[kActivityDetailTime]]];
    
    NSArray * array = data[kActivityDetailImages];
    
    NSMutableArray * mutArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array.count; i++) {
        
        [mutArr addObject:[NSString stringWithFormat:@"%@%@", ImageServer, array[i][@"imagePath"]]];
    }
    
    _adScrollView.arrPic = mutArr;
    [_adScrollView play];

    if ([data[kActivityDetailIsRegist] compare:[NSNumber numberWithInt:1]]==NSOrderedSame) {
        [self.signupButton setEnabled:NO];
        [self.signupButton setTitle:@"已报名" forState:UIControlStateNormal];
        [self.signupButton setBackgroundColor:COLOR_GRAY];
    } else {
        //活动已结束
        if ([self.endTimeStr isEqualToString:@"1"]) {
            [self.signupButton setEnabled:NO];
            [self.signupButton setTitle:@"已结束" forState:UIControlStateNormal];
            [self.signupButton setBackgroundColor:COLOR_GRAY];

        }else{
            [self.signupButton setEnabled:YES];
            [self.signupButton setTitle:@"立即报名" forState:UIControlStateNormal];
            [self.signupButton setBackgroundColor:COLOR_ORANGE];
        }
    }
    
}

#pragma -
#pragma mark - Event
- (void) signUpClick:(id)sender{
   
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
    UINavigationController *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
    if (controller==nil) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"报名" message:@"请您确认是否报名?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancleAction];
        
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.registerAPIManager loadData];
        }];
        [alert addAction:sureAction];
        [navController presentViewController:alert animated:YES completion:nil];
    } else{
        [navController pushViewController:controller animated:YES];
    }
    
}

#pragma -
#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)apiManagerCallDidSuccess:(LDAPIBaseManager *)manager{
    [self makeToast:@"报名成功！"];
    [_data setValue:@(1) forKey:kActivityDetailIsRegist];
    [self configWithData:self.data];
}

- (void)apiManagerCallDidFailed:(LDAPIBaseManager *)manager{
    
    NSDictionary *data=[manager fetchDataWithReformer:nil];
    [self makeToast:data[@"message"]];
}
#pragma -
#pragma mark - LDAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager{
        return @{
                 @"activity_id":@(self.activity_id),
                 @"user_id":@([UserModel currentUser].userID)
                 };
}

#pragma -
#pragma mark - getters and setters
- (RHADScrollView *)adScrollView {

    if (!_adScrollView) {
        _adScrollView = [[RHADScrollView alloc] init];
        _adScrollView.adHeight = 173;
        _adScrollView.delegate = self;
    }
    return _adScrollView;
}

- (UILabel *)label_status {
    
    if (!_label_status) {
        
        _label_status = [[UILabel alloc] init];
        _label_status.textAlignment = NSTextAlignmentCenter;
        _label_status.font = H3;
        _label_status.textColor = COLOR_WHITE;
        _label_status.numberOfLines = 1;
        [_label_status setAlpha:0.3];
    }
    return _label_status;
}
- (UILabel *)label_title {
    
    if (!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        _label_title.font = H2;
        [_label_title sizeToFit];
        _label_title.textColor = [UIColor blackColor];
        _label_title.numberOfLines = 1;
    }
    return _label_title;
}
- (UILabel *)label_location {
    
    if (!_label_location) {
        
        _label_location = [[UILabel alloc] init];
        _label_location.textColor = COLOR_GRAY;
        _label_location.numberOfLines = 0;
        _label_location.lineBreakMode = NSLineBreakByWordWrapping;
        _label_location.font = H6;
        [_label_location sizeToFit];
    }
    return _label_location;
}
- (UILabel *)label_time {
    
    if (!_label_time) {
        
        _label_time = [[UILabel alloc] init];
        _label_time.textColor = COLOR_GRAY;
        [_label_time sizeToFit];
        _label_time.font = H6;
    }
    return _label_time;
}

-(UIButton*)signupButton{
    
    if (!_signupButton) {
        _signupButton=[[UIButton alloc] init];
        [_signupButton setTitle:@"立即报名" forState:UIControlStateNormal];
        [_signupButton addTarget:self action:@selector(signUpClick:) forControlEvents:UIControlEventTouchUpInside];
        _signupButton.titleLabel.font = H4;
        _signupButton.layer.cornerRadius = 3.0;
        _signupButton.clipsToBounds = YES;
    }
    return _signupButton;
}

-(UIView *)view_line{
    if (!_view_line) {
        _view_line=[[UIView alloc] init];
        _view_line.backgroundColor=COLOR_LIGHT_GRAY;
    }
    return _view_line;
}

-(ActivityRegisterAPIManager*) registerAPIManager{
    if (!_registerAPIManager) {
        _registerAPIManager=[ActivityRegisterAPIManager sharedInstance];
        _registerAPIManager.delegate=self;
        _registerAPIManager.paramSource=self;
    }
    return _registerAPIManager;
}

- (void)setInvalidate:(BOOL)invalidate {
    
    _adScrollView.invalidate = invalidate;
}

@end
