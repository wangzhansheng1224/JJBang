//
//  ActivityIndexController.m
//  jjb_user
//
//  Created by Aimee on 16/8/10.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityIndexController.h"
#import "HMSegmentedControl.h"
#import "ActivityDetailHeader.h"
#import "ActivityDetailController.h"
#import "ActivityRegistrationController.h"

@interface ActivityIndexController ()
@property (nonatomic,strong) ActivityDetailHeader *headerView;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) ActivityRegistrationController  *registrationController;
@property (nonatomic,strong) ActivityDetailController  *detailController;
@end

@implementation ActivityIndexController

#pragma mark -
#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"活动详情";
    self.view.backgroundColor=COLOR_LIGHT_GRAY;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tabbarControl];
    [self.view addSubview:self.detailController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma -
#pragma mark - layoutPageSubviews
- (void)layoutPageSubviews {
    UIView *superView=self.view;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top);
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.height.mas_equalTo(@(267));
    }];
    [self.tabbarControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(10);
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.height.mas_equalTo(@(44));
    }];
    [self.detailController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabbarControl.mas_bottom).offset(10);
        make.left.mas_equalTo(superView.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.height.mas_equalTo(@(Screen_Height-280));
    }];
}


#pragma -
#pragma mark - event response

- (void) tabbarControllChangeValue:(id)sender{
    
    NSLog(@"%ld",_tabbarControl.selectedSegmentIndex);
}

#pragma -
#pragma mark - getters and setters

- (ActivityDetailHeader *) headerView{
    if (!_headerView) {
        _headerView=[[ActivityDetailHeader alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 273)];
        _headerView.backgroundColor=COLOR_WHITE;
    }
    return _headerView;
}

- (HMSegmentedControl *) tabbarControl
{
    if (!_tabbarControl) {
        _tabbarControl=[[HMSegmentedControl alloc] initWithSectionTitles:@[@"活动详情",@"报名信息",@"评价信息"]];
        _tabbarControl.frame=CGRectMake(0, 273, Screen_Width, 44);
        _tabbarControl.selectionIndicatorColor=COLOR_ORANGE;
        _tabbarControl.titleTextAttributes=@{NSForegroundColorAttributeName:COLOR_GRAY,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation=HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight=2.0f;
        [_tabbarControl addTarget:self action:@selector(tabbarControllChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabbarControl;
}

-(ActivityRegistrationController *) registrationController{
    
    if (!_registrationController) {
        _registrationController=[[ActivityRegistrationController alloc] init];
    }
    return _registrationController;
}

- (ActivityDetailController*)detailController
{
    if (!_detailController) {
        _detailController=[[ActivityDetailController alloc] init];
        _detailController.view.frame=CGRectMake(0, 327, Screen_Width, Screen_Height-327);
        _detailController.view.backgroundColor=[UIColor redColor];
    }
    return _detailController;
}

@end
