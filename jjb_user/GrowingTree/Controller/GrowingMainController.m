//
//  GrowingMainController.m
//  jjb_user 成长主控制器
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingMainController.h"
#import "GrowingTreeController.h"
#import "MyGrowingController.h"

@interface GrowingMainController ()

@property (nonatomic,strong) GrowingTreeController *growingTree;
@property (nonatomic,strong) MyGrowingController *myGrowing;
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;


@end

@implementation GrowingMainController


#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView=self.tabbarControl;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.view addSubview:self.growingTree.view];
    [self.tabbarControl setSelectedSegmentIndex:0];
}


#pragma -
#pragma mark - event response
- (void)tabBarControlChangeValue:(id)sender{
    [self.growingTree.view removeFromSuperview];
    [self.myGrowing.view removeFromSuperview];
    if (_tabbarControl.selectedSegmentIndex==0) {
        [self.view addSubview:self.growingTree.view];
    }
    else{
        UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
        if (controller==nil) {
            [self.view addSubview:self.myGrowing.view];
        } else{
            UINavigationController  *navController=((AppDelegate*)[UIApplication sharedApplication].delegate).navController;
            [navController pushViewController:controller animated:YES];
        }
    }
}

#pragma -
#pragma mark - getters and setters
- (HMSegmentedControl *)tabbarControl {
    
    if (!_tabbarControl) {
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"社区动态",@"我的成长"]];
        _tabbarControl.backgroundColor=[UIColor clearColor];
        _tabbarControl.frame=CGRectMake(0, 0, 200, 44);
        _tabbarControl.selectionIndicatorColor = COLOR_WHITE;
        _tabbarControl.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_WHITE,NSFontAttributeName:H3};
        _tabbarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _tabbarControl.selectionIndicatorHeight = 2.0f;
        [_tabbarControl addTarget:self action:@selector(tabBarControlChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabbarControl;
}

- (GrowingTreeController *)growingTree {
    if (!_growingTree) {
        
        _growingTree = [[GrowingTreeController alloc] init];
    }
    return _growingTree;
}

- (MyGrowingController *)myGrowing {
    if (!_myGrowing) {
        _myGrowing = [[MyGrowingController alloc] init];
    }
    return _myGrowing;
}

@end
