//
//  ActivityController.m
//  jjb_user
//
//  Created by Maybe on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityController.h"
#import "ActivityListController.h"
#import "ParticipationController.h"
/**
 *  活动控制器
 */

@interface ActivityController ()
@property (nonatomic,strong) HMSegmentedControl  *tabbarControl;
@property (nonatomic,strong) ActivityListController *list;
@property (nonatomic,strong) ParticipationController *participation;
@end

@implementation ActivityController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView=self.tabbarControl;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     [self.view addSubview:self.list.view];
    [self.tabbarControl setSelectedSegmentIndex:0];
}


#pragma -
#pragma mark - event response
- (void)tabBarControlChangeValue:(id)sender{
    [self.list.view removeFromSuperview];
    [self.participation.view removeFromSuperview];
    if (_tabbarControl.selectedSegmentIndex==0) {
        [self.view addSubview:self.list.view];
    }
    else{
        UIViewController *controller=[[CTMediator sharedInstance] CTMediator_CheckIsLogin];
        if (controller==nil) {
            [self.view addSubview:self.participation.view];
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
        _tabbarControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"活动列表",@"我参与的"]];
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

- (ActivityListController *)list {
    
    if (!_list) {
        
        _list = [[ActivityListController alloc] init];
    }
    
    return _list;
}

- (ParticipationController *)participation {
    
    if (!_participation) {
        
        _participation = [[ParticipationController alloc] init];
    }
    
    return _participation;
}
@end
