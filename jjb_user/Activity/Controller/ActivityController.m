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
#import "SponsorViewController.h"
#import "RHMenuViewController.h"


@interface ActivityController ()

@property (nonatomic,strong) ActivityListController *list;

@property (nonatomic,strong) ParticipationController *participation;

@property (nonatomic,strong) SponsorViewController *sponsor;

@property (nonatomic,strong) NSArray *arrayVC;

@property (nonatomic,strong) NSArray *titlesArray;

@end

@implementation ActivityController

#pragma mark -- life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:COLOR_ORANGE];
    [self createControllers];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)createControllers{
    
    self.arrayVC = @[self.list,self.participation];
    
    self.titlesArray = @[@"活动列表",@"我参与的"];
    
    RHMenuViewController *menu = [[RHMenuViewController alloc]initWithViewControllers:_arrayVC andMenuTitles:_titlesArray];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:menu.view];
    
    [self addChildViewController:menu];
    
//    [menu addChildViewController:self.list];
}




#pragma mark -- getters and setters
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

- (SponsorViewController *)sponsor {
    
    if (!_sponsor) {
        
        _sponsor = [[SponsorViewController alloc] init];
    }
    
    return _sponsor;
}

- (NSArray *)arrayVC {
    
    if (!_arrayVC) {
        
        _arrayVC = [[NSArray alloc] init];
    }
    
    return _arrayVC;
}

- (NSArray *)titlesArray {
    
    if (!_titlesArray) {
        
        _titlesArray = [[NSArray alloc] init];
    }
    
    return _titlesArray;
}
@end
