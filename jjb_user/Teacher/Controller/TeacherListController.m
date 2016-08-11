//
//  TeacherListController.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherListController.h"

@implementation TeacherListController


#pragma
#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LIGHT_GRAY;
    [self setupNav];
}



#pragma
#pragma mark - private methods
-(void)setupNav
{
    self.navigationItem.title = @"所有老师";
}

@end
