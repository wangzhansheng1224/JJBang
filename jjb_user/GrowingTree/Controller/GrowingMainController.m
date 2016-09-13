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
#import "IssueController.h"

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
    [self setNav];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.view addSubview:self.growingTree.view];
    [self.tabbarControl setSelectedSegmentIndex:0];
}

                                              
#pragma -
#pragma mark - set Nav
- (void)setNav {
    UIBarButtonItem *btn_issue = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"img_pulish"] highImage:[UIImage imageNamed:@"img_pulish"] target:self action:@selector(itemClick)];
    self.navigationItem.rightBarButtonItem = btn_issue;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil];
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
#pragma mark - event response
- (void)itemClick {
    IssueController *issueVC= [[IssueController alloc] init];
    UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin:issueVC];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma -
#pragma mark - getters and setters
- (HMSegmentedControl *)tabbarControl {
    
    if (!_tabbarControl) {
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"社区动态",@"我的成长"]];
        _tabbarControl.backgroundColor=[UIColor clearColor];
        _tabbarControl.frame=CGRectMake(0, 0, Screen_Width, 44);
        _tabbarControl.selectionIndicatorColor = COLOR_WHITE;
        _tabbarControl.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_WHITE,NSFontAttributeName:H1};
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
